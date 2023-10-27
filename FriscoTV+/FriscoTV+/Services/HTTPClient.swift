//
//  HTTPClient.swift
//  FriscoTV+
//
//  Created by Blaine Beltran on 10/11/23.
//

import Foundation

/// URLSession abstraction of the data(for:delegate:) method.
///
/// This will help with testability so we do not hit the network when making a request in test files.
protocol DataProviding {
    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}

/// Extend URLSession to adopt the DataProviding protocol so that we can still use URLSession.shared
extension URLSession: DataProviding {}

/// Extension is necessary in order to remove the need to pass **delegate = nil** at the call site,
extension DataProviding {
    func data(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request, delegate: nil)
    }
}

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers : [String: String]? { get }
    var body: [String: String]? { get }
    
    // For now I am using this to send a page so that we can paginate the results.
    // This could break down as we need more query items in the URL besides the page number.
    var parameters: [String: Int]? { get }
}

extension Endpoint {
    var scheme: String {
        "https"
    }
    
    var host: String {
        "api.themoviedb.org"
    }
    
    var queryItems: [URLQueryItem]? {
        return parameters?.map { URLQueryItem(name: $0, value: String($1)) }
    }
}

/// Errors used in the HTTPClient
enum HTTPClientError: Error {
    
    /// Unable to create valid url
    case invalidURL(url: String)
    
    /// invalid response type
    case invalidResponseType
    
    /// 400 status code
    case badClientRequest
    
    /// 401 status code
    case unauthorized
    
    /// 403 status code
    case forbidden
    
    /// 404 status code
    case notFound
    
    /// 408 status code
    case requestTimeOut
    
    /// 500-511 status code
    case severError(error: Error)
    
    /// Problem decoding response
    case decodeError
    
    /// Generic error to encapsulate everything else
    case unknown(error: Error)
    
    case unknownRequestError
}

struct HTTPClient {
    let session: DataProviding
    
    init(session: DataProviding = URLSession.shared) {
        self.session = session
    }
    
    func makeRequest<T: Codable>(for endpoint: Endpoint, objectType: T.Type) async throws -> T {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.queryItems
        
        guard let url = urlComponents.url else {
            throw HTTPClientError.invalidURL(url: String(describing: urlComponents.url))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.headers
        
        if let body = endpoint.body {
            // TODO: Investing if this is actually needed
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let HTTPResponse = response as? HTTPURLResponse else { throw HTTPClientError.invalidResponseType }
            switch HTTPResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(objectType.self, from: data)
                return model
            case 400: throw HTTPClientError.badClientRequest
            case 401: throw HTTPClientError.unauthorized
            case 403: throw HTTPClientError.forbidden
            case 404: throw HTTPClientError.notFound
            case 408: throw HTTPClientError.requestTimeOut
            default: throw HTTPClientError.unknownRequestError
            }
        } catch {
            throw HTTPClientError.unknown(error: error)
        }
    }
}
