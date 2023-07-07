//
//  BookNamesAPI.swift
//  NYNetworking
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYUtilities
import NYModels

public final class BookNamesAPI: API<EmptyRequest, BookNamesResponse> {
    public override func makePathComponent() -> String {
            return "/lists/names.json"
    }
    
    public override func makeMethodType() -> HTTPMethodType {
            return .get
    }
    
    public override func makeQueryItems() -> [URLQueryItem]? {
            return [
                .init(name: "api-key", value: "\(AppKey.appKeyNYT)")
            ]
        }
}
