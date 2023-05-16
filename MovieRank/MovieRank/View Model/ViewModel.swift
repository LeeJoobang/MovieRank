//
//  ViewModel.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    
    let movieService: MovieService
    private let disposeBag = DisposeBag()
    
    let movieRelay = BehaviorRelay<[Movie]>(value: [])
    var movies: Observable<[Movie]> {
        return movieRelay.asObservable()
    }
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchMovies(page: Int) {
        movieService.fetchMovies(page: page)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] response in
                self?.appendMovies(response.results)
            }, onError: { error in
                print("Failed to fetch movies: \(error)")
            }).disposed(by: disposeBag)
    }
    
    private func appendMovies(_ newMovies: [Movie]) {
        var currentMovies = movieRelay.value
        currentMovies.append(contentsOf: newMovies)
        movieRelay.accept(currentMovies)
    }
    
    func sortMoviesByTitle() {
        var currentMovies = movieRelay.value
        currentMovies.sort(by: { $0.title < $1.title })
        movieRelay.accept(currentMovies)
    }
    
    func sortMoviesByReleaseDate() {
        var currentMovies = movieRelay.value
        currentMovies.sort(by: { ($0.releaseDate ?? "") < ($1.releaseDate ?? "") })
        movieRelay.accept(currentMovies)
    }
    
    func sortMoviesByVoteAverage() {
        var currentMovies = movieRelay.value
        currentMovies.sort(by: { $0.voteAverage > $1.voteAverage })
        movieRelay.accept(currentMovies)
    }
    
    
}
