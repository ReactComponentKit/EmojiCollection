//
//  MakeEmojiSectionModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import BKRedux
import ReactComponentKit

func makeEmojiSectionModel(state: [String:State], action: Action) -> [String:State] {
    guard let emojiGroupList = state["emoji"] as? [[String]] else { return state }
    
    let sections = emojiGroupList.enumerated().map { (groupIndex, emojiGroup) -> DefaultSectionModel in
        
        let emojiBoxModels = emojiGroup.map({ (emoji) -> EmojiBoxModel in
            EmojiBoxModel(emoji: emoji)
        })
        
        let section = DefaultSectionModel(items: emojiBoxModels, header: EmojiSectionHeaderModel(title: "  Emoji Section \(groupIndex)"), footer: nil)
        section.minimumInteritemSpacing = 0
        section.minimumLineSpacing = 2
        return section
        
    }
    
    var newState = state
    newState["sections"] = sections
    return newState
}
