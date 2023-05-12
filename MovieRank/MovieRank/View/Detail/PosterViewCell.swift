//
//  PosterViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import SnapKit

class PosterViewCell: UICollectionViewCell {
        
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = Constants.CellInfo.posterLines
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.CellInfo.posterTitleFont))
        label.textColor = .white
        return label
    }()
    
    lazy var releaselabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = Constants.CellInfo.posterLines
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.CellInfo.posterLabelFont))
        label.textColor = .white
        return label
    }()
    
    lazy var ratelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = Constants.CellInfo.posterLines
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.CellInfo.posterLabelFont))
        label.textColor = .white
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
            make.leading.equalToSuperview().offset(Constants.CellInfo.posterTitleLeading)
            make.trailing.equalToSuperview().offset(-Constants.CellInfo.posterTitleLeading)
            make.bottom.equalToSuperview().multipliedBy(Constants.CellInfo.posterBottom)
        }
        
        releaselabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom)
            make.leading.equalTo(titlelabel.snp.leading)
        }
        
        ratelabel.snp.makeConstraints { make in
            make.top.equalTo(titlelabel.snp.bottom)
            make.leading.equalTo(releaselabel.snp.trailing).offset(Constants.CellInfo.posterTitleLeading)
        }
    }
}

extension PosterViewCell {
    func setImage(urlString: String, viewModel: ViewModel) {
        viewModel.downloadImage(posterPath: urlString) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.posterImageView.image = image
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
