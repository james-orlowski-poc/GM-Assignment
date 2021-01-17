//
//  HistoryTableViewController.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import UIKit

class HistoryTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    fileprivate var commitHistoryDataList = [CommitHistoryData]()
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        refreshTableViewData()
    }
    
    fileprivate func setupTableView() {
        self.tableView.tableFooterView = UIView()
    }
    
    // MARK: - UI Refresh
    
    fileprivate func refreshTableViewData() {
        APIUtility.getCommitHistoryData { [weak self] (commitHistoryDataList: [CommitHistoryData]?, errorData: ErrorData?) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                if let validCommitHistoryDataList = commitHistoryDataList {
                    self.commitHistoryDataList = validCommitHistoryDataList
                    self.tableView.reloadData()
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
            print("Selected Retry")
        }))

        self.present(alert, animated: true)
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
