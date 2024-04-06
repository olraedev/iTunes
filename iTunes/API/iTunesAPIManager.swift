//
//  iTunesAPIManager.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import Foundation
import RxSwift

enum APIError: Error {
    case invalidURL
    case unknownResponse
    case statusError
}

class iTunesAPIManager {
    
    static func fetchToiTunesSearch(term: String) -> Observable<iTunesData> {
        
        let query = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        return Observable<iTunesData>.create { observer in
            guard let url = URL(string: "https://itunes.apple.com/search?term=\(query)&country=KR&media=software&limit=10&entity=software") else {
                
                observer.onError(APIError.invalidURL)
                return Disposables.create()
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    observer.onError(APIError.unknownResponse)
                    return
                }
                
                guard let response = response as? HTTPURLResponse,
                        (200...299).contains(response.statusCode) else {
                    observer.onError(APIError.statusError)
                    return
                }
                
                if let data = data, 
                    let appData = try? JSONDecoder().decode(iTunesData.self, from: data) {
                    observer.onNext(appData)
                    observer.onCompleted()
                } else {
                    print("실패...")
                    observer.onError(APIError.unknownResponse)
                }
            }.resume()
            
            return Disposables.create()
            
        }.debug()
    }
}
