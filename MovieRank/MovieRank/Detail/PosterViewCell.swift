//
//  PosterViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//

import Foundation
import UIKit

import SnapKit

class PosterViewCell: UICollectionViewCell {
    
    static var identifier = "PosterViewCell"
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "square.and.arrow.up")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .black
        return imageView
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.text = "test"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 30)
        label.backgroundColor = .red
        return label
    }()
    
    lazy var releaselabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "2023-06-09"
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .orange
        return label
    }()
    
    lazy var ratelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "7.777"
        label.font = UIFont.systemFont(ofSize: 20)
        label.backgroundColor = .green
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
        addSubview(posterImageView)
        posterImageView.addSubview(titlelabel)
        posterImageView.addSubview(releaselabel)
        posterImageView.addSubview(ratelabel)

        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titlelabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().multipliedBy(0.9)
        }
        
        releaselabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom)
            make.leading.equalTo(titlelabel.snp.leading)
        }
        
        ratelabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom)
            make.leading.equalTo(releaselabel.snp.trailing).offset(5)
        }

    }
}
