//
//  ScreenShotCollectionViewCell.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit
import Kingfisher

final class ScreenShotCollectionViewCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: String) {
        let url = URL(string: item)
        
        imageView.kf.setImage(with: url)
    }
}
