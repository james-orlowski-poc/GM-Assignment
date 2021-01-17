//
//  APIUtility.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import Foundation

class APIUtility {
    
    static func fetchHistoryDataFromAPI() {
        if let url = URL(string: "https://api.github.com/repos/james-orlowski-poc/GM-Assignment/commits") {
            // Ephemeral isn't essential here, but it's nice to always get the latest data from the API without cache related features getting in the way
            let urlSession = URLSession(configuration: .ephemeral)
                
            urlSession.dataTask(with: url) { data, response, error in
                guard let validData = data else {
                    print("Invalid Data!!")
                    return
                }
                
                let commitHistoryDataList = decodeJSONData(jsonData: validData)
                print(commitHistoryDataList)
            }.resume()
        }
    }
    
    static func decodeJSONData(jsonData: Data) -> [CommitHistoryData]? {
        return try? JSONDecoder().decode([CommitHistoryData].self, from: jsonData)
    }
    
}
