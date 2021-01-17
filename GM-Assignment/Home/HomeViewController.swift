//
//  HomeViewController.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class HomeViewController: UIViewController, HomeViewControllerDelegate {
    
    // MARK: - Properties

    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    @IBOutlet var historyTableViewContainer: UIView!
    
    // MARK: - View Life Cycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == HistoryTableViewController.segueIdentifier {
            // Access the table view controller so that we can establish a delegate for the activity indicator
            let historyTableViewController = segue.destination as? HistoryTableViewController
            historyTableViewController?.homeViewControllerDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - HomeViewControllerDelegate
    
    func showActivityIndicator() {
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }
}
