//
//  HistoryTableViewCell.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var hashLabel: UILabel!

    func configure(authorString: String, messageString: String, hashString: String) {
        authorLabel.text = authorString
        messageLabel.text = messageString
        hashLabel.text = hashString
    }

}
