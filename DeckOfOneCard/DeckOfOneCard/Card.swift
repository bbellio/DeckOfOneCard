//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Bethany Wride on 9/30/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

struct TopLevelDictionary: Codable {
    /*
     JSON
     success : true
     deck_id : "l4c789rne8sv"
     remaining : 50
     cards
     */
    // Only need to access the key/values we need
    // names of constants must match exactly the names in the API or must use coding keys
    let success: Bool
    let deck_id: String
    let remaining: Int
    let cards: [Card]
}

struct Card: Codable {
    /*
    value : "7"
    image : "https://deckofcardsapi.com/static/img/7S.png"
    suit : "SPADES"
    images
    code : "7S"
    */
    
    let value: String
    let image: String
    let suit: String
}
