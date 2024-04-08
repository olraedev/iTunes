//
//  iTunesModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/7/24.
//

import Foundation
import RealmSwift

class iTunesModel: Object {
    @Persisted var screenshotUrls: List<String>
    @Persisted var artworkUrl100: String
    @Persisted var averageUserRating: Double
    @Persisted var trackCensoredName: String
    @Persisted var sellerName: String
    @Persisted var genres: List<String>
    @Persisted var descriptions: String
    
    convenience init(screenshotUrls: [String], artworkUrl100: String, averageUserRating: Double, trackCensoredName: String, sellerName: String, genres: [String], descriptions: String) {
        self.init()
        self.screenshotUrls.append(objectsIn: screenshotUrls)
        self.artworkUrl100 = artworkUrl100
        self.averageUserRating = averageUserRating
        self.trackCensoredName = trackCensoredName
        self.sellerName = sellerName
        self.genres.append(objectsIn: genres)
        self.descriptions = descriptions
    }
}
