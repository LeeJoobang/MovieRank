//
//  MainViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/25.
//

import Foundation
import UIKit

import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController{
    
    let mainView = MainView()
    let viewModel = ViewModel()
                    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        self.title = "Movie Rank"
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
                
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        setUI()
        
        viewModel.fetchMovies {
            self.mainView.collectionView.reloadData()
        }
    }
    
    @objc func filterButtonTapped(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let titleAction = UIAlertAction(title: "영화명", style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByTitle()
            self?.mainView.collectionView.reloadData()
        }
        
        let releaseDateAction = UIAlertAction(title: "개봉일", style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByReleaseDate()
            self?.mainView.collectionView.reloadData()
        }
        
        let voteAverageAction = UIAlertAction(title: "평점", style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByVoteAverage()
            self?.mainView.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(titleAction)
        alertController.addAction(releaseDateAction)
        alertController.addAction(voteAverageAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
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
        return viewModel.movie.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewCell.identifier, for: indexPath) as! MainViewCell
        let movie = viewModel.movie[indexPath.item]
        
        cell.label.text = movie.title
        
        if let posterPath = movie.posterPath {
            let imageURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
            cell.setImage(urlString: imageURL, viewModel: viewModel)
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
        detatilVC.movie = viewModel.movie[indexPath.item]
        self.navigationController?.pushViewController(detatilVC, animated: true)
    }
}
