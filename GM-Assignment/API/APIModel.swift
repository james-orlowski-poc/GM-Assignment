//
//  APIModel.swift
//  GM-Assignment
//
//  Created by James Orlowski on 1/17/21.
//

import Foundation

struct CommitHistoryData: Decodable {
    struct Commit: Decodable {

        struct Author: Decodable {
            let name: String
        }

        let message: String
        let author: Author
    }
    
    let commit: Commit
    let sha: String
}
