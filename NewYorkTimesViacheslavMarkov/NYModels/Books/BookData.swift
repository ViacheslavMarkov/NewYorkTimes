//
//  BookData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import Foundation

public struct BookData: Decodable, Identifiable, Hashable {
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
    
    init(
        imageUrlString: String,
        author: String,
        description: String,
        rank: Int,
        publisher: String,
        buyLinks: [BuyLinksData]
    ) {
        self.imageUrlString = imageUrlString
        self.author = author
        self.description = description
        self.rank = rank
        self.publisher = publisher
        self.buyLinks = buyLinks
    }
}
