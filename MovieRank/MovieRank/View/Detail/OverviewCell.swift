//
//  OverViewCell.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit
import SnapKit

class OverviewCell: UICollectionViewCell {
    
    static var identifier = "OverviewCell"
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17)
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
