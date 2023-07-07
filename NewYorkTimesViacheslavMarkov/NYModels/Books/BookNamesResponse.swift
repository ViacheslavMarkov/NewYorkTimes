//
//  BookNamesResponse.swift
//  NYModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import Foundation

public struct BookNamesResponse: Decodable {
    public let status: String
    public let results: [BookData]?
}
