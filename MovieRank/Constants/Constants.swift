//
//  Constants.swift
//  MovieRank
//
//  Created by Joobang on 2023/05/12.
//

import Foundation

struct Constants{
    
    enum URL {
        static let baseURL = "https://api.themoviedb.org"
        static let popularMoviesPath = "/3/movie/popular"
        static let posterPath = "https://image.tmdb.org/t/p/w500"
        static let apiKeyName = "api_key"
    }
     
    enum CellInfo {
        
        static let mainCellIdentifier = "MainCollectionViewCell"
        static let mainLines = 0
        static let mainFontSize = 14
        static let mainImageViewInset = 4
        static let mainHeight = 0.8
        static let mainTop = 8
        
        static var posterIdentifier = "PosterViewCell"
        static let posterLines = 0
        static let posterTitleFont = 20
        static let posterLabelFont = 17
        static let posterTitleLeading = 10
        static let posterBottom = 0.9
        static let posterOffset = 5
        
        
        static var overviewIdentifier = "OverviewCell"
        static let overviewLines = 0
        static let overviewFont = 17
    }
    
    enum ViewInfo {
        
        static let mainCollectionLayout = 10
        static let mainIndicatorXY = 0
        static let mainIndicatorWH = 50
        
        static let reusableIdentifier = "CollectionReusableView"
        static let reusableFont = 20
        
        static let detailIdentifier = "DetailCell"
        static let detailCollectionLayout = 10
        static let detailConstraints = 20
        
    }
    
    enum ControllerInfo {
        
    }
}

