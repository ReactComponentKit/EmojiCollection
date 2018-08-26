//
//  Array+Shuffle.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

extension Array {
    mutating func shuffle() {
        for _ in 0..<count {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
