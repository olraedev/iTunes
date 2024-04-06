//
//  UserDefaultsManager.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    private enum Key: String {
        case recentSearchText
    }
    
    private init() { }
    
    var recentSearchText: [String] {
        get {
            userDefaults.array(forKey: Key.recentSearchText.rawValue) as! [String]
        }
        
        set {
            userDefaults.setValue(newValue, forKey: Key.recentSearchText.rawValue)
        }
    }
}
