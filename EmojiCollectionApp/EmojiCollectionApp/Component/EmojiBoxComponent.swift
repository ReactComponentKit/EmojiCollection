//
//  EmojiBoxComponent.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

class EmojiBoxComponent: UIViewComponent {
    
    private var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.layer.cornerRadius = 14
        label.clipsToBounds = true
        label.backgroundColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    override func setupView() {
        addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    override func configure<Item>(item: Item) {
        guard let emojiModel = item as? EmojiBoxModel else { return }
        label.text = emojiModel.emoji
    }
    
}
