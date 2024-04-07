//
//  SearchCollectionViewCell.swift
//  iTunes
//
//  Created by SangRae Kim on 4/6/24.
//

import UIKit

final class TagCollectionViewCell: UICollectionViewCell {
    
    private let tagButton = {
        let view = UIButton()
        view.setTitleColor(Color.basic, for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 13)
        view.backgroundColor = Color.primary
        view.layer.cornerRadius = 10
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(tagButton)
        tagButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ item: String) {
        tagButton.setTitle(item, for: .normal)
    }
}
