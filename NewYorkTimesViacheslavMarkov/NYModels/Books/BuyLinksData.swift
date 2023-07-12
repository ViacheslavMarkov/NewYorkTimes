//
//  BuyLinksData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public struct BuyLinksData: Decodable, Hashable {
    public let name : String
    public let url  : String
    
    init(
        name: String,
        url: String
    ) {
        self.name = name
        self.url = url
    }
}
