//
//  BaseViewController.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.basic
        configureViews()
        configureNavigation()
        bind()
    }
    
    func configureViews() { }
    func configureNavigation() { }
    func bind() { }
}
