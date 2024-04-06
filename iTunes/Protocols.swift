//
//  Protocols.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation
import RxSwift

protocol ConfigureIdentifier {
    static var identifier: String { get }
}

protocol ViewModelType {
    var disposeBag: DisposeBag { get }
    associatedtype Input
    associatedtype Output
    func transform(_ input: Input) -> Output
}
