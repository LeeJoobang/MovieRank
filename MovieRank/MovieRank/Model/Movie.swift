//
//  Movie.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//
import UIKit

struct MovieResponse: Codable{
    let page: Int
    let results: [Movie]
}

struct Movie: Codable {
    let title: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey{
        case title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case overview
    }
}
