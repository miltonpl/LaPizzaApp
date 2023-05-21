//
//  Networking.swift
//  MBPlatform
//
//  Created by Milton Palaguachi on 5/21/23.
//

import Combine
import Foundation

public class Networking {
    enum State {
        case running
        case suspended
    }

    struct QueueRequest {
        let request: URLRequest
        let promice: (Result<URLRequest, Never>) -> Void
    
        func send() {
            self.promice(.success(request))
        }
    }

    static let stateQueue = DispatchQueue(label: "com.Networking.stateQueue")
    static let networkQueue = DispatchQueue(label: "com.Networking.networkQueue")

    private let session: URLSession
    private var state: State {
        get {
            Self.stateQueue.sync { _state }
        }
        set {
            Self.stateQueue.sync {
                switch (_state, newValue) {
                    case (.suspended, .running):
                        queues.forEach { request in
                            request.send()
                        }
                        queues.removeAll()
                    default:
                        break
                }
            }
        }
    }

    private var _state: State = .running
    private var queues = [QueueRequest]()

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func running() {
        state = .running
    }

    public func suspend() {
        state = .suspended
    }

    public func requestPublisher(with url: URL) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        requestPublisher(with: .init(url: url))
            .eraseToAnyPublisher()
    }

    public func requestPublisher(with request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        switch state {
            case .running:
                return sendPublisher(with: request)
            case .suspended:
                return queuePublisher(with: request)
        }
    }

    private func queuePublisher(with request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        return Future<URLRequest, Never> { [weak self] promise in
            Self.stateQueue.sync {
                self?.queues.append(.init(request: request, promice: promise))
            }
        }
        .setFailureType(to: Error.self)
        .flatMap { return self.sendPublisher(with: $0) }
        .eraseToAnyPublisher()
    }

    private func sendPublisher(with request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        requestPublisher(with: request)
            .subscribe(on: Self.stateQueue)
            .receive(on: Self.networkQueue)
            .eraseToAnyPublisher()
    }

    private func respondPublisher(with request: URLRequest) -> AnyPublisher<URLSession.DataTaskPublisher.Output, Error> {
        session
            .dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
