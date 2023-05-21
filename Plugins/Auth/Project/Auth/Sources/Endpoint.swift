//
//  Endpoint.swift
//  Auth
//
//  Created by Milton Palaguachi on 5/21/23.
//

import Foundation

struct Endpoint {
    let requestType: RequestType
    let query: [String: String]
    
    func path(_ path: Path) -> URL? {
        URL(string: path.description, query: query, relativeTo: requestType.url)
    }
}

extension URL {
    init?(string: String, query: [String: String], relativeTo url: URL? = nil) {

        guard !query.isEmpty else {
            self.init(string: string, relativeTo: url)
            return
        }

        guard var components = URLComponents(string: string) else { return nil }
        components.queryItems = (components.queryItems ?? []) + query.map { URLQueryItem(name: $0.value, value: $0.key) }

        guard let url = components.url(relativeTo: url) else { return nil }
        self = url
    }
}

extension Endpoint {
    enum RequestType {
        case codeExchange
        case getRepos
        case getUser
        case signIn

        var url: URL {
            switch self {
                case .codeExchange:
                    return URL(string: "https://github.com")!
                case .getRepos:
                    return URL(string: "https://api.github.com")!
                case .getUser:
                    return URL(string: "https://api.github.com")!
                case .signIn:
                    return URL(string: "https://github.com")!
            }
        }
    }
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }
    
    enum Path: CustomStringConvertible {
        case codeExchange
        case getRepos(String)
        case getUser
        case signIn
        var description: String {
            switch self {
                case .codeExchange:
                    return "/login/oauth/access_token"
                case .getRepos(let username):
                    return "/users/\(username)/repos"
                case .getUser:
                    return "/user"
                case .signIn:
                    return "/login/oauth/authorize"
            }
        }
    }
}
