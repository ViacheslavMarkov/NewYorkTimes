//
//  ModernListModeling.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYUI

public protocol DiffableViewModeling {
    associatedtype DataSource

    func makeDataSource() -> DataSource?
    func applySnapshot(animatingDifferences: Bool)
}

public protocol CompositionalLayoutModeling {
    func makeLayout() -> UICollectionViewLayout
}

public protocol ModernListModeling: DiffableViewModeling, CompositionalLayoutModeling, UICollectionViewDelegate {
}
