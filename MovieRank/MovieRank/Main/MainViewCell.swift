//
//  MainCollectionViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//

import Foundation
import UIKit

import SnapKit

class MainViewCell: UICollectionViewCell {
    
    static var identifier = "MainCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.backgroundColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func setUI(){
        addSubview(imageView)
        addSubview(label)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(4)
            make.height.equalToSuperview().multipliedBy(0.8)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(4)
            make.bottom.equalToSuperview()
        }
    }
}

extension MainViewCell {
    func setImage(urlString: String, movieManager: MovieManager) {
        movieManager.downloadImage(posterPath: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
