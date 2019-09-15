//
//  EmojiReducer.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation
import RxSwift
import ReactComponentKit

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

func addEmoji(state: EmojiCollectionState, action: AddEmojiAction) -> EmojiCollectionState {
    return state.copy {
        $0.emoji[action.section].append(action.emoji)
    }
}

func removeEmoji(state: EmojiCollectionState, action: RemoveEmojiAction) -> EmojiCollectionState {
    return state.copy {
        $0.emoji[action.section].remove(at: action.index)
    }
}

func shuffleEmoji(state: EmojiCollectionState, action: ShuffleEmojiAction) -> EmojiCollectionState {
    return state.copy {
        for (index, var section) in $0.emoji.enumerated() {
            section.shuffle()
            $0.emoji[index] = section
        }
    }
}
