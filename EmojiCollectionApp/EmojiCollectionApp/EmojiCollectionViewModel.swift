//
//  EmojiCollectionViewModel.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import RxSwift
import RxCocoa
import BKRedux
import ReactComponentKit

struct EmojiCollectionState: State {
    var emoji: [[String]] = [[], [], []]
    var sections: [SectionModel] = []
    var error: (Error, Action)? = nil
}

class EmojiCollectionViewModel: RootViewModelType<EmojiCollectionState> {
    
    private var emojiGroupList: [[String]]? = nil
    let rx_sections =  BehaviorRelay<[SectionModel]>(value: [])
    
    override init() {
        super.init()
        
        store.set(
            initailState: EmojiCollectionState(),
            middlewares: [
                logToConsole
            ],
            reducers: [
                StateKeyPath(\EmojiCollectionState.emoji): emojiReducer
            ],
            postwares: [
                makeEmojiSectionModel
            ])
    }
    
    override func on(newState: EmojiCollectionState) {
        emojiGroupList = newState.emoji
        rx_sections.accept(newState.sections)
    }
    
    func randomIndexToDelete(at section: Int) -> Int? {
        guard let emojiGroupList = emojiGroupList else { return nil }
        guard emojiGroupList[section].count > 0 else { return nil }
        return Int(arc4random()) % emojiGroupList[section].count
    }
}
