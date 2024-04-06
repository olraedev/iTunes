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
    }
    
    struct Output {
        let searchResult: Driver<[iTunesResult]>
    }
    
    func transform(_ input: Input) -> Output {
        let searchResult = PublishSubject<[iTunesResult]>()
        
        input.searchButtonClicked
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .flatMap { iTunesAPIManager.fetchToiTunesSearch(term: $0) }
            .subscribe(with: self) { owner, result in
                let data = result.results
                searchResult.onNext(data)
            } onError: { _, _ in
                print("Error")
            } onCompleted: { _ in
                print("Completed")
            } onDisposed: { _ in
                print("Disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(
            searchResult: searchResult.asDriver(onErrorJustReturn: []))
    }
}
