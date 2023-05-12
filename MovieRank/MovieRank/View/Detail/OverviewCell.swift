//
//  OverViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import SnapKit

class OverviewCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = Constants.CellInfo.overviewLines
        label.font = UIFont.systemFont(ofSize: CGFloat(Constants.CellInfo.overviewFont))
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
        addSubview(label)
        
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
    }
}
