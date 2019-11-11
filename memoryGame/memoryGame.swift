//
//  memoryGame.swift
//  memoryGame
//
//  Created by Ani on 9/10/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import Foundation

struct  MemoryGame {
    
    var cards = [Card]()
    private var indexOfOneCard: Int?
    
    mutating func chooseCard(at index: Int){
        if !cards[index].isMatched {
            if  let match = indexOfOneCard {
                if(match != index) {
                    if cards[match] == cards[index] {
                        cards[index].isMatched = true
                        cards[match].isMatched = true
                        
                    }
                    cards[index].isfaceUp = true
                    indexOfOneCard = nil
                }
            }else {
                for i in cards.indices{
                    cards[i].isfaceUp = false
                }
                cards[index].isfaceUp = true
                indexOfOneCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards{
            let card = Card()
            cards.append(card)
            cards.append(card)
        }
        cards.shuffle()
    }
}
