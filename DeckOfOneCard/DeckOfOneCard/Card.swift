//
//  Card.swift
//  DeckOfOneCard
//
//  Created by Bethany Wride on 9/30/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation

// Declared a struct called TopLevelDictionary; first dictionary to be decoded by initial dataTask. To find the JSON data, copy and paste the API URL into a JSON Viewer online.
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
    let cards: [Card]
}

// Declared a struct called Card which consists of images of type String (which represents the URL for each card image).
struct Card: Codable {
    /*
    value : "7"
    image : "https://deckofcardsapi.com/static/img/7S.png"
    suit : "SPADES"
    images
    code : "7S"
    */
    
    let image: String
}
