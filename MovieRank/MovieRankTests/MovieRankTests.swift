//
//  MovieRankTests.swift
//  MovieRankTests
//
//  Created by Joobang on 2023/04/25.
//

import XCTest
@testable import MovieRank

final class MovieRankTests: XCTestCase {
    var viewModel: ViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ViewModel(movieService: MockMovieService())
    }
    
    func testFetchMovies() {
        let fetchMoviesExpectation = expectation(description: "fetchMovies")
        
        viewModel.fetchMovies(page: 1) {
            XCTAssertEqual(self.viewModel.movie.count, 2)
            
            XCTAssertEqual(self.viewModel.movie[0].title, "Movie1")
            XCTAssertEqual(self.viewModel.movie[0].posterPath, "/path1")
            XCTAssertEqual(self.viewModel.movie[0].releaseDate, "2021-01-01")
            XCTAssertEqual(self.viewModel.movie[0].voteAverage, 1.0)
            XCTAssertEqual(self.viewModel.movie[0].overview, "overview1")
            
            XCTAssertEqual(self.viewModel.movie[1].title, "Movie2")
            XCTAssertEqual(self.viewModel.movie[1].posterPath, "/path2")
            XCTAssertEqual(self.viewModel.movie[1].releaseDate, "2021-01-02")
            XCTAssertEqual(self.viewModel.movie[1].voteAverage, 2.0)
            XCTAssertEqual(self.viewModel.movie[1].overview, "overview2")
            
            fetchMoviesExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDownloadImage() {
        let downloadImageExpectation = expectation(description: "downloadImage")
        
        viewModel.downloadImage(posterPath: "/path1") { result in
            switch result {
            case .success(let image):
                XCTAssertNotNil(image)
                XCTAssertEqual(image.size, CGSize(width: 1280.0, height: 871.0))
            case .failure(_):
                XCTFail("Image download should not fail with MockMovieService")
            }
            downloadImageExpectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    
    
    
}
