//
//  OverviewData.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public struct OverviewData: Decodable {
    public let publishedDate: String
    public let lists: [OverviewDescriptionData]
    
    enum CodingKeys: String, CodingKey {
        case lists
        case publishedDate = "published_date"
    }
}
