//
//  BookSection.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYModels

public enum BookSection: Int, CaseIterable {
    case first

    public enum Item: Hashable {
        case list(item: BookData)
    }
}
