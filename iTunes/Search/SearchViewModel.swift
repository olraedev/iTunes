//
//  SearchViewModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class SearchViewModel: ViewModelType {
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchText: ControlProperty<String?>
        let searchButtonClicked: ControlEvent<Void>
        let cancelButtonClicked: ControlEvent<Void>
    }
    
    struct Output {
        let searchResult: Driver<[iTunesResult]>
        let recentSearchList: Driver<[String]>
    }
    
    func transform(_ input: Input) -> Output {
        let searchResult = PublishRelay<[iTunesResult]>()
        let recentSearchList = BehaviorRelay(value: UserDefaultsManager.shared.getRecentSearchTexts())
        
        // too many HTTP request...
        input.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .distinctUntilChanged()
            .flatMap { iTunesAPIManager.fetchToiTunesSearch(term: $0) }
            .subscribe(with: self) { owner, result in
                let data = result.results
                searchResult.accept(data)
            } onError: { _, _ in
                print("Error")
            } onCompleted: { _ in
                print("Completed")
            } onDisposed: { _ in
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText.orEmpty)
            .distinctUntilChanged()
            .bind(with: self) { owner, text in
                UserDefaultsManager.shared.setRecentSearchTexts(text: text)
                recentSearchList.accept(UserDefaultsManager.shared.getRecentSearchTexts())
            }
            .disposed(by: disposeBag)
        
        input.cancelButtonClicked
            .bind(with: self) { _, _ in searchResult.accept([]) }
            .disposed(by: disposeBag)
        
        return Output(
            searchResult: searchResult.asDriver(onErrorJustReturn: []),
            recentSearchList: recentSearchList.asDriver(onErrorJustReturn: []))
    }
    
    func addFavorite(_ item: iTunesResult) {
        let object: iTunesModel = iTunesModel(screenshotUrls: item.screenshotUrls, artworkUrl100: item.artworkUrl100, averageUserRating: item.averageUserRating, trackCensoredName: item.trackCensoredName, sellerName: item.sellerName, genres: item.genres, descriptions: item.description)
        
        DataBaseManager.shared.add(object: object)
        
        print(DataBaseManager.shared.readAll())
    }
}
