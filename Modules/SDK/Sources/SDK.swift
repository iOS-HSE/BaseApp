import Foundation
import Core

public typealias NetworkingResponse = (body: Data, statusCode: Int, headers: [String: String])

public protocol NetworkingProtocol {
    func request(_ request: URLRequest, completion: @escaping (Swift.Result<NetworkingResponse, NetworkingError>) -> Void) -> Cancellable?
}

public protocol HTTPLibrary {
    func send(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable?
}

public class Networking: NetworkingProtocol {
    let httpLibrary: HTTPLibrary
    
    public init(httpLibrary: HTTPLibrary = URLSession.shared) {
        self.httpLibrary = httpLibrary
    }
    
    @discardableResult
    public func request(_ request: URLRequest, completion: @escaping (Swift.Result<NetworkingResponse, NetworkingError>) -> Void) -> Cancellable? {
        guard request.url != nil else {
            completion(.failure(.invalidURL))
            return nil
        }
        return httpLibrary.send(request: request) { data, response, error in
            if let error = error {
                let nsError = error as NSError
                if nsError.domain == URLError.errorDomain {
                    let urlError = URLError.Code(rawValue: nsError.code)
                    completion(.failure(.unsuccessfulHTTPResponse(urlError)))
                } else {
                    completion(.failure(.genericError(error)))
                }
            } else if let data = data, let response = response as? HTTPURLResponse, let headers = response.allHeaderFields as? [String: String] {
                completion(.success((body: data, statusCode: response.statusCode, headers: headers)))
            } else {
                completion(.failure(.invalidResponseFormat))
            }
        }
    }
}

public enum HTTPMethod : String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case patch  = "PATCH"
    case delete = "DELETE"
}

public class SDK {
    let networking: NetworkingProtocol
    let decoder: JSONDecoder
    let scheduler: SchedulerProtocol
    
    public init(networking: NetworkingProtocol,
                scheduler: SchedulerProtocol,
                decoder: JSONDecoder = JSONDecoder()) {
        self.networking = networking
        self.scheduler = scheduler
        self.decoder = decoder
    }
    
    public func buildRequest(path: URL, method: HTTPMethod,  headers: [String: String] = [:], parameters: [String: Any] = [:], encoding: ParameterEncoder = URLParameterEncoder(), interceptors: [URLRequestInterceptor] = []) -> URLRequest {
        var request = URLRequest(url: path,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 30.0).apply {
                                    $0.allHTTPHeaderFields = headers
                                    $0.httpMethod = method.rawValue
                                    try? encoding.encode(urlRequest: &$0, with: parameters)
                                 }
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return interceptors.reduce(request) { request, interceptor in
            interceptor.intercept(request: request)
        }
    }
    
    public func perform<T: Decodable>(request: URLRequest, completion: @escaping (Result<T, APIError>) -> Void) -> Cancellable? {
        return networking.request(request) { result in
            switch result {
            case let .success(response):
                let body = try? self.decoder.decode(Message.self, from: response.body)
                switch response.statusCode {
                    case 200 ..< 300:
                        do {
                            let responseObject = try self.decoder.decode(Response<T>.self, from: response.body)
                            if let data = responseObject.data {
                                self.report(data: data, on: completion)
                            } else {
                                self.report(error: .decodingFailed, on: completion)
                            }
                        } catch(let decodingError) {
                            print("Decoding error", decodingError)
                            self.report(error: .decodingFailed, on: completion)
                        }
                    case 401:
                        self.report(error: .applicationError(.authenticationError, message: body?.message), on: completion)
                    case 400 ..< 500:
                        self.report(error: .applicationError(.clientError, message: body?.message), on: completion)
                    default:
                        self.report(error: .applicationError(.serverError, message: body?.message), on: completion)
                }
            case .failure:
                self.report(error: .connectionFailed, on: completion)
            }
        }
    }
    
    private func report<T>(data: T, on completion: @escaping (Result<T, APIError>) -> Void) {
        scheduler.dispatch {
            completion(.success(data))
        }
    }
    
    private func report<T>(error: APIError, on completion: @escaping (Result<T, APIError>) -> Void) {
        scheduler.dispatch {
            completion(.failure(error))
        }
    }
}

public enum APIError: Error, Equatable {
    
    case applicationError(StatusCodeBasedError, message: String?)
    case decodingFailed
    case connectionFailed
    
    public var alertMessage: String {
        switch self {
            case .decodingFailed: return "Something went wrong. Please contact our support team"
            case .connectionFailed: return "The connection appears to be offline. Please try again"
            case let .applicationError(.authenticationError, message: message): return message ?? "Looks like your session expired. Please try to log in again"
            case let .applicationError(.clientError, message: message): return message ?? "Something went wrong. Please contact our support team"
            case let .applicationError(.serverError, message: message): return message ?? "Something went wrong. Please check your connection while we check our servers"
        }
    }
    
    public static func ==(lhs: APIError, rhs: APIError) -> Bool {
        switch (lhs, rhs) {
            case let (.applicationError(lhsCode, lhsMessage), .applicationError(rhsCode, rhsMessage)):
                return lhsCode == rhsCode && lhsMessage == rhsMessage
            case (.decodingFailed, .decodingFailed), (.connectionFailed, .connectionFailed):
                return true
            default:
                return false
        }
    }
    
    public enum StatusCodeBasedError: Equatable {
        case authenticationError
        case clientError
        case serverError
    }
}

struct Response<T: Decodable>: Decodable {
    let data: T?
    let message: String?
    let code: Int?
}

struct Message: Decodable {
    let message: String?
}

public enum NetworkingError: Error {
    case invalidURL
    case invalidResponseFormat
    case unsuccessfulHTTPResponse(URLError.Code)
    case genericError(Error)
}

public protocol Cancellable {
    func cancel()
}

extension URLSessionDataTask: Cancellable {}

extension URLSession: HTTPLibrary {
    public func send(request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Cancellable? {
        let task = dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}

extension URLRequest: Apply {
    public mutating func addHeader(key: String, value: String) {
        allHTTPHeaderFields?[key] =  value
    }
}

public protocol URLRequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest
}

public protocol SchedulerProtocol {
    func dispatch(execute: @escaping () -> Void)
}

public class MainThreadScheduler: SchedulerProtocol {
    public init() {}
    
    public func dispatch(execute: @escaping () -> Void) {
        DispatchQueue.main.async(group: nil, qos: .default, flags: [], execute: execute)
    }
}
