//
//  MainCollectionViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/26.
//
import UIKit
import SnapKit
import Kingfisher

class MainViewCell: UICollectionViewCell {
        
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
        label.numberOfLines = Constants.CellInfo.mainLines
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.CellInfo.mainFontSize))
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
            make.leading.trailing.equalToSuperview().inset(Constants.CellInfo.mainImageViewInset)
            make.height.equalToSuperview().multipliedBy(Constants.CellInfo.mainHeight)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Constants.CellInfo.mainTop)
            make.leading.trailing.equalToSuperview().inset(Constants.CellInfo.mainImageViewInset)
            make.bottom.equalToSuperview()
        }
    }
}


extension MainViewCell {
    func setImage(urlString: String){
        if let url = URL(string: urlString){
            imageView.kf.setImage(with: url)
        }
    }
}
