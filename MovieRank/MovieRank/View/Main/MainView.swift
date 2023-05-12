//
//  MainView.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(Constants.ViewInfo.mainCollectionLayout)
        layout.minimumInteritemSpacing = CGFloat(Constants.ViewInfo.mainCollectionLayout)
        layout.sectionInset = UIEdgeInsets(top: CGFloat(Constants.ViewInfo.mainCollectionLayout), left: CGFloat(Constants.ViewInfo.mainCollectionLayout), bottom: CGFloat(Constants.ViewInfo.mainCollectionLayout), right: CGFloat(Constants.ViewInfo.mainCollectionLayout))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: Constants.CellInfo.mainCellIdentifier)
            
        return collectionView
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.frame = CGRect(x: Constants.ViewInfo.mainIndicatorXY, y: Constants.ViewInfo.mainIndicatorXY, width: Constants.ViewInfo.mainIndicatorWH, height: Constants.ViewInfo.mainIndicatorWH)
        activityIndicator.color = UIColor.lightGray
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.stopAnimating()
        return activityIndicator
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        addSubview(collectionView)
        addSubview(self.activityIndicator)

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
