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
    
    func getRecentSearchTexts() -> [String] {
        if let list = userDefaults.array(forKey: Key.recentSearchText.rawValue) {
            return list as! [String]
        }
        
        return []
    }
    
    func setRecentSearchTexts(text: String) {
        var list = getRecentSearchTexts()
        
        list.append(text)
        userDefaults.setValue(list, forKey: Key.recentSearchText.rawValue)
    }
}
