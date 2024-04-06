//
//  iTunesModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation

struct iTunesData: Decodable {
    let results: [iTunesResult]
}

struct iTunesResult: Decodable {
    let screenshotUrls: [String]
    let artworkUrl100: String
    let averageUserRating: Double
    let trackCensoredName: String
    let sellerName: String
    let genres: [String]
    let description: String
}
