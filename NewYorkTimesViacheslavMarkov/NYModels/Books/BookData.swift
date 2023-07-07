//
//  BookData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import Foundation

public struct BookData: Decodable, Identifiable {
    public let id = UUID().uuidString
    
    public let imageUrlString   : String
    public let author           : String
    public let description      : String
    public let rank             : Int
    public let publisher        : String
    public let buyLinks         : [BuyLinksData]
    
    enum CodingKeys: String, CodingKey {
        case imageUrlString = "book_image"
        case author
        case description
        case rank
        case publisher
        case buyLinks       = "buy_links"
    }
}
