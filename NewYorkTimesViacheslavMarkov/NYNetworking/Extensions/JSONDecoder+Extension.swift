//
//  JSONDecoder+Extension.swift
//  NYNetworking
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public extension JSONDecoder {
    static func decode<T: Decodable>(
        _ type: T.Type,
        data: Data,
        dateFormatter: DateFormatter = .iso8601Full
    ) throws -> T {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return try decoder.decode(type, from: data)
    }
}
