//
//  ViewController.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import ReactComponentKit


class EmojiCollectionViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = EmojiCollectionViewModel()
    
    private lazy var addEmojiButton: ButtonComponent = {
        let button = ButtonComponent(token: viewModel.token)
        button.title = "Add"
        button.action = { sender in
            if let emoji = EmojiHelper.emoji() {
                sender.dispatch(action: AddEmojiAction(section: Int(arc4random()%3), emoji: emoji))
            }
        }
        return button
    }()
    
    private lazy var removeEmojiButton: ButtonComponent = {
        let button = ButtonComponent(token: viewModel.token)
        button.title = "Remove"
        button.action = { sender in
            let section = Int(arc4random()%3)
            if let randomIndexToDelte = self.viewModel.randomIndexToDelete(at: section) {
                sender.dispatch(action: RemoveEmojiAction(section: section, index: randomIndexToDelte))
            }
        }
        return button
    }()
    
    private lazy var suffleEmojiButton: ButtonComponent = {
        let button = ButtonComponent(token: viewModel.token)
        button.title = "Shuffle"
        button.action = { sender in
            sender.dispatch(action: ShuffleEmojiAction())
        }
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.addEmojiButton, self.removeEmojiButton, self.suffleEmojiButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var emojiCollectionView: UICollectionViewComponent = {
        let collectionView = UICollectionViewComponent(token: viewModel.token)
        return collectionView
    }()
    
    private lazy var adapter: UICollectionViewAdapter = {
        let adapter = UICollectionViewAdapter(collectionViewComponent: self.emojiCollectionView, useDiff: true)
        return adapter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stackView)
        self.view.addSubview(emojiCollectionView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(48)
        }
        emojiCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(stackView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        setupEmojiCollectionView()
        
        viewModel
            .sections
            .asDriver()
            .drive(onNext: { [weak self] (sections) in
                guard let strongSelf = self else { return }
                strongSelf.adapter.set(sections: sections)
            })
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        viewModel.deinitialize()
    }
}

extension EmojiCollectionViewController {
    fileprivate func setupEmojiCollectionView() {
        emojiCollectionView.register(component: EmojiSectionHeaderComponent.self, viewType: .header)
        emojiCollectionView.register(component: EmojiBoxComponent.self)
        emojiCollectionView.adapter = adapter
    }
}

