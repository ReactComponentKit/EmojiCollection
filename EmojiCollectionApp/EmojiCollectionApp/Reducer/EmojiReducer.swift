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
