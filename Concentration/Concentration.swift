//
//  Concentration.swift
//  Concentration
//
//  Created by Shannon on 3/2/18.
//  Copyright © 2018 Shannon. All rights reserved.
//
//  In which the rules of the game are determined

import Foundation

struct Concentration {
    //  MARK: Definitions
    private(set) var cards = [Card]()
    private(set) var unshuffledCards = [Card]()
    //  MARK: Shuffle the deck
    init (numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            unshuffledCards += [card, card]
        }
        for _ in 1...unshuffledCards.count {
            let shuffling = unshuffledCards.index(unshuffledCards.startIndex, offsetBy: unshuffledCards.count.arc4random)
            cards.append(unshuffledCards[shuffling])
            unshuffledCards.remove(at: shuffling)
        }
    }
    //  MARK: Make your move
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return  cards.indices.filter{cards[$0].isFaceUp}.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    mutating func chooseCard(at index:Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex =  indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
