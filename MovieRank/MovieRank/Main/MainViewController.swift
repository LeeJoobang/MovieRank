//
//  MainViewController.swift
//  MovieRank
//
//  Created by Joobang on 2023/04/25.
//

import Foundation
import UIKit

import SnapKit

class MainViewController: UIViewController{
    
    let mainView = MainView()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        self.title = "Movie Rank"
                
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        
        setUI()
    }
    
    func setUI(){
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}


extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 30) / 2
        let height = collectionView.bounds.height / 3
        return CGSize(width: width, height: height)
    }
}
