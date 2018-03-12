import Foundation
import RxSwift
#if !COCOAPODS
    import Moya
#endif

extension MoyaProvider: ReactiveCompatible {}

public extension Reactive where Base: MoyaProviderType {
    
    /// Designated request-making method.
    ///
    /// - Parameters:
    ///   - token: Entity, which provides specifications necessary for a `MoyaProvider`.
    ///   - callbackQueue: Callback queue. If nil - queue from provider initializer will be used.
    /// - Returns: Single response object.
    #if !USE_CACHE
    public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return base.rxRequest(token, callbackQueue: callbackQueue)
    }
    #else
    public func request(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        return base.rxRequest(token, callbackQueue: callbackQueue)
    }
    #endif
    
    /// Designated request-making method with progress.
    public func requestWithProgress(_ token: Base.Target, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        return base.rxRequestWithProgress(token, callbackQueue: callbackQueue)
    }
}

internal extension MoyaProviderType {
    
    
    #if !USE_CACHE
    internal func rxRequest(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Single<Response> {
        return Single.create { [weak self] single in
            let cancellableToken = self?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                case let .success(response):
                    single(.success(response))
                case let .failure(error):
                    single(.error(error))
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    #else
    internal func rxRequest(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Observable<Response> {
        return Observable<Response>.create { [weak self] observer in
            if let cache = token.cacheable, cache.enable {
                let cacheKey = cache.cacheKey
                let flush = cache.flush
                if let entry = try? storage.entry(ofType: ResponseSink.self, forKey: cacheKey) {
                    observer.onNext(entry.object.response)
                    if !flush {
                        observer.onCompleted()
                        return Disposables.create {
    
                        }
                    }
                }
            }
            let cancellableToken = self?.request(token, callbackQueue: callbackQueue, progress: nil) { result in
                switch result {
                    case let .success(response):
                        observer.onNext(response)
                        token.cacheable?.save(response)
                        observer.onCompleted()
                    case let .failure(error):
                        observer.onError(error)
                }
            }
    
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
    }
    #endif
    
    internal func rxRequestWithProgress(_ token: Target, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        let progressBlock: (AnyObserver) -> (ProgressResponse) -> Void = { observer in
            return { progress in
                observer.onNext(progress)
            }
        }
        
        let response: Observable<ProgressResponse> = Observable.create { [weak self] observer in
            let cancellableToken = self?.request(token, callbackQueue: callbackQueue, progress: progressBlock(observer)) { result in
                switch result {
                case .success:
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create {
                cancellableToken?.cancel()
            }
        }
        
        // Accumulate all progress and combine them when the result comes
        return response.scan(ProgressResponse()) { last, progress in
            let progressObject = progress.progressObject ?? last.progressObject
            let response = progress.response ?? last.response
            return ProgressResponse(progress: progressObject, response: response)
        }
    }
}
