//
//  Error.swift
//  MovieRank
//
//  Created by Joobang on 2023/05/12.
//

import Foundation

enum NetworkError: Error{
    case dataEmpty
    case requestFailed
    case decodeFailed
    case erorr(Error)
}
