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

class EmojiCollectionViewModel: RootViewModelType {
    
    private var emojiGroupList: [[String]]? = nil
    let rx_sections =  BehaviorRelay<[DefaultSectionModel]>(value: [])
    
    override init() {
        super.init()
        
        store.set(
            state: [
                "emoji": [
                    [String](),
                    [String](),
                    [String]()
                ]
            ],
            reducers: [
                "emoji": emojiReducer
            ],
            middlewares: [
                logToConsole
            ],
            postwares: [
                makeEmojiSectionModel
            ])
    }
    
    override func on(newState: [String : State]?) {
        emojiGroupList = newState?["emoji"] as? [[String]]
        guard let sections = newState?["sections"] as? [DefaultSectionModel] else { return }
        rx_sections.accept(sections)
    }
    
    func randomIndexToDelete(at section: Int) -> Int? {
        guard let emojiGroupList = emojiGroupList else { return nil }
        guard emojiGroupList[section].count > 0 else { return nil }
        return Int(arc4random()) % emojiGroupList[section].count
    }
}
