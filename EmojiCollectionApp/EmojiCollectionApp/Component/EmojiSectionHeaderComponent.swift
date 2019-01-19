//
//  EmojiSectionHeaderComponent.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

class EmojiSectionHeaderComponent: UIViewComponent {
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.cornerRadius = 4
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.black
        label.clipsToBounds = true
        return label
    }()
    
    override func setupView() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(8)
            make.right.bottom.equalToSuperview().offset(-8)
        }
    }
    
    override func configure<Item>(item: Item, at indexPath: IndexPath) {
        guard let headerModel = item as? EmojiSectionHeaderModel else { return }
        self.titleLabel.text = headerModel.title
    }
}
