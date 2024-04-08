//
//  DataBaseManager.swift
//  iTunes
//
//  Created by SangRae Kim on 4/7/24.
//

import Foundation
import RealmSwift

class DataBaseManager {
    
    static let shared = DataBaseManager()
    private let realm = try! Realm()
    
    private init() { print(realm.configuration.fileURL!) }
    
    func add(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            
        }
    }
    
    func readAll() -> [iTunesModel] {
        return Array(realm.objects(iTunesModel.self))
    }
}
