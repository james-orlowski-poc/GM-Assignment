//
//  HistoryTableViewController.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    static let segueIdentifier = "HistoryTableViewController"
    
    fileprivate var commitHistoryDataList = [CommitHistoryData]()
    
    weak var homeViewControllerDelegate: HomeViewControllerDelegate?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        refreshTableViewData(showActivityIndicator: true)
    }
    
    fileprivate func setupTableView() {
        self.tableView.tableFooterView = UIView()
        refreshControl?.addTarget(self, action: #selector(refreshControlActivated), for: .valueChanged)
    }
    
    // MARK: - UI Refresh
    
    fileprivate func refreshTableViewData(showActivityIndicator: Bool) {
        if commitHistoryDataList.isEmpty {
            self.view.alpha = 0
        }

        if showActivityIndicator {
            homeViewControllerDelegate?.showActivityIndicator()
        }
        
        APIUtility.getCommitHistoryData { [weak self] (commitHistoryDataList: [CommitHistoryData]?, errorData: ErrorData?) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let validCommitHistoryDataList = commitHistoryDataList {
                    self.commitHistoryDataList = validCommitHistoryDataList
                    self.tableView.reloadData()
                }
                
                self.homeViewControllerDelegate?.hideActivityIndicator()
                
                if let validRefreshControl = self.refreshControl {
                    if validRefreshControl.isRefreshing {
                        validRefreshControl.endRefreshing()
                    }
                }
                
                UIView.animate(withDuration: 0.2, delay: 0.2) {
                    self.tableView.alpha = 1
                }
                
                if let validErrorData = errorData {
                    self.showConnectionFailureAlert(errorData: validErrorData)
                }
            }
        }
    }
    
    // MARK: - Alert Errors
    
    fileprivate func showConnectionFailureAlert(errorData: ErrorData) {
        let alert = UIAlertController(title: errorData.title, message: errorData.message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] action in
            guard let self = self else { return }
            self.refreshTableViewData(showActivityIndicator: true)
        }))

        self.present(alert, animated: true)
    }
    
    // MARK: - UIRefreshControl Actions
    
    @objc func refreshControlActivated() {
        // Don't show the activity indicator on the parent view controller, use the one that is built in the refresh control action
        refreshTableViewData(showActivityIndicator: false)
    }

    // MARK: - UITableViewDelegate + UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitHistoryDataList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath)

        let commitHistoryData = commitHistoryDataList[indexPath.row]
        (cell as? HistoryTableViewCell)?.configure(commitHistoryData: commitHistoryData)

        return cell
    }
}
