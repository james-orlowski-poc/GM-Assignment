//
//  HistoryTableViewCell.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryTableViewCell"
    
    @IBOutlet var cardView: UIView!
    @IBOutlet var cardViewBottom: NSLayoutConstraint!
    
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var hashLabel: UILabel!

    func configure(commitHistoryData: CommitHistoryData, isLastIndexPath: Bool) {
        cardView.layer.borderColor = UIColor.border?.cgColor
        cardView.layer.borderWidth = 0.5
        cardView.layer.cornerRadius = 3
        
        // This is a minor cosmetic improvement so that the table view as a whole appears to have uniform padding between each cell
        cardViewBottom.constant = isLastIndexPath ? 8 : 0
        
        authorLabel.text = commitHistoryData.commit.author.name
        messageLabel.text = commitHistoryData.commit.message
        hashLabel.text = commitHistoryData.sha
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Border colors aren't changed over automatically when switching themes
        cardView.layer.borderColor = UIColor.border?.cgColor
    }
}
