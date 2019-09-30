//
//  CardController.swift
//  DeckOfOneCard
//
//  Created by Bethany Wride on 9/30/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import Foundation
import UIKit

class CardController {
    // Step 1: Copy and paste API URL and edit <<x>> and anything else that needs to be changed
    // Define a private, static constant called baseURL initialized with the string URL.
    private static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    // Void is no return value; mark as static to get access outside
    // Declare static function called drawCard with two parameters - numberOfCards of type Int and a completion block that completes with an array of Card objects.
    // Escape: exit its own scope if it cannot find a value (void) without crashing the app; must be declared escaping because Apple has set it as escaping
    static func drawCard(numberOfCards: Int, completion: @escaping ((_ card: [Card]) -> Void)) {
    // Get URL
    // Declare a constant called url which is assinged to the value of the closure's baseURL property (else a fatalError is returned, which should never occur).
        guard let url = self.baseURL else {fatalError("URL optional is nil")}
        // Creates components
        // Declare a variable called components to modify the URL and allow the number of cards returned to be changed.
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // Build URL with components and query items (as needed)
        // Declare a constant called cardCountQueryItem and assign it the value of a URLQueryItem using the initializer which takes in the key (name, i.e. count) and value of the query item (numberOfCards).
        let cardCountQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        // Set the cardCountQueryItem to the array of cardCountQUeryItems
        components?.queryItems = [cardCountQueryItem]
        // URL complete
        guard let finalURL = components?.url else { return }
        // Take the printed URL and throw it in a browser to make sure the correct data is being presented
        print(finalURL)
        
        // Start the dataTask
        // Use final URL; code inside closure is what you want to name things (data, error, etc)
        // Completion handler will return a response (_), error, and/or data
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // See if there's an error
            if let error = error {
                print("Error decoding data: \(error.localizedDescription)")
                }
            // If there isn't an error, attempt to decode by unwrapping the data passed into the closure
            guard let data = data else { return }
            // Initialized an instance of jsonDecoder
            let jsonDecoder = JSONDecoder()
            // Attempt to decode data into the TLD - intrinsically decodes all values in the dictionary, including nested structs (i.e. card.image)
            do {
                let deck = try jsonDecoder.decode(TopLevelDictionary.self, from: data)
                // Complete with an array of cards
                completion(deck.cards)
            } catch {
                completion([])
                return
            }
        }
        // Starts if it hasn't started and resumes if it has
        dataTask.resume()
    }
    
    static func getImage(forURL urlString: String, completion: @escaping (UIImage?) -> Void) {
        // Get URL
        guard let finalURL = URL(string: urlString) else { return }
        // Start dataTask
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // Check for error
            if let error = error {
                print("Error retrieving image: \(error.localizedDescription)")
            }
            // Easier to debug if we use two separate guard statements
            guard let data = data else { return }
            // With data, create image
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
        dataTask.resume()
    }
}
