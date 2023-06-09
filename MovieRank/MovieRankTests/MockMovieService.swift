//
//  MockMovieService.swift
//  MovieRankTests
//
//  Created by Joobang on 2023/05/06.
//

import Foundation
import UIKit
@testable import MovieRank

class MockMovieService: MovieService {
    
    static var mockMovies: [Movie]{
        let movieA = Movie(title: "Movie1", posterPath: "/path1", releaseDate: "2022-01-01", voteAverage: 1.0, overview: "overview1")
        let movieB = Movie(title: "Movie2", posterPath: "/path2", releaseDate: "2022-01-02", voteAverage: 2.0, overview: "overview2")
        let movieC = Movie(title: "Movie3", posterPath: "/path3", releaseDate: "2022-01-03", voteAverage: 3.0, overview: "overview3")
        
        let movieResponse = [movieA, movieB, movieC]
        return movieResponse
    }
    
    func fetchMovies(page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let movie1 = Movie(title: "Movie1", posterPath: "/path1", releaseDate: "2021-01-01", voteAverage: 1.0, overview: "overview1")
        let movie2 = Movie(title: "Movie2", posterPath: "/path2", releaseDate: "2021-01-02", voteAverage: 2.0, overview: "overview2")
        let movieResponse = MovieResponse(page: 1, results: [movie1, movie2])
        
        completion(.success(movieResponse))
    }
    
    func downloadImage(posterPath: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let image = UIImage(named: "testImage") {
            completion(.success(image))
        } else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
        }
    }    
    
    
}
