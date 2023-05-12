//
//  APIManager.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/28.
//
import UIKit

protocol MovieService {
    func fetchMovies(page: Int, completion: @escaping (Result<MovieResponse, Error>) -> Void)
    func downloadImage(posterPath: String, completion: @escaping(Result<UIImage, Error>) -> Void)
}

class APIManager: MovieService{
    private func performRequest(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                let error = NetworkError.dataEmpty
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
            let error = NetworkError.requestFailed
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
                } catch {
                    completion(.failure(NetworkError.decodeFailed))
                }
            case .failure(var error):
                error = NetworkError.requestFailed
                completion(.failure(error))
            }
        }
    }
    
    func downloadImage(posterPath: String, completion: @escaping(Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: posterPath) else {
            let error = NetworkError.dataEmpty
            completion(.failure(error))
            return
        }
        performRequest(url: url) { result in
            switch result {
            case .success(let data):
                if let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    let error = NetworkError.dataEmpty
                    completion(.failure(error))
                }
            case .failure(var error):
                error = NetworkError.requestFailed
                completion(.failure(error))
            }
        }
    }
}
