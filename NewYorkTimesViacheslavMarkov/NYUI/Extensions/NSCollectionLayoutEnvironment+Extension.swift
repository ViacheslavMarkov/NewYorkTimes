//
//  NSCollectionLayoutEnvironment+Extension.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

public extension NSCollectionLayoutEnvironment {
    var contentSize: CGSize {
        container.effectiveContentSize
    }

    var contentWidth: CGFloat {
        contentSize.width
    }

    var contentHeight: CGFloat {
        contentSize.height
    }
}
