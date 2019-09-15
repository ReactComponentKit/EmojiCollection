//
//  EmojiCollectionViewModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import RxCocoa
import ReactComponentKit

struct EmojiCollectionState: State {
    var emoji: [[String]] = [[], [], []]
    var sections: [DefaultSectionModel] = []
    var error: RCKError? = nil
}

class EmojiCollectionViewModel: RCKViewModel<EmojiCollectionState> {
    
    private var emojiGroupList: [[String]]? = nil
    let sections =  Output<[DefaultSectionModel]>(value: [])
        
    override func setupStore() {
        initStore { store in
            store.initial(state: EmojiCollectionState())
            store.beforeActionFlow(logAction)
            
            store.flow(action: AddEmojiAction.self)
                .flow(
                    addEmoji,
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            
            store.flow(action: RemoveEmojiAction.self)
                .flow(
                    removeEmoji,
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            
            store.flow(action: ShuffleEmojiAction.self)
                .flow(
                    shuffleEmoji,
                    { state, _ in makeCollectionViewSectionModels(state: state) }
                )
            }
    }
    
    override func on(newState: EmojiCollectionState) {
        emojiGroupList = newState.emoji
        sections.accept(newState.sections)
    }
    
    func randomIndexToDelete(at section: Int) -> Int? {
        guard let emojiGroupList = emojiGroupList else { return nil }
        guard emojiGroupList[section].count > 0 else { return nil }
        return Int(arc4random()) % emojiGroupList[section].count
    }
}
