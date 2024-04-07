//
//  DetailViewController.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class DetailViewController: BaseViewController {
    
    private let detailView = DetailView()
    let viewModel = DetailViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = detailView
    }
    
    override func bind() {
        let output = viewModel.transform(nil)
        
        output.result.drive(with: self) { owner, value in
            owner.detailView.configureView(value)
        }
        .disposed(by: disposeBag)
        
        output.screenshots
            .drive(detailView.screenShotCollectionView.rx.items(cellIdentifier: ScreenShotCollectionViewCell.identifier, cellType: ScreenShotCollectionViewCell.self)) { row, element, cell in
                cell.configureCell(element)
            }
            .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
    }
}
