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
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    lazy var tableView = {
        let view = UITableView()
        view.rowHeight = UITableView.automaticDimension
        view.separatorStyle = .none
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(collectionView)
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: 100, height: 30)
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
