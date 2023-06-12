//
//  CoinListTableViewController.swift
//  CoinBrowser
//
//  Created by Milo Kvarfordt on 6/12/23.
//

import UIKit

class CoinListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CoinListModelController.fetchCoins { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CoinListModelController.coins.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell", for: indexPath)

        let coin = CoinListModelController.coins[indexPath.row]
        var cellConfiguration = cell.defaultContentConfiguration()
        cellConfiguration.text = coin.name
        cellConfiguration.secondaryText = "symbol: \(coin.symbol), id: \(coin.id)"
        cell.contentConfiguration = cellConfiguration
        
        return cell
    }
}
