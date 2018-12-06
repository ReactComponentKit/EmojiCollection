//
//  EmojiSectionHeaderModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import ReactComponentKit

struct EmojiSectionHeaderModel: ItemModel {
    
    var id: Int {
        return title.hashValue
    }
    
    var componentClass: UIViewComponent.Type {
        return EmojiSectionHeaderComponent.self
    }
    
    var contentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 36)
    }
    
    let title: String
    
    init(title: String) {
        self.title = title
    }

}
