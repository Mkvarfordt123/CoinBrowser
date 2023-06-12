//
//  CoinListModelController.swift
//  CoinBrowser
//
//  Created by Milo Kvarfordt on 6/12/23.
//

import Foundation

class CoinListModelController {
    
    // MARK: - Properties
    // Base URL
    private static let urlStrings = "https://api.coingecko.com/api/v3"
    
    // Component Keys
    private static let kCoins = "coins"
    private static let kList = "list"
    static var coins: [Coin] = []
    
    
    
    // MARK: - Functions - create, read, update, delete
    //create  // not creating any data, the user is requesting the data from the API.
    static func fetchCoins(completion: @escaping (Bool) -> Void) {
        // Step 1 build complete URL
        guard let baseURL = URL(string: urlStrings) else { return
            completion(false)
        }
        let coinsURL = baseURL.appendingPathComponent(kCoins)
        let finalURL = coinsURL.appendingPathComponent(kList)
        print(finalURL)
        
        // Step 2 Data Task
        URLSession.shared.dataTask(with: finalURL) { coinData, _, error in
            // Step 1 Handle the error
            if let error {
                print("There was an error: \(error.localizedDescription)")
                completion(false)
            }
            // Check for Data
            guard let data = coinData else {
                completion(false)
                return
            }
            do {
                if let topLevelArrayOfCoinDictionaries = try
                    JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String : String]] {
                        for coinDictionary in topLevelArrayOfCoinDictionaries {
                            if let parsedCoin = Coin(dictionary: coinDictionary) {
                                coins.append(parsedCoin) }
                            }
                        }
           completion(true)
            } catch {
                print("There was an error in Do-Try-Catch: \(error.localizedDescription)")
                completion(false)
            }
        }.resume()
        }
    }

