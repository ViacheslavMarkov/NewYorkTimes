//
//  API.swift
//  NYNetworking
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYUtilities

public class API<RequestObject: Encodable, ResponseObject: Decodable>: NSObject {
    private let requestObject: RequestObject

    public init(requestObject: RequestObject) {
        self.requestObject = requestObject
        super.init()
    }

    public func makeBaseURL() -> URL? {
        URL(string: BaseURL.baseURLString)
    }

    public func makePathComponent() -> String {
        ""
    }

    public func makeMethodType() -> HTTPMethodType {
        .get
    }

    public func makeDateFormatter() -> DateFormatter {
        .iso8601Full
    }

    public func makeHeaders() -> [String: String]? {
        [
            "Content-Type": "application/json",
//            "Accept": "*/*",
//            "Accept-Encoding": "gzip, deflate, br",
//            "Connection": "keep-alive"
        ]
    }

    public func makeQueryItems() -> [URLQueryItem]? {
        nil
    }

    public func makeRequestBody() -> Data? {
        switch requestObject {
        case is EmptyRequest:
            return nil
        default:
            return try? JSONEncoder().encode(requestObject)
        }
    }
    
    public func makeRequest() -> URLRequest? {
        let pathComponent = makePathComponent()
        guard let completeURL = makeBaseURL()?.appendingPathComponent(pathComponent) else {
            assertionFailure("completeURL for API is nil.")
            return nil
        }

        var urlComponents = URLComponents(url: completeURL, resolvingAgainstBaseURL: true)
        urlComponents?.queryItems = makeQueryItems()

        guard let url = urlComponents?.url else {
            assertionFailure("URL for API is nil.")
            return nil
        }

        var request = URLRequest(url: url)
        request.httpMethod = makeMethodType().rawValue
        request.httpBody = makeRequestBody()

        let headers = makeHeaders()
        headers?.forEach {
            request.setValue($1, forHTTPHeaderField: $0)
        }

        return request
    }
}
