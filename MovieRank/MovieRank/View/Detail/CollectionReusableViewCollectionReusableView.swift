//
//  HeaderFooterView.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/27.
//
import UIKit

final class CollectionReusableView: UICollectionReusableView {
        
    lazy var label: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: CGFloat(Constants.ViewInfo.reusableFont))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUp() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
