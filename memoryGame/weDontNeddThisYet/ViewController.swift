//
//  ViewController.swift
//  memoryGame
//
//  Created by Ani on 9/3/19.
//  Copyright © 2019 Ani. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    private lazy var game = MemoryGame(numberOfPairsOfCards: (buttonArray.count + 1) / 2)
    var score = 0
    
    var numberOfPairsOfCard:Int {
        return (buttonArray.count + 1)/2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func profileButtonPressed(_ sender: UIBarButtonItem) {
        if (flipCount > 32){
            score -= 1
        } else if (flipCount <= 32 && flipCount >= 16){
            score += 1
        }
        UserModel.shared.score = score
        let vc = storyboard?.instantiateViewController(identifier: "id")
        navigationController?.pushViewController(vc!, animated: true)
    }
    
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
            flipcountLabel.textColor = #colorLiteral(red: 0.07415982336, green: 0.1382184625, blue: 1, alpha: 1)
        }
    }
    
    func updateViewFromModel(){
        if buttonArray != nil{
            var count = 0
            flipCount += 1
            for index in buttonArray.indices{
                let button = buttonArray[index]
                let card = game.cards[index]
                
                if(card.isfaceUp){
                    button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    button.setTitle(emoji(for: card), for: .normal)
                    
                    count += 1
                    
                } else {
                    button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.8993703127, green: 0.7762916684, blue: 0.8892338872, alpha: 1)
                    button.setTitle("", for: .normal)
                    
                    
                }
                
                if(buttonArray.count == 2){
                    button.setTitle("?", for: .normal)
                    button.backgroundColor = card.isMatched ? UIColor.clear : #colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.9568627451, alpha: 1)
                }
            }
        }
    }
    
    private func emoji(for card: Card) -> String{
        
        let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
        if(emoji[card] == nil) {
            if(emojiChoices.count > 0) {
                
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
                emojiChoices.append(emoji[card] ?? "?")
            }
        }
        return emoji[card] ?? "?"
    }
    var theme: String? {
        didSet{
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    private var emojiChoices = "❄️🌿🐁🕊🔔🌜🙀🤡⚽️🏀🏈⚾️🥎🏐🏓🥊🇧🇩🏳️"
    private var emoji = [Card:String]()
    
    @IBOutlet var buttonArray: [UIButton]!
    @IBAction func touchButton(_ sender: UIButton) {
        if let cardNumber = buttonArray.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
    }
}

extension Int {
    var arc4random:Int {
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0
        {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else{
            return 0
        }
    }
}
