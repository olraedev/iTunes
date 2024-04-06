//
//  SearchTableViewCell.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ResultTableViewCell: UITableViewCell {
    
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
    
    private let addButton = {
        let view = UIButton()
        view.setTitle("받기", for: .normal)
        view.setTitleColor(Color.basic, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.backgroundColor = Color.primary
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let ratingCountLabel = {
        let view = UILabel()
        view.textColor = UIColor.systemGray3
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    private let sellerNameLabel = {
        let view = UILabel()
        view.textColor = UIColor.systemGray3
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    private let genreLabel = {
        let view = UILabel()
        view.textColor = UIColor.systemGray3
        view.font = .systemFont(ofSize: 13)
        return view
    }()
    
    lazy var stackView = {
        let view = UIStackView(arrangedSubviews: [ratingCountLabel, sellerNameLabel, genreLabel])
        view.spacing = 8
        view.distribution = .equalSpacing
        view.axis = .horizontal
        return view
    }()
    
    lazy var screenShotCollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.register(ScreenShotCollectionViewCell.self, forCellWithReuseIdentifier: ScreenShotCollectionViewCell.identifier)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
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
            make.top.leading.equalToSuperview().offset(16)
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
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(30)
        }
        
        screenShotCollectionView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.height.equalTo(230)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    func configureCell(_ item: iTunesResult) {
        let url = URL(string: item.artworkUrl100)
        let screeshots = BehaviorSubject(value: item.screenshotUrls).asDriver(onErrorJustReturn: [])
        
        artWorkImageView.kf.setImage(with: url)
        nameLabel.text = item.trackCensoredName
        ratingCountLabel.text = "\(item.averageUserRating)"
        sellerNameLabel.text = item.sellerName
        genreLabel.text = item.genres[0]
        
        screeshots.drive(screenShotCollectionView.rx.items(cellIdentifier: ScreenShotCollectionViewCell.identifier, cellType: ScreenShotCollectionViewCell.self)){
            row, element, cell in
            cell.imageView.kf.setImage(with: URL(string: element))
        }
        .disposed(by: disposeBag)
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 8
        let deviceWidth = self.screenWidth()
        let cellWidth = deviceWidth - (space * 4)
        
        layout.itemSize = CGSize(width: cellWidth/3, height: cellWidth/3 * 1.8)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumInteritemSpacing = space
        layout.scrollDirection = .horizontal
        
        return layout
    }
}
