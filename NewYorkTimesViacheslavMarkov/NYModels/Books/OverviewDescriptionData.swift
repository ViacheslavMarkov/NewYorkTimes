//
//  OverviewDescriptionData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public struct OverviewDescriptionData: Decodable {
    public let listId: Int
    public let displayName: String
    public let books: [BookData]
    
    enum CodingKeys: String, CodingKey {
        case listId = "list_id"
        case displayName = "display_name"
        case books
    }
    
    init(
        listId: Int,
        displayName: String,
        books: [BookData]
    ) {
        self.listId = listId
        self.displayName = displayName
        self.books = books
    }
}
