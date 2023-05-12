//
//  DetailView.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import SnapKit

class DetailView: UIView {
    static var identifier = "DetailCell"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: DetailView.identifier)
        
        collectionView.register(OverviewCell.self, forCellWithReuseIdentifier: Constants.CellInfo.overviewIdentifier)
        collectionView.register(PosterViewCell.self, forCellWithReuseIdentifier: Constants.CellInfo.posterIdentifier)
        
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionReusableView.identifier)

        return collectionView
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
    
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
}
