//
//  MainViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/25.
//

import Foundation
import UIKit

import SnapKit

class MainViewController: UIViewController{
    
    let mainView = MainView()
    let movieManager = MovieManager()
    
    var movies = [Movie]()
                
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        self.title = "Movie Rank"
                
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        setUI()
        
        movieManager.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.movies = response.results
                    self?.mainView.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func setUI(){
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.identifier, for: indexPath) as! MainViewCell
        
        let movie = movies[indexPath.item]
        cell.label.text = movie.title
        
        if let posterPath = movie.posterPath {
            let imageURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
            cell.setImage(urlString: imageURL, movieManager: movieManager)
        }
        
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height = collectionView.bounds.height / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detatilVC = DetailViewController()
        detatilVC.movie = movies[indexPath.item]
        self.navigationController?.pushViewController(detatilVC, animated: true)
    }
}
