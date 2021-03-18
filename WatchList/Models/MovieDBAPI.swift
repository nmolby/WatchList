//
//  MovieDBAPI.swift
//  WatchList
//
//  Created by David M Reed on 2/13/21.
//

import Foundation
import Combine

extension Fail where Failure == FetchDecodeError {
    static func badRequest() -> AnyPublisher<Output, FetchDecodeError> {
        return Fail(error: FetchDecodeError.badRequest).eraseToAnyPublisher()
    }
}

struct MovieDBAPI {
    let apiKey: String

    func movieSearch(match: String) -> AnyPublisher<MovieSearch, FetchDecodeError> {
        if let request = requestForMovieSearch(match: match) {
            return MovieSearch.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func tvSearch(match: String) -> AnyPublisher<TVSearch, FetchDecodeError> {
        if let request = requestForTVSearch(match: match) {
            return TVSearch.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func personSearch(match: String) -> AnyPublisher<PersonSearch, FetchDecodeError> {
        if let request = requestForPersonSearch(match: match) {
            return PersonSearch.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func movie(id: Int) -> AnyPublisher<Movie, FetchDecodeError> {
        if let request = requestForMovie(id: id) {
            return Movie.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func movieCredits(id: Int64) -> AnyPublisher<MovieCredits, FetchDecodeError> {
        if let request = requestForMovieCredits(id: id) {
            return MovieCredits.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func tv(id: Int) -> AnyPublisher<TV, FetchDecodeError> {
        if let request = requestForTV(id: id) {
            return TV.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func tvSeason(id: Int, season: Int) -> AnyPublisher<TVSeason, FetchDecodeError> {
        if let request = requestForTVSeason(id: id, season: season) {
            return TVSeason.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func tvEpisode(id: Int, season: Int, episode: Int) -> AnyPublisher<TVEpisode, FetchDecodeError> {
        if let request = requestForTVEpisode(id: id, season: season, episode: episode) {
            return TVEpisode.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func tvCredits(id: Int) -> AnyPublisher<TVCredits, FetchDecodeError> {
        if let request = requestForTVCredits(id: id) {
            return TVCredits.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func person(id: Int) -> AnyPublisher<Person, FetchDecodeError> {
        if let request = requestForPerson(id: id) {
            return Person.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    func personCredits(id: Int) -> AnyPublisher<PersonCredits, FetchDecodeError> {
        if let request = requestForPersonCredits(id: id) {
            return PersonCredits.fetchFrom(request: request)
        }
        return Fail.badRequest()
    }

    // MARK: - URLRequests

    func requestForMovieSearch(match: String) -> URLRequest? {
        if let s = match.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            if let url = URL(string: "\(MovieDBAPI.baseURL)/search/movie?query=\(s)&page=1&include_adult=false") {
                return request(url: url)
            }
        }
        return nil
    }

    func requestForTVSearch(match: String) -> URLRequest? {
        if let s = match.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            if let url = URL(string: "\(MovieDBAPI.baseURL)/search/tv?query=\(s)&page=1&include_adult=false") {
                return request(url: url)
            }
        }
        return nil
    }

    func requestForPersonSearch(match: String) -> URLRequest? {
        if let s = match.addingPercentEncoding(withAllowedCharacters: .alphanumerics) {
            if let url = URL(string: "\(MovieDBAPI.baseURL)/search/person?query=\(s)&page=1&include_adult=false") {
                return request(url: url)
            }
        }
        return nil
    }

    func requestForMovie(id: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/movie/\(id)") {
            return request(url: url)
        }
        return nil
    }

    func requestForMovieCredits(id: Int64) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/movie/\(id)/credits") {
            return request(url: url)
        }
        return nil
    }

    func requestForTV(id: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/tv/\(id)") {
            return request(url: url)
        }
        return nil
    }

    func requestForTVSeason(id: Int, season: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/tv/\(id)/season/\(season)") {
            return request(url: url)
        }
        return nil
    }

    func requestForTVEpisode(id: Int, season: Int, episode: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/tv/\(id)/season/\(season)/episode/\(episode)") {
            return request(url: url)
        }
        return nil
    }

    func requestForTVCredits(id: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/tv/\(id)/credits") {
            return request(url: url)
        }
        return nil
    }

    func requestForPerson(id: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/person/\(id)") {
            return request(url: url)
        }
        return nil
    }

    func requestForPersonCredits(id: Int) -> URLRequest? {
        if let url = URL(string: "\(MovieDBAPI.baseURL)/person/\(id)/combined_credits") {
            return request(url: url)
        }
        return nil
    }

    func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("Content-Type", forHTTPHeaderField: "application/json;charset=utf-8")
        return request
    }

    static var baseURL = "https://api.themoviedb.org/3"
}
