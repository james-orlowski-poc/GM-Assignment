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

    func configure(commitHistoryData: CommitHistoryData) {
        authorLabel.text = commitHistoryData.commit.author.name
        messageLabel.text = commitHistoryData.commit.message
        hashLabel.text = commitHistoryData.sha
    }
}
