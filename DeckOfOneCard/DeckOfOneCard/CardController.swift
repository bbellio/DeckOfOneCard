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
    private static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw/")
    
    // Void is no return value; mark as static to get access outside
    static func drawCard(numberOfCards: Int, completion: @escaping ((_ card: [Card]) -> Void)) {
    // Get URL
        guard let url = self.baseURL else {fatalError("URL optional is nil")}
        // Creates componennts
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)
        // Build URL with components and query items (as needed)
        let cardCountQueryItem = URLQueryItem(name: "count", value: "\(numberOfCards)")
        components?.queryItems = [cardCountQueryItem]
        // URL complete
        guard let finalURL = components?.url else { return }
        // Take the printed URL and throw it in a browser to make sure the correct data is being presented
        print(finalURL)
        
        // Start the dataTask
        // Use final URL; code inside closure is what you want to name things (data, error, etc)
   
        let dataTask = URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // See if there's an error
            if let error = error {
                print("Error decoding data: \(error.localizedDescription)")
                }
            // If there isn't an error, attempt to decode
            do {
                guard let data = data else { return }
                let jsonDecoder = JSONDecoder()
                // Use bang operator to force unwrap or can guard let it to unwrap
                let deck = try! jsonDecoder.decode(TopLevelDictionary.self, from: data)
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
