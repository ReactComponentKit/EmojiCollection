# EmojiCollection

This is [ReactComponentKit](https://github.com/ReactComponentKit/ReactComponentKit) example. EmojiCollection is built on Components, MVVM and Redux.

## Screenshot

![](art/shot.png)

## What is ReactComponentKit

ReactComponentKit is a library for building a UIViewController based on Component. Additionary, It architect UIViewController as Redux with MVVM. If you use ReactComponentKit, You can make many scenes(UIViewController) more easily. You can share components among scenes. 

## Using Diff algorithm for UICollectionView and UITableview

ReactComponentKit provides easy way to update UICollectionView and UITableView. Using diff, you can easily insert, delete or shuffle items like below :)

![](art/video.gif)

## How to getting start?

### Define Actions

We'll defien three actions for our emoji collection app. AddEmojiAction, RemoveEmojiAction and ShuffleEmojiAction.

#### AddEmojiAction

```swift
struct AddEmojiAction: Action {
    let section: Int
    let emoji: String
}
```

#### RemoveEmojiAction

```swift
struct RemoveEmojiAction: Action {
    let section: Int
    let index: Int
}
```

#### ShuffleEmojiAction

```swift
struct ShuffleEmojiAction: Action {   
}
```

### Define Reducers

We need three reducers to mutate our state. There is no when statement and type castring for actions. it is just a pure functions.

#### addEmoji

```swift
func addEmoji(state: EmojiCollectionState, action: AddEmojiAction) -> EmojiCollectionState {
    return state.copy {
        $0.emoji[action.section].append(action.emoji)
    }
}
```

#### removeEmoji

```swift
func removeEmoji(state: EmojiCollectionState, action: RemoveEmojiAction) -> EmojiCollectionState {
    return state.copy {
        $0.emoji[action.section].remove(at: action.index)
    }
}
```

#### shuffleEmoji

```swift
func shuffleEmoji(state: EmojiCollectionState, action: ShuffleEmojiAction) -> EmojiCollectionState {
    return state.copy {
        for (index, var section) in $0.emoji.enumerated() {
            section.shuffle()
            $0.emoji[index] = section
        }
    }
}
```

#### makeCollectionViewSectionModels

It is needed for our collection view. UICollectionView in ReactComponentKit is built up on the models for items and sections.

```swift
func makeCollectionViewSectionModels(state: EmojiCollectionState) -> EmojiCollectionState {
    let emojiGroupList = state.emoji
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
    
    return state.copy { $0.sections = sections }
}
```

### Define ViewModel and Action Flows

We need to define ViewModel and in there we should setup store and define action flows.

#### Set up store and define action flows

We can define action flows in initStore block. We couldn't access the store directly so we should access it with initStore method.

```swift
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
```

#### Define ViewModel

```swift
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
```


## MIT License

The MIT License

Copyright © 2018 Sungcheol Kim, https://github.com/ReactComponentKit/EmojiCollectionView

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
