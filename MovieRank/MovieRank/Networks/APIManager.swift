//
//  APIManager.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/28.
//
import UIKit
import RxSwift

protocol MovieService {
    func fetchMovies(page: Int) -> Observable<MovieResponse>
    func downloadImage(posterPath: String) -> Observable<UIImage>
}

class APIManager: MovieService {
    
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
    
    func fetchMovies(page: Int) -> Observable<MovieResponse> {
        var urlComponents = URLComponents(string: Constants.URL.baseURL)
        urlComponents?.path = Constants.URL.popularMoviesPath
        urlComponents?.queryItems = [
            URLQueryItem(name: Constants.URL.apiKeyName, value: APIKey.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = urlComponents?.url else {
            return Observable.error(NetworkError.requestFailed)
        }
        
        return Observable.create { [weak self] observer in
            self?.performRequest(url: url) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let movieResponse = try decoder.decode(MovieResponse.self, from: data)
                        observer.onNext(movieResponse)
                        observer.onCompleted()
                    } catch {
                        observer.onError(NetworkError.decodeFailed)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func downloadImage(posterPath: String) -> Observable<UIImage> {
        guard let url = URL(string: posterPath) else {
            return Observable.error(NetworkError.dataEmpty)
        }
        
        return Observable.create { [weak self] observer in
            self?.performRequest(url: url) { result in
                switch result {
                case .success(let data):
                    if let image = UIImage(data: data) {
                        observer.onNext(image)
                        observer.onCompleted()
                    } else {
                        observer.onError(NetworkError.dataEmpty)
                    }
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
