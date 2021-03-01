//
//  DecodableExtensions.swift
//  WatchList
//
//  Created by David M Reed on 2/13/21.
//

import Foundation
import Combine

//struct APIError: Decodable, Error {
//    let statusCode: Int
//}

enum FetchDecodeError: Error {
    case unknown
    case badRequest
    case networkError(Int)
    case jsonError(Error)
    case unknownError(Error)
}

// publisher code loosely based on code in Practical Combine by Donny Wals (Using Combine for Networking chapter)

extension Decodable {
    static func noRefresh() -> AnyPublisher<Bool, Never> {
        Just(false).eraseToAnyPublisher()
    }

    static func fetchFrom(url: URL, headers: [String: String] = [:]) -> AnyPublisher<Self, FetchDecodeError> {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        for (header, value) in headers {
            request.setValue(value, forHTTPHeaderField: header)
        }
        return fetchFrom(request: request)
    }

    static func fetchFrom(request: URLRequest) -> AnyPublisher<Self, FetchDecodeError> {
        URLSession.shared.dataTaskPublisher(for: request).tryMap(
            { result in
                let decoder = JSONDecoder()
                guard let urlResponse = result.response as? HTTPURLResponse else {
                    throw FetchDecodeError.unknown
                }
                guard (200...299).contains(urlResponse.statusCode) else {
                    throw FetchDecodeError.networkError(urlResponse.statusCode)
                }
                return try decoder.decode(Self.self, from: result.data)
            })
            .mapError { error in
                if let error = error as? DecodingError {
                    return FetchDecodeError.jsonError(error)
                } else if let error = error as? FetchDecodeError {
                    return error
                }
                return FetchDecodeError.unknownError(error)
            }
            .eraseToAnyPublisher()
    }

//    static func fetchFrom(request: URLRequest, refreshToken: @escaping (() -> AnyPublisher<Bool, Never>)) -> AnyPublisher<Self, RequestError> {
//        URLSession.shared.dataTaskPublisher(for: request).tryMap(
//            { result in
//                let decoder = JSONDecoder()
//                guard let urlResponse = result.response as? HTTPURLResponse else {
//                    throw RequestError.unknown
//                }
//                if urlResponse.statusCode == 401 {
//                    return refreshToken()
//                        .tryMap({ success -> AnyPublisher<Self, RequestError> in
//                                    guard success else { throw RequestError.unknown }
//                                    return fetchFrom(request: request)
//
//                        }).mapError { error in
//                            return RequestError.unknown
//                        }
//                        .switchToLatest().eraseToAnyPublisher()
//
//                }
//
//                guard (200...299).contains(urlResponse.statusCode) else {
//                    throw RequestError.networkError(urlResponse.statusCode)
//                }
//                return try decoder.decode(Self.self, from: result.data)
//            })
//            .mapError { error in
//                if let error = error as? DecodingError {
//                    return RequestError.jsonError(error)
//                } else if let error = error as? RequestError {
//                    return error
//                }
//                return RequestError.unknown
//            }
//            .eraseToAnyPublisher()
//    }
//
//    static func fetchFrom(request: URLRequest, refreshToken: @escaping (() -> AnyPublisher<Bool, Never>) = Self.noRefresh) -> AnyPublisher<Self, Error> {
//        URLSession.shared.dataTaskPublisher(for: request).tryMap(
//            { result in
//                let decoder = JSONDecoder()
//                guard let urlResponse = result.response as? HTTPURLResponse, (200...299).contains(urlResponse.statusCode) else {
//                    let apiError = try decoder.decode(APIError.self, from: result.data)
//                    throw apiError
//                }
//                return try decoder.decode(Self.self, from: result.data)
//            })
//            .tryCatch({ error -> AnyPublisher<Self, Error> in
//                guard let apiError = error as? APIError, apiError.statusCode == 401 else {
//                    throw error
//                }
//                return refreshToken()
//                    .tryMap({ success -> AnyPublisher<Self, Error> in
//                                guard success else { throw error }
//                                return fetchFrom(request: request) }).switchToLatest().eraseToAnyPublisher()
//            }) .eraseToAnyPublisher()
//    }
}
