//
//  EmojiHelper.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

enum EmojiHelper {
    private static let emojis = (0x1F600...0x1F64F)
    static func emoji() -> String? {
        return UnicodeScalar(emojis.random).map(String.init)
    }
}
