//
//  RemoveEmojiAction.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux

struct RemoveEmojiAction: Action {
    let section: Int
    let index: Int
}
