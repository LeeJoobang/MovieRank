//
//  DetailView.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import SnapKit

class DetailView: UIView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = CGFloat(Constants.ViewInfo.detailCollectionLayout)
        layout.minimumInteritemSpacing = CGFloat(Constants.ViewInfo.detailCollectionLayout)
        layout.sectionInset = UIEdgeInsets(top: CGFloat(Constants.ViewInfo.detailCollectionLayout), left: CGFloat(Constants.ViewInfo.detailCollectionLayout), bottom: CGFloat(Constants.ViewInfo.detailCollectionLayout), right: CGFloat(Constants.ViewInfo.detailCollectionLayout))
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Constants.ViewInfo.detailIdentifier)
        
        collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: Constants.CellInfo.overviewIdentifier)
        collectionView.register(PosterViewCell.self, forCellWithReuseIdentifier: Constants.CellInfo.posterIdentifier)
        
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Constants.ViewInfo.reusableIdentifier)

        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUI(){
        addSubview(collectionView)
    
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(CGFloat(Constants.ViewInfo.detailConstraints))
            make.trailing.equalToSuperview().offset(-CGFloat(Constants.ViewInfo.detailConstraints))
        }
    }
}
