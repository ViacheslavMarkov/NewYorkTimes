//
//  BookNamesResponse.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import Foundation

public struct BookNamesResponse: Decodable {
    let status: String
    let results: [BookData]
}

public struct BookData: Decodable {
    let listName: String
    let displayName: String
    let oldestPublishedDate: String
    
    enum CodingKeys: String, CodingKey {
        case listName = "list_name"
        case displayName = "display_name"
        case oldestPublishedDate = "oldest_published_date"
    }
}
