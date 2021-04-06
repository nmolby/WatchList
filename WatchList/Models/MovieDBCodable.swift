//
//  MovieDBJSON.swift
//  WatchList
//
//  Created by David M Reed on 2/14/21.
//

import Foundation
import CoreData


protocol ContentType {
    var releaseDate: String? {get}
    var id: Int64 {get}
    var name: String {get}
    var popularity: Double {get}
    var posterPath: String? {get}
    var voteAverage: Double {get}
    var voteCount: Int64 {get}
}

// MARK: - Movie
struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let belongsToCollection: BelongsToCollection
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID, originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let releaseDate: String
    let revenue, runtime: Int
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1, name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

// MARK: - TV
struct TV: Codable {
    let backdropPath: String
    let createdBy: [CreatedBy]
    let episodeRunTime: [Int]
    let firstAirDate: String
    let genres: [Genre]
    let homepage: String
    let id: Int
    let inProduction: Bool
    let languages: [String]
    let lastAirDate: String
    let lastEpisodeToAir: LastEpisodeToAir
    let name: String
    let nextEpisodeToAir: String?
    let networks: [Network]
    let numberOfEpisodes, numberOfSeasons: Int
    let originCountry: [String]
    let originalLanguage, originalName, overview: String
    let popularity: Double
    let posterPath: String
    let productionCompanies: [Network]
    let productionCountries: [ProductionCountry]
    let seasons: [Season]
    let spokenLanguages: [SpokenLanguage]
    let status, tagline, type: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - CreatedBy
struct CreatedBy: Codable {
    let id: Int
    let creditID, name: String
    let gender: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - LastEpisodeToAir
struct LastEpisodeToAir: Codable {
    let airDate: String
    let episodeNumber, id: Int
    let name, overview, productionCode: String
    let seasonNumber: Int
    let stillPath: String
    let voteAverage, voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case id, name, overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Network
struct Network: Codable {
    let name: String
    let id: Int
    let logoPath, originCountry: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - Season
struct Season: Codable {
    let airDate: String
    let episodeCount, id: Int
    let name, overview, posterPath: String
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - TVSeason
struct TVSeason: Codable {
    let id, airDate: String
    let episodes: [TVEpisode]
    let name, overview: String
    let tvSeasonID: Int
    let posterPath: String?
    let seasonNumber: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes, name, overview
        case tvSeasonID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

// MARK: - Episode
struct TVEpisode: Codable {
    let airDate: String
    let episodeNumber: Int
    let guestStars: [GuestStar]
    let id: Int
    let name, overview, productionCode: String
    let seasonNumber: Int
    let stillPath: String
    let voteAverage, voteCount: Int

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case guestStars = "guest_stars"
        case id, name, overview
        case productionCode = "production_code"
        case seasonNumber = "season_number"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // MARK: - GuestStar
    struct GuestStar: Codable {
        let character, creditID: String
        let order: Int
        let adult: Bool
        let gender, id: Int
        let knownForDepartment, name, originalName: String
        let popularity: Double
        let profilePath: String

        enum CodingKeys: String, CodingKey {
            case character
            case creditID = "credit_id"
            case order, adult, gender, id
            case knownForDepartment = "known_for_department"
            case name
            case originalName = "original_name"
            case popularity
            case profilePath = "profile_path"
        }
    }
}

// MARK: - TVSearch
struct TVSearch: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Result
    struct Result: Codable, ContentType {
        var releaseDate: String?
        
        let backdropPath: String?
        let genreIDS: [Int]
        let id: Int64
        let name: String
        let originCountry: [String]
        let originalLanguage, originalName, overview: String
        let popularity: Double
        let posterPath: String?
        let voteAverage: Double
        let voteCount: Int64

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case releaseDate = "first_air_date"
            case genreIDS = "genre_ids"
            case id, name
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview, popularity
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// MARK: - MovieSearch
struct MovieSearch: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Result
    struct Result: Codable, ContentType {
        var releaseDate: String?
        
        let adult: Bool
        let backdropPath: String?
        let genreIDS: [Int]
        let id: Int64
        let originalLanguage, name, overview: String
        let popularity: Double
        let posterPath: String?
        let title: String
        let video: Bool
        let voteAverage: Double
        let voteCount: Int64

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case name = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
}

// MARK: - Person
struct Person: Codable {
    let adult: Bool
    let alsoKnownAs: [String]?
    let biography: String?
    let birthday: String?
    let deathday: String?
    let gender: Int
    let homepage: String?
    let id: Int
    let imdbID: String
    let knownForDepartment: String?
    let name: String
    let placeOfBirth: String?
    let popularity: Double?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case alsoKnownAs = "also_known_as"
        case biography, birthday, deathday, gender, homepage, id
        case imdbID = "imdb_id"
        case knownForDepartment = "known_for_department"
        case name
        case placeOfBirth = "place_of_birth"
        case popularity
        case profilePath = "profile_path"
    }
}

// MARK: - PersonSearch
struct PersonSearch: Codable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }

    // MARK: - Result
    struct Result: Codable {
        let adult: Bool
        let gender, id: Int
        let knownFor: [KnownFor]
        let knownForDepartment, name: String
        let popularity: Double
        let profilePath: String?

        enum CodingKeys: String, CodingKey {
            case adult, gender, id
            case knownFor = "known_for"
            case knownForDepartment = "known_for_department"
            case name, popularity
            case profilePath = "profile_path"
        }
    }

    // MARK: - KnownFor
    struct KnownFor: Codable {
        let backdropPath: String
        let firstAirDate: String?
        let genreIDS: [Int]
        let id: Int
        let mediaType: String
        let name: String?
        let originCountry: [String]?
        let originalLanguage: String
        let originalName: String?
        let overview, posterPath: String
        let voteAverage: Double
        let voteCount: Int
        let adult: Bool?
        let originalTitle, releaseDate, title: String?
        let video: Bool?

        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case firstAirDate = "first_air_date"
            case genreIDS = "genre_ids"
            case id
            case mediaType = "media_type"
            case name
            case originCountry = "origin_country"
            case originalLanguage = "original_language"
            case originalName = "original_name"
            case overview
            case posterPath = "poster_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case adult
            case originalTitle = "original_title"
            case releaseDate = "release_date"
            case title, video
        }
    }
}

// MARK: - MovieCredit
struct MovieCredits: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - TVCredit
struct TVCredits: Codable {
    let id: Int
    let cast, crew: [Cast]
    let guestStars: [Cast]?

    enum CodingKeys: String, CodingKey {
        case id
        case cast
        case crew
        case guestStars = "guest_stars"
    }
}

// MARK: - PersonCredits
struct PersonCredits: Codable {
    let cast: [Cast]
    let crew: [Cast]?
    let id: Int

    struct Cast: Codable, ContentType {
        var name: String {
            return title ?? ""
        }
        
        let title: String?
        let adult: Bool?
        let backdropPath: String?
        let genreIDS: [Int]
        let id: Int64
        let originalLanguage: String?
        let originalTitle: String?
        let overview: String?
        let posterPath: String?
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double
        let voteCount: Int64
        let popularity: Double
        let character: String?
        let creditID: String
        let order: Int?
        let mediaType: MediaType
        let originalName, firstAirDate: String?
        let originCountry: [String]?
        let episodeCount: Int?

        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case popularity, character
            case creditID = "credit_id"
            case order
            case mediaType = "media_type"
            case originalName = "original_name"
            case title
            case firstAirDate = "first_air_date"
            case originCountry = "origin_country"
            case episodeCount = "episode_count"
        }
    }

}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender: Int?
    let id: Int
    let knownForDepartment: Department?
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: Department?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }

    enum Department: String, Codable {
        case acting = "Acting"
        case art = "Art"
        case camera = "Camera"
        case costumeMakeUp = "Costume & Make-Up"
        case crew = "Crew"
        case directing = "Directing"
        case editing = "Editing"
        case lighting = "Lighting"
        case production = "Production"
        case sound = "Sound"
        case visualEffects = "Visual Effects"
        case writing = "Writing"
    }
}
