//
//  Card.swift
//  memoryGame
//
//  Created by Ani on 9/10/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import Foundation

struct Card: Hashable
{
    func hash(into hasher : inout Hasher){
        hasher.combine(indentifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool{
        return lhs.indentifier == rhs.indentifier
    }
    
    
    var isfaceUp = false
    var isMatched = false
    private var indentifier: Int
    
    private static var uniqueIndentifier = 0
    
    init() {
        self.indentifier = Card.generateUniqueIndentifier()
    }
    
    private static func generateUniqueIndentifier() -> Int {
    uniqueIndentifier += 1
        return uniqueIndentifier
    }
}
