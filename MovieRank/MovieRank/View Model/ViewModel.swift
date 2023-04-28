//
//  ViewModel.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//

import Foundation
import UIKit

class ViewModel{
    
    let apiManager = APIManager()
    var movie = [Movie]()
    
    func fetchMovies(completion: @escaping () -> Void){
        apiManager.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self?.movie = response.results
                    completion()
                case .failure(let error):
                    print("fail error: \(error)")
                }
            }
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping(Result<UIImage, Error>)-> Void){
        apiManager.downloadImage(posterPath: posterPath) { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func sortMoviesByTitle() {
        movie.sort(by: { $0.title < $1.title })
    }
    
    func sortMoviesByReleaseDate() {
        movie.sort(by: { $0.releaseDate < $1.releaseDate })
    }
    
    func sortMoviesByVoteAverage() {
        movie.sort(by: { $0.voteAverage > $1.voteAverage })
    }
}


