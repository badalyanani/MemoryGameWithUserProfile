//
//  ConcentrationViewController.swift
//  memoryGame
//
//  Created by Ani on 9/3/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    lazy var game = MemoryGame(numberOfPairsOfCards: (buttonArray.count + 1) / 2)
    
    
    @IBAction func startNewGame(_ sender: UIButton) {
        flipCount = 0
        game.cards.removeAll()
        emoji.removeAll()
        game = MemoryGame(numberOfPairsOfCards: (buttonArray.count + 1) / 2)
        updateViewFromModel()
    }
    
    
    
    @IBOutlet var flipcountLabel: UILabel!
    
    var flipCount:Int = 1{
        willSet{
            flipcountLabel.text = "count = \(flipCount)"
        }
    }
    
    func updateViewFromModel(){
        var count = 0
        flipCount += 1
        for index in buttonArray.indices{
            let button = buttonArray[index]
            let card = game.cards[index]
            
            if(card.isfaceUp){
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                //button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle(emoji(for: card), for: .normal)
                
                count += 1
                
            } else {
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.8993703127, green: 0.7762916684, blue: 0.8892338872, alpha: 1)
                // button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.setTitle("", for: .normal)
                
                
            }
            
            if(buttonArray.count == 2){
                button.setTitle("?", for: .normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
                // button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
            }
            
            
            
        }
        print(count )
    }
    
    
    func emoji(for card: Card) -> String{
        if(emoji[card.indentifier] == nil) {
            if(emojiChoices.count > 0) {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.indentifier] = emojiChoices.remove(at: randomIndex)
            }
            
        }
        
        
        return emoji[card.indentifier]! ?? "?"
        
    }
    
    var theme: String? {
        didSet{
            emojiChoices = [theme ?? ""]
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    var emojiChoices = ["❄️","🌿", "🐁", "🕊","🔔", "🌜", "🙀", "🤡"]
    
    var emoji = Dictionary<Int, String>()
    
    
    @IBOutlet var buttonArray: [UIButton]!
    
    
    @IBAction func touchButton(_ sender: UIButton) {
        
        if let cardNumber = buttonArray.firstIndex(of: sender){
            
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    
}

