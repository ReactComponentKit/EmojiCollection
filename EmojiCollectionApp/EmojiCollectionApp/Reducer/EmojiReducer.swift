//
//  EmojiReducer.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import BKRedux
import RxSwift

func emojiReducer(state: State, action: Action) -> Observable<State> {
    guard var mutableState = state as? EmojiCollectionState else { return .just(state) }
    
    switch action {
    case let act as AddEmojiAction:
        mutableState.emoji[act.section].append(act.emoji)
    case let act as RemoveEmojiAction:
        mutableState.emoji[act.section].remove(at: act.index)
    case is ShuffleEmojiAction:
        for (index, var section) in mutableState.emoji.enumerated() {
            section.shuffle()
            mutableState.emoji[index] = section
        }
    default:
        break
    }
    
    return .just(mutableState)
}
