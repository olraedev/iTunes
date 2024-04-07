//
//  DetailView.swift
//  iTunes
//
//  Created by SangRae Kim on 4/7/24.
//

import UIKit
import Kingfisher

final class DetailView: BaseView {
    private let scrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let contentView = UIView()
    
    private let artWorkImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let nameLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 15)
        return view
    }()
    
    private let sellerNameLabel = {
        let view = UILabel()
        view.textColor = UIColor.systemGray3
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    private let addButton = {
        let view = UIButton()
        view.setTitle("받기", for: .normal)
        view.setTitleColor(Color.basic, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.backgroundColor = Color.primary
        view.layer.cornerRadius = 10
        return view
    }()
    
    lazy var screenShotCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(ScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: ScreenShotCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let descriptionTextView = {
        let view = UITextView()
        view.isScrollEnabled = false
        view.textAlignment = .justified
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(artWorkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sellerNameLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(screenShotCollectionView)
        contentView.addSubview(descriptionTextView)
    }
    
    override func configureConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.verticalEdges.equalToSuperview()
        }
        
        artWorkImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.size.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.top)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(addButton.snp.top).offset(-8)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.height.equalTo(15)
        }
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalTo(artWorkImageView.snp.bottom)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        screenShotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(self.screenWidth() * 0.7 * 1.5)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(screenShotCollectionView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func configureView(_ item: iTunesResult) {
        let url = URL(string: item.artworkUrl100)
        
        artWorkImageView.kf.setImage(with: url)
        nameLabel.text = item.trackCensoredName
        sellerNameLabel.text = item.sellerName
        descriptionTextView.text = item.description
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let deviceWidth = self.screenWidth()
        let cellWidth = deviceWidth * 0.7
        
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
