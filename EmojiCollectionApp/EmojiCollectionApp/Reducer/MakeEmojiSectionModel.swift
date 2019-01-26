//
//  MakeEmojiSectionModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import BKRedux
import ReactComponentKit

func makeEmojiSectionModel(state: State, action: Action) -> Observable<State> {
    guard let emojiCollectionState = state as? EmojiCollectionState else { return .just(state) }
    
    let emojiGroupList = emojiCollectionState.emoji
    let sections = emojiGroupList.enumerated().map { (groupIndex, emojiGroup) -> DefaultSectionModel in
        
        let emojiBoxModels = emojiGroup.map({ (emoji) -> EmojiBoxModel in
            EmojiBoxModel(emoji: emoji)
        })
        
        let section = DefaultSectionModel(items: emojiBoxModels, header: EmojiSectionHeaderModel(title: "  Emoji Section \(groupIndex)"), footer: nil)
        section.minimumInteritemSpacing = 0
        section.minimumLineSpacing = 2
        section.inset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return section
        
    }
    
    var newState = emojiCollectionState
    newState.sections = sections
    return .just(newState)
}
