//
//  HistoryTableViewController.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath)

        let authorString = "Author #\(indexPath.row)"
        let messageString = "Commit Message #\(indexPath.row)"
        let hashString = "Hash Value #\(indexPath.row)"
        (cell as? HistoryTableViewCell)?.configure(authorString: authorString, messageString: messageString, hashString: hashString)

        return cell
    }

}
