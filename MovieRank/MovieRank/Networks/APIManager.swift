//
//  APIManager.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/28.
//

import Foundation
import UIKit

class APIManager{
    private func performRequest(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NSError(domain: "", code: 0)
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
        dataTask.resume()
    }
    
    
    func fetchMovies(page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void){
        let requestURL = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(APIKey.apiKey)&page=\(page)")
        
        guard let url = requestURL else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
            return
        }
        
        performRequest(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                    completion(.success(movieResponse))
                } catch let error {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: posterPath) else {
            let error = NSError(domain: "", code: 0)
            completion(.failure(error))
            return
        }
        performRequest(url: url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    let error = NSError(domain: "", code: 0)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}


