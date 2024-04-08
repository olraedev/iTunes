//
//  SearchView.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit

final class SearchView: BaseView {
    
    let searchController = {
        let view = UISearchController(searchResultsController: nil)
        view.searchBar.placeholder = "게임, 앱, 스토리 등"
        return view
    }()
    
    lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(TagCollectionViewCell.self, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        view.register(ResultTableViewCell.self, forCellReuseIdentifier: ResultTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 60, height: 30)
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
