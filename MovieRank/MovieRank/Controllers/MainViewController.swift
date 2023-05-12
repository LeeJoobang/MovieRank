//
//  MainViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController{
    
    let mainView = MainView()
    let viewModel = ViewModel(movieService: APIManager())

    private var currentPage = Constants.ControllerInfo.mainCurrentPage
    private let dalay = Constants.ControllerInfo.mainDelayTime

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        self.title = Constants.ControllerInfo.mainNavigationTitle
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: Constants.ControllerInfo.mainFilterButtonImage), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
        
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        setUI()
        mainView.activityIndicator.startAnimating()

        viewModel.fetchMovies(page: currentPage) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.dalay)){
                self.mainView.activityIndicator.stopAnimating()
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    @objc func filterButtonTapped(){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let titleAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainTitleText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByTitle()
            self?.mainView.collectionView.reloadData()
        }
        
        let releaseDateAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainReleaseText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByReleaseDate()
            self?.mainView.collectionView.reloadData()
        }
        
        let voteAverageAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainVoteText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByVoteAverage()
            self?.mainView.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainCancelText.rawValue, style: .cancel, handler: nil)
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellInfo.mainCellIdentifier, for: indexPath) as! MainViewCell
        let movie = viewModel.movie[indexPath.item]
        cell.label.text = movie.title
        if let posterPath = movie.posterPath {
            let imageURL = Constants.URL.posterPath + posterPath
            cell.setImage(urlString: imageURL)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(collectionView.bounds.width) - Constants.ControllerInfo.mainCollectionWidthMinus) / Constants.ControllerInfo.mainCollectionWidthDivide
        let height = Int(collectionView.bounds.height) / Constants.ControllerInfo.mainCollectionHeightDivide
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detatilVC = DetailViewController()
        detatilVC.movie = viewModel.movie[indexPath.item]
        self.navigationController?.pushViewController(detatilVC, animated: true)
    }
}

extension MainViewController{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movie.count - Constants.ControllerInfo.mainCurrentPage{
            print("current page: \(currentPage)")
            loadData()
        }
    }
    
    func loadData(){
        currentPage += Constants.ControllerInfo.mainCurrentPage
        
        mainView.activityIndicator.startAnimating()
        viewModel.appendMovies(page: currentPage) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.dalay)) {
                self.mainView.activityIndicator.stopAnimating()
                self.mainView.collectionView.reloadData()
            }
        }
    }
}
