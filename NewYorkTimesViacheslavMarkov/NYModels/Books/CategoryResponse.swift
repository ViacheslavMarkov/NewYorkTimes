//
//  CategoryResponse.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYUtilities

public struct CategoryResponse: Decodable {
    public let status: StatusType
    public let numberOfResults: Int
    public let results: OverviewData
    
    enum CodingKeys: String, CodingKey {
        case status
        case results
        case numberOfResults = "num_results"
    }
}
