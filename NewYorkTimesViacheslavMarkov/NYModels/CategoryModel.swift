//
//  CategoryModel.swift
//  NYModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import Foundation

public struct CategoryModel: Codable, Hashable {
    public let id: Int
    public let name: String
    public let date: String
    
    public init(
        id: Int,
        name: String,
        date: String
    ) {
        self.id = id
        self.name = name
        self.date = date
    }
}
