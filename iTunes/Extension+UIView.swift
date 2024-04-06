//
//  Extension+UIView.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit

extension UIView: ConfigureIdentifier {
    static var identifier: String {
        return String(describing: self)
    }
    
    func screenWidth() -> CGFloat {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
         
        return window.screen.bounds.width
    }
}
