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

func emojiReducer<S>(name: StateKeyPath<S>, state: StateValue?) -> (Action) -> Observable<(StateKeyPath<S>, StateValue?)> {
    return { (action) in
        guard let prevState = state as? [[String]] else { return Observable.just((name, result: [])) }
        
        var newState = prevState
        
        switch action {
        case let addEmoji as AddEmojiAction:
            newState[addEmoji.section].append(addEmoji.emoji)
        case let removeEmoji as RemoveEmojiAction:
            newState[removeEmoji.section].remove(at: removeEmoji.index)
        case is ShuffleEmojiAction:
            for (index, var section) in prevState.enumerated() {
                section.shuffle()
                newState[index] = section
            }
        default:
            break
        }
        
        return Observable.just((name, newState))
    }
}
