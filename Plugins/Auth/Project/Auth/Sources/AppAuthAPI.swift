//
//  AppAuthAPI.swift
//  Auth
//
//  Created by Milton Palaguachi on 5/21/23.
//

import AuthenticationServices
import Foundation
import Persistance
import MBPlatform
import Combine

public protocol AppAuthAPI {
    
}

class AppAuthManger: NSObject, AppAuthAPI {
    enum QueryItemKey {
        static let clientId = "client_id"
        static let clientSecret = "client_secret"
        static let code = "code"
    }

    struct Client {
        static let callbackURLScheme = ""
        static let id = ""
        static let secret = ""
    }

    enum State {
    case errror(Error)
    case success
    case notStarted
    case loading
    }

    @Published private var state: State = .notStarted
    private var subcribers = Set<AnyCancellable>()
    private let networking: Networking

    init(networking: Networking) {
        self.networking = networking
    }

    func signIn() {
        state = .loading
        let endpoint: Endpoint = .init(requestType: .signIn, query: [:])
        guard let url = endpoint.path(.signIn) else {
            state = .errror(RequestError.invalidURL)
            return
        }
        requestAuthentication(url: url, callbackURLScheme: Client.callbackURLScheme)
            .asResult()
            .sink { [weak self] result in
                switch result {
                    case .success(let url):
                        self?.requestCodeExchange(url: url)
                    case .failure(let error):
                        self?.state = .errror(error)
                }
                
            }.store(in: &subcribers)
    }
    
    func requestCodeExchange(url: URL) {
        let queryItems = URLComponents(string: url.absoluteString)?.queryItems ?? []
        let code = queryItems.first(where: { $0.name == "code" })?.value
        var query = [String: String]()
        query[Client.id] = code
        let endpoint: Endpoint = .init(requestType: .codeExchange, query: query)

        guard let url = endpoint.path(.codeExchange) else {
            return
        }
        networking
            .requestPublisher(with: url)
            .receive(on: DispatchQueue.main)
            .asResult()
            .sink { [weak self] result in
                switch result {
                    case .success:
                        self?.state = .success
                    case .failure(let error):
                        self?.state = .errror(error)
                }
            }
            .store(in: &subcribers)
//        let networkRequest = NetworkRequest.RequestType.codeExchange(code: code).networkRequest() else {
    
//  networkRequest.start(
//    responseType: String.self) { result in
//      switch result {
//        case .success:
//          self?.getUser()
//        case .failure(let error):
//          print("Failed to exchange access code for tokens: \(error)")
//      }
//    }
    }

    func requestAuthentication(url: URL, callbackURLScheme: String) -> AnyPublisher<URL, Error> {
        Future<URL, Error> { [weak self] promise in
            self?.requestAuthentication(
                url: url,
                callbackURLScheme: callbackURLScheme,
                completionHandler: promise)
        }
        .eraseToAnyPublisher()
    }
    
    func requestAuthentication(url: URL, callbackURLScheme: String, completionHandler: @escaping(Result<URL, Error>) -> Void ) {
        let authenticationSession = ASWebAuthenticationSession(
            url: url,
            callbackURLScheme: callbackURLScheme,
            completionHandler: { callbackURL, error in
                guard error == nil,
                      let callbackURL = callbackURL else {
                    completionHandler(.failure(error ?? RequestError.unknown))
                    return
                }
                completionHandler(.success(callbackURL))
            }
        )
        authenticationSession.presentationContextProvider = self
        authenticationSession.prefersEphemeralWebBrowserSession = true
        if !authenticationSession.start() {
            let message = "Failed to start ASWebAuthenticatioSession"
            completionHandler(.failure(RequestError.error(message)))
        }
    }
}

extension Publisher {
    func asResult() -> AnyPublisher<Result<Output, Error>, Never> {
        map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}

extension AppAuthManger: ASWebAuthenticationPresentationContextProviding {
  func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    return window ?? ASPresentationAnchor()
  }
}

extension AppAuthManger {
    
    enum RequestError: Error {
        case invalidResponse
        case networkCreationError
        case otherError
        case sessionExpired
        case statusCode(Int)
        case invalidURL
        case unknown
        case error(String)
    }
}
