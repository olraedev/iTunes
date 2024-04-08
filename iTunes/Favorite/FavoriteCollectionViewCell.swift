//
//  FavoriteCollectionViewCell.swift
//  iTunes
//
//  Created by SangRae Kim on 4/8/24.
//

import UIKit
import RxSwift

final class FavoriteCollectionViewCell: UICollectionViewCell {
    
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
    
    let removeButton = {
        let view = UIButton()
        view.setTitle("삭제", for: .normal)
        view.setTitleColor(Color.basic, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.backgroundColor = Color.primary
        view.layer.cornerRadius = 10
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureConstraints()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        disposeBag = DisposeBag()
    }
    
    private func configureHierarchy() {
        contentView.addSubview(artWorkImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(sellerNameLabel)
        contentView.addSubview(removeButton)
    }
    
    private func configureView() {
        layer.shadowRadius = 2
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.25
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        layer.masksToBounds = false
        
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = Color.basic
    }
    
    private func configureConstraints() {
        artWorkImageView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.size.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(artWorkImageView.snp.top)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(30)
        }
        
        sellerNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(artWorkImageView.snp.bottom)
            make.leading.equalTo(artWorkImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }
        
        removeButton.snp.makeConstraints { make in
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(40)
            make.height.equalTo(25)
        }
    }
    
    func configureCell(_ item: iTunesResult) {
        artWorkImageView.kf.setImage(with: URL(string: item.artworkUrl100))
        nameLabel.text = item.trackCensoredName
        sellerNameLabel.text = item.sellerName
    }
}
