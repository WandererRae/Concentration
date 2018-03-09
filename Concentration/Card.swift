//
//  Card.swift
//  Concentration
//
//  Created by Shannon on 3/2/18.
//  Copyright © 2018 Shannon. All rights reserved.
//
//  In which the playing cards come into existence

import Foundation

struct Card: Hashable {

    //  TODO: The deck is chosen
    
    //  TODO: The cards have an appearance
    
    //  MARK: The cards gain face values
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init () {
        self.identifier = Card.getUniqueIdentifier()
    }

}
