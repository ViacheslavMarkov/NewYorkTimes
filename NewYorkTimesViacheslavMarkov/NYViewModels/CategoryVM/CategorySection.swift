//
//  CategorySection.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYModels

public enum CategorySection: Int, CaseIterable {
    case list
    case emptyMessage

    public enum Item: Hashable {
        case list(item: CategoryModel)
        case emptyMessage(item: String)
    }
    
    public var title: String {
        switch self {
        case .list:
            return "Category"
        case.emptyMessage:
            return "List is empty!"
        }
    }
}
