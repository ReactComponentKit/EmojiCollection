//
//  EmojiBoxModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

struct EmojiBoxModel: ItemModel {
    
    var id: Int {
        return emoji.hashValue
    }
    
    var componentClass: UIViewComponent.Type {
        return EmojiBoxComponent.self
    }
    
    var contentSize: CGSize {
        return CGSize(width: 36, height: 36)
    }
    
    let emoji: String
    
    init(emoji: String) {
        self.emoji = emoji
    }
}
