//
//  SearchViewController.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view = searchView
    }
    
    override func bind() {
        let searchText = searchView.searchController.searchBar.rx.text
        let searchButtonClicked = searchView.searchController.searchBar.rx.searchButtonClicked
        let cancelButtonClicked = searchView.searchController.searchBar.rx.cancelButtonClicked
        let cellSelected = Observable.zip(searchView.tableView.rx.itemSelected, searchView.tableView.rx.modelSelected(iTunesResult.self))
        
        let input = SearchViewModel.Input(
            searchText: searchText,
            searchButtonClicked: searchButtonClicked,
            cancelButtonClicked: cancelButtonClicked)
        let output = viewModel.transform(input)
        
        output.searchResult.drive(searchView.tableView.rx.items(cellIdentifier: ResultTableViewCell.identifier, cellType: ResultTableViewCell.self)) { row, element, cell in
            cell.configureCell(element)
        }
        .disposed(by: disposeBag)
        
        output.recentSearchList.drive(searchView.collectionView.rx.items(cellIdentifier: TagCollectionViewCell.identifier, cellType: TagCollectionViewCell.self)) { row, element, cell in
            print(element)
            cell.configureCell(element)
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
        navigationItem.title = "검색"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchView.searchController
    }
}
