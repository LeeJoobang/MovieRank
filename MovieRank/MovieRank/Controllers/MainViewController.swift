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
    
    private let mainView = MainView()
    private let viewModel = ViewModel(movieService: APIManager())
    private let disposeBag = DisposeBag()
    private var currentPage = Constants.ControllerInfo.mainCurrentPage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        title = Constants.ControllerInfo.mainNavigationTitle
        
        let filterButton = UIBarButtonItem(image: UIImage(systemName: Constants.ControllerInfo.mainFilterButtonImage), style: .plain, target: self, action: #selector(filterButtonTapped))
        navigationItem.rightBarButtonItem = filterButton
        
        mainView.collectionView.delegate = self
        
        setUI()
        movieSubscribe(page: currentPage)
        bindUI()
        itemSelect()
    }
    
    @objc func filterButtonTapped() {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let titleAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainTitleText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByTitle()
        }
        
        let releaseDateAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainReleaseText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByReleaseDate()
        }
        
        let voteAverageAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainVoteText.rawValue, style: .default) { [weak self] _ in
            self?.viewModel.sortMoviesByVoteAverage()
        }
        let cancelAction = UIAlertAction(title: Constants.ControllerInfo.mainFilterText.mainCancelText.rawValue, style: .cancel, handler: nil)
        
        alertController.addAction(titleAction)
        alertController.addAction(releaseDateAction)
        alertController.addAction(voteAverageAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func setUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension MainViewController {
    
    func movieSubscribe(page: Int){
        mainView.activityIndicator.startAnimating()
        
        viewModel.movies
            .subscribe(onNext: { [weak self] movies in
                self?.mainView.collectionView.reloadData()
                self?.mainView.activityIndicator.stopAnimating()
            })
            .disposed(by: disposeBag)
        viewModel.fetchMovies(page: page)
        
    }
    
    func bindUI(){
        viewModel.movies
            .bind(to: mainView.collectionView.rx.items(cellIdentifier: Constants.CellInfo.mainCellIdentifier, cellType: MainViewCell.self)) {
                row, movie, cell in
                cell.label.text = movie.title
                if let posterPath = movie.posterPath {
                    let imageURL = Constants.URL.posterPath + posterPath
                    cell.setImage(urlString: imageURL)
                }
            }.disposed(by: disposeBag)
    }
    
    func itemSelect(){
        mainView.collectionView.rx.modelSelected(Movie.self)
            .subscribe(onNext: { [weak self] movie in
                let detailVC = DetailViewController()
                detailVC.movie = movie
                self?.navigationController?.pushViewController(detailVC, animated: true)
            }).disposed(by: disposeBag)
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieRelay.value.count
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Int(collectionView.bounds.width) - Constants.ControllerInfo.mainCollectionWidthMinus) / Constants.ControllerInfo.mainCollectionWidthDivide
        let height = Int(collectionView.bounds.height) / Constants.ControllerInfo.mainCollectionHeightDivide
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.movieRelay.value.count - Constants.ControllerInfo.mainCurrentPage {
            loadData()
        }
    }
    
    func loadData() {
        currentPage += Constants.ControllerInfo.mainCurrentPage
        mainView.activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Constants.ControllerInfo.mainDelayTime)) { [weak self] in
            self?.viewModel.fetchMovies(page: self?.currentPage ?? 0)
        }
    }
}
