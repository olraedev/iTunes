//
//  FavoriteViewController.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class FavoriteViewController: BaseViewController {
    
    private let favoriteView = FavoriteView()
    private let viewModel = FavoriteViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = favoriteView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.setList()
    }
    
    override func bind() {
        let cellSelected = Observable.zip(favoriteView.collectionView.rx.itemSelected, favoriteView.collectionView.rx.modelSelected(iTunesResult.self))

        viewModel.favoriteList.bind(to: favoriteView.collectionView.rx.items(cellIdentifier: FavoriteCollectionViewCell.identifier, cellType: FavoriteCollectionViewCell.self)) { row, element, cell in
            cell.configureCell(element)
            cell.removeButton.rx.tap.bind(with: self) { owner, _ in
                owner.viewModel.removeFavoriteList(element)
            }
            .disposed(by: cell.disposeBag)
        }
        .disposed(by: disposeBag)
        
        cellSelected.bind(with: self) { owner, value in
            let vc = DetailViewController()
            
            vc.viewModel.resultData = value.1
            owner.navigationController?.pushViewController(vc, animated: true)
        }
        .disposed(by: disposeBag)
    }
    
    override func configureNavigation() {
        navigationItem.title = "즐겨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
}
