//
//  CategoryModel.swift
//  NYModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import Foundation

public struct CategoryModel: Identifiable, Codable, Hashable {
    public let id = UUID().uuidString
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}
