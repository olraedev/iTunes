//
//  DetailViewModel.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel {
    let disposeBag = DisposeBag()
    
    var resultData: iTunesResult!
    
    struct Input {
        
    }
    
    struct Output {
        let result: Driver<iTunesResult>
        let screenshots: Driver<[String]>
    }
    
    func transform(_ input: Input?) -> Output {
        let result = BehaviorRelay(value: resultData!)
        let screenshotUrls = BehaviorRelay(value: resultData!.screenshotUrls)
        
        
        return Output(
            result: result.asDriver(),
            screenshots: screenshotUrls.asDriver())
    }
}
