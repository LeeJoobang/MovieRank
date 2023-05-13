//
//  DetailViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//
import UIKit
import SnapKit

class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    var movie: Movie?
    private let viewModel = ViewModel(movieService: APIManager())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = Constants.ControllerInfo.detailNavigationTitle
        
        detailView.collectionView.dataSource = self
        detailView.collectionView.delegate = self
        
        setUI()
    }
    
    private func setUI(){
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Constants.ControllerInfo.detailCollectionSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.ControllerInfo.detailCollectionInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellInfo.posterIdentifier, for: indexPath) as! PosterViewCell
            cell.titlelabel.text = movie?.title
            cell.releaselabel.text = movie?.releaseDate
            cell.ratelabel.text = String(movie?.voteAverage ?? 0)
            
            if let posterPath = movie?.posterPath {
                let imageURL = Constants.URL.posterPath + posterPath
                cell.setImage(urlString: imageURL, viewModel: viewModel)
            }
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellInfo.overviewIdentifier, for: indexPath) as! OverviewCell
            cell.label.text = movie?.overview
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ViewInfo.detailIdentifier, for: indexPath)
            return cell
        }
    }
    
    // section에 대한 높이 적용
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height * Constants.ControllerInfo.detailSectionZeroHeight
            return CGSize(width: width, height: height)
        case 1:
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height / CGFloat(Constants.ControllerInfo.detailSectionOneHeight)
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: Constants.ControllerInfo.detailSectionDefault, height: Constants.ControllerInfo.detailSectionDefault)
        }
    }
    
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Constants.ViewInfo.reusableIdentifier, for: indexPath) as! CollectionReusableView
            if indexPath.section == 1 {
                header.label.text = Constants.ControllerInfo.detailHeaderText
            } else {
                header.label.text = ""
            }
            return header
        }
        return UICollectionReusableView()
    }

    //header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize(width: collectionView.bounds.width, height: CGFloat(Constants.ControllerInfo.detailHeaderOneHeight))
        }
        return CGSize(width: collectionView.bounds.width, height: CGFloat(Constants.ControllerInfo.detailHeaderDefaultHeight))
    }
}
