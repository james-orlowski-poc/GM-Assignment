//
//  APIUtility.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import Foundation

class APIUtility {
    
    static let urlString = "https://api.github.com/repos/james-orlowski-poc/GM-Assignment/commits"

    /**
     This function performs a GET request to the GitHub API, which then decodes that data to an object. That object will provide data for the table view.

     - Parameter rootDataList: Relevant commit history data
     - Parameter errorData: An error message (in the form of UIAlertController) to show the user if an error occurred during this process.
    */
    static func getCommitHistoryData(completion: @escaping (_ rootDataList: [CommitHistoryData]?, _ errorData: ErrorData?) -> Void) {
        fetchHistoryDataFromAPI(urlString: urlString) { (data: Data?, statusCode: Int?) in
            if statusCode != 200 {
                let statusCodeString: String
                if let validStatusCode = statusCode {
                    statusCodeString = "Response status code \(validStatusCode)."
                } else {
                    statusCodeString = "Unknown response status code."
                }
                
                let errorData = ErrorData(title: "Connection Failure", message:  "An error occurred while communicating with the GitHub API. \(statusCodeString)")
                completion(nil, errorData)
                return
            }
            
            if let validData = data, let commitHistoryDataList = self.decodeJSONData(jsonData: validData) {
                // Expected case. We were able to connect to the API + able to decode the message successfully!
                completion(commitHistoryDataList, nil)
            } else {
                let errorData = ErrorData(title: "Data Failure", message:  "An error occurred while decoding the JSON string.")
                completion(nil, errorData)
            }
        }
    }
    
    static func fetchHistoryDataFromAPI(urlString: String, completion: @escaping (Data?, Int?) -> Void) {
        if let url = URL(string: urlString) {
            // Ephemeral isn't essential here, but it's nice to always get the latest data from the API without cache related features getting in the way
            let urlSession = URLSession(configuration: .ephemeral)
                
            urlSession.dataTask(with: url) { data, response, error in
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                completion(data, statusCode)
            }.resume()
        } else {
            completion(nil, nil)
        }
    }
    
    static func decodeJSONData(jsonData: Data) -> [CommitHistoryData]? {
        return try? JSONDecoder().decode([CommitHistoryData].self, from: jsonData)
    }
}
