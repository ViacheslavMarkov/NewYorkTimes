//
//  ModernListVM.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYUI

public typealias SectionConforming = Hashable & CaseIterable

open class ModernListVM<Section: SectionConforming, Item: Hashable>: NSObject {
    public typealias DataSource = UICollectionViewDiffableDataSource<Section, Item>
    public typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Item>

    public var dataSource: DataSource? = nil

    open func sectionFrom(section: Int) -> Section? {
        dataSource?.snapshot().sectionIdentifiers[section]
    }

    open func itemFrom(indexPath: IndexPath) -> Item? {
        guard let section = sectionFrom(section: indexPath.section) else { return nil }
        return dataSource?.snapshot().itemIdentifiers(inSection: section)[indexPath.row]
    }
}
