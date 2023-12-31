//
//  CategoryAPI.swift
//  NYNetworking
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYUtilities
import NYModels

public final class CategoryAPI: API<EmptyRequest, CategoryResponse> {
    public override func makePathComponent() -> String {
            return "/lists/overview.json"
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
