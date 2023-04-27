//
//  DetailViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//

import Foundation
import UIKit

import SnapKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    
    var movie: Movie?
    let movieManager = MovieManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.title = "Movie Info"
        
        detailView.collectionView.dataSource = self
        detailView.collectionView.delegate = self
        
        setUI()
        
        
    }
    
    func setUI(){
        view.addSubview(detailView)
        detailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterViewCell.identifier, for: indexPath) as! PosterViewCell
            cell.titlelabel.text = movie?.title
            cell.releaselabel.text = movie?.releaseDate
            cell.ratelabel.text = String(movie?.voteAverage ?? 0)
            
            if let posterPath = movie?.posterPath {
                let imageURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
                cell.setImage(urlString: imageURL, movieManager: movieManager)
            }
            
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OverviewCell.identifier, for: indexPath) as! OverviewCell
            cell.label.text = movie?.overview
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath)
            return cell
        }
    }
    
    // section에 대한 높이 적용
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height * 0.7
            return CGSize(width: width, height: height)
        case 1:
            let width = collectionView.bounds.width
            let height = collectionView.bounds.height / 3
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0.0, height: 0.0)
        }
    }
    
    //header
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionReusableView.identifier, for: indexPath) as! CollectionReusableView
            if indexPath.section == 1 {
                header.label.text = "Overview"
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
            return CGSize(width: collectionView.bounds.width, height: 44)
        }
        return CGSize(width: collectionView.bounds.width, height: 0)
    }
    
}
