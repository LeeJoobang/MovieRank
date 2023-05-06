//
//  ViewModel.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//

import Foundation
import UIKit

class ViewModel{
    let movieService: MovieService
    var movie = [Movie]()
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchMovies(page: Int, completion: @escaping () -> Void) {
        movieService.fetchMovies(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self?.movie = response.results
                    completion()
                case .failure(let error):
                    print("faile error: \(error)")
                }
            }
        }
    }
    
    func appendMovies(page: Int, completion: @escaping () -> Void) {
        movieService.fetchMovies(page: page) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movie.append(contentsOf: response.results)
                    completion()
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping(Result<UIImage, Error>)-> Void){
        movieService.downloadImage(posterPath: posterPath) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func sortMoviesByTitle() {
        movie.sort(by: { $0.title < $1.title })
    }
    
    func sortMoviesByReleaseDate() {
        movie.sort(by: { ($0.releaseDate ?? "") < ($1.releaseDate ?? "")})
    }
    
    func sortMoviesByVoteAverage() {
        movie.sort(by: { $0.voteAverage > $1.voteAverage })
    }
}
