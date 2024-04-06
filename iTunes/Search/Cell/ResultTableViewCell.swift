//
//  SearchTableViewCell.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import Kingfisher

class ResultTableViewCell: UITableViewCell {
    
    private let artWorkImageView = {
        let view = UIImageView()
        return view
    }()
    
    private let nameLabel = {
        let view = UILabel()
        return view
    }()
    
    private let addButton = {
        let view = UIButton()
        view.setTitle("받기", for: .normal)
        view.setTitleColor(Color.basic, for: .normal)
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let ratingCountLabel = {
        let view = UILabel()
        return view
    }()
    
    private let sellerNameLabel = {
        let view = UILabel()
        return view
    }()
    
    private let genreLabel = {
        let view = UILabel()
        return view
    }()
    
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [ratingCountLabel, sellerNameLabel, genreLabel])
        view.spacing = 8
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()
    
    lazy var screenShotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(artWorkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(addButton)
        contentView.addSubview(stackView)
        contentView.addSubview(screenShotCollectionView)
    }
    
    private func configureConstraints() {
        artWorkImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.size.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(artWorkImageView)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.trailing.equalTo(addButton.snp.leading).offset(-8)
            make.height.equalTo(30)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalTo(artWorkImageView)
            make.trailing.equalToSuperview().offset(-8)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(30)
        }
        
        screenShotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureCell(_ item: iTunesResult) {
        let url = URL(string: item.artworkUrl100)
        
        artWorkImageView.kf.setImage(with: url)
        nameLabel.text = item.trackCensoredName
        ratingCountLabel.text = "\(item.averageUserRating)"
        sellerNameLabel.text = item.sellerName
        genreLabel.text = item.genres[0]
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let deviceWidth = self.screenWidth()
        let cellWidth = deviceWidth - (space * 4)
        
        layout.itemSize = CGSize(width: cellWidth/3, height: cellWidth/3*1.5)
        layout.minimumInteritemSpacing = space
        
        return layout
    }
}
