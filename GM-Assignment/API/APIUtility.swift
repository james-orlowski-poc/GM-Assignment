//
//  APIUtility.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import Foundation

class APIUtility {
    
    static let urlString = "https://api.github.com/repos/james-orlowski-poc/GM-Assignment/commits"
    
    static func getCommitHistoryData() {
        fetchHistoryDataFromAPI(urlString: urlString) { (data: Data?, statusCode: Int?) in            
            if let validData = data, let commitHistoryDataList = self.decodeJSONData(jsonData: validData) {
                // We were able to connect to the API + able to decode the message successfully!
                print(commitHistoryDataList)
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
