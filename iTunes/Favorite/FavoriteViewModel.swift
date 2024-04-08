//
//  FavoriteViewModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/8/24.
//

import Foundation
import RxSwift
import RxCocoa

class FavoriteViewModel {
    let disposeBag = DisposeBag()
    
    let favoriteList = PublishRelay<[iTunesResult]>()
    
    func setList() {
        let list = DataBaseManager.shared.readAll()
        
        let results = list.map { model in
            iTunesResult(
                screenshotUrls: Array(model.screenshotUrls),
                artworkUrl100: model.artworkUrl100,
                averageUserRating: model.averageUserRating,
                trackCensoredName: model.trackCensoredName,
                sellerName: model.sellerName,
                genres: Array(model.genres),
                description: model.descriptions)
        }
        
        favoriteList.accept(results)
    }
    
    func removeFavoriteList(_ item: iTunesResult) {
        let object = iTunesModel(screenshotUrls: item.screenshotUrls, artworkUrl100: item.artworkUrl100, averageUserRating: item.averageUserRating, trackCensoredName: item.trackCensoredName, sellerName: item.sellerName, genres: item.genres, descriptions: item.description)
        
        DataBaseManager.shared.delete(object: object)
        setList()
    }
}
