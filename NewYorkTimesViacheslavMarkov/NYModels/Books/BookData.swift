//
//  BookData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import Foundation

public struct BookData: Decodable, Identifiable {
    public let id = UUID().uuidString
    
    public let listName             : String
    public let displayName          : String
    public let oldestPublishedDate  : String
    
    enum CodingKeys: String, CodingKey {
        case listName               = "list_name"
        case displayName            = "display_name"
        case oldestPublishedDate    = "oldest_published_date"
    }
}
