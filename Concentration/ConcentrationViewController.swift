//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Shannon on 3/2/18.
//  Copyright © 2018 Shannon. All rights reserved.
//
//  In which the GM sets up the game

import UIKit

class ConcentrationViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    private var emoji = [Card:String]()
    private lazy var emojiChoices = randomEmojiSet[randomEmojiSet.count.arc4random]
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    private(set) var flipCount = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    var theme: String? {
        didSet {
            emojiChoices = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    let randomEmojiSet = [
        "🐶🐯🐭🐰🦊🐵🐸🦄🐉🐿🐬🦕",
        "🍏🍌🍇🥑🍉🍋🍒🍓🍆🌽🥕🥒",
        "⌚️📱💾💿☎️🕰⏳📡🔋📷🖨🔦"
    ]
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        pickEmojiSet()
        emoji = [Card:String]()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
        flipCount = 0
    }
    
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeColor : UIColor.brown,
            .foregroundColor : UIColor.blue,
            .strokeWidth : 5.0
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: UIControlState.normal)
                    button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
                } else {
                    button.setTitle("", for: UIControlState.normal)
                    button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 0):#colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1)
                }
                
            }
        }
    }
    
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    func pickEmojiSet() {
        emojiChoices = randomEmojiSet[randomEmojiSet.count.arc4random]
    }
    
}

//MARK: Random number generator!!!
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(self)))
        } else {
            return 0
        }
    }
}
