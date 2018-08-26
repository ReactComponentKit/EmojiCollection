//
//  EmojiHelper.swift
//  EmojiCollectionApp
//
//  Created by burt on 2018. 8. 26..
//  Copyright © 2018년 Burt.K. All rights reserved.
//

import Foundation

enum EmojiHelper {
    private static let emojis = (0x1F600...0x1F64F)
    static func emoji() -> String? {
        return UnicodeScalar(emojis.random).map(String.init)
    }
}

/// @see { https://stackoverflow.com/questions/34712453/how-to-generate-a-random-number-in-a-range-10-20-using-swift }
extension CountableRange where Bound == Int {
    var random: Int {
        return lowerBound + numericCast(arc4random_uniform(numericCast(count)))
    }
    
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}

extension CountableClosedRange where Bound == Int {
    var random: Int {
        return lowerBound + numericCast(arc4random_uniform(numericCast(count)))
    }
    
    func random(_ n: Int) -> [Int] {
        return (0..<n).map { _ in random }
    }
}
