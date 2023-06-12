//
//  Coin.swift
//  CoinBrowser
//
//  Created by Milo Kvarfordt on 6/12/23.
//

import Foundation

class Coin {
    
    let id: String
    let symbol: String
    let name: String
    
    //Fail-Able initializer
    init?(dictionary: [String:String] ) {
        // We need to unwrap the optional
      guard let id = dictionary["id"], // Subscript syntax
        let symbol = dictionary["symbol"],
                let name = dictionary["name"] else { return nil }
        
        self.id = id
        self.symbol = symbol
        self.name = name
    }
}
