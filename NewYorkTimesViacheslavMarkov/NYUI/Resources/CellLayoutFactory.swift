//
//  CellLayoutFactory.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYUtilities

public protocol CellLayoutConforming {
    associatedtype Item = NSCollectionLayoutItem
    associatedtype Size = NSCollectionLayoutSize
    associatedtype Dimension = NSCollectionLayoutDimension
    associatedtype Group = NSCollectionLayoutGroup
    associatedtype Section = NSCollectionLayoutSection
    associatedtype Spacing = NSCollectionLayoutSpacing
}

public enum CellLayoutFactory: CellLayoutConforming {
    public static func makeFullWidthAndHeightCellLayout(itemWidth: Dimension,
                                                        itemHeight: Dimension) -> Section {
        let itemSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = Item(layoutSize: itemSize)

        let groupSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let group = Group.vertical(layoutSize: groupSize, subitems: [item])

        let section = Section(group: group)
        
        let headerFooterLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(32)
        )
        var boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem]()
        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerFooterLayoutSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top,
            absoluteOffset: .init(x: 0, y: -16)
        )
        
        boundarySupplementaryItems.append(headerView)
        section.boundarySupplementaryItems = boundarySupplementaryItems

        return section
    }
    
        public static func makeFullWidthAndHeightWithoutHeaderCellLayout(itemWidth: Dimension,
                                                            itemHeight: Dimension) -> Section {
            let itemSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
            let item = Item(layoutSize: itemSize)

            let groupSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
            let group = Group.vertical(layoutSize: groupSize, subitems: [item])

            let section = Section(group: group)

            return section
        }
    
//    public static func makeCategorySnapshotScrollingLayout(
//        itemWidth: Dimension,
//        itemHeight: Dimension,
//        layoutEnvironment: NSCollectionLayoutEnvironment,
//        itemsCount: Int = 1,
//        groupInterItemSpacing: CGFloat = 0,
//        sectionInsets: NSDirectionalEdgeInsets = .zero,
//        scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
//    ) -> Section {
//        let itemSize = Size(widthDimension: itemWidth,
//                            heightDimension: itemHeight)
//        let item = Item(layoutSize: itemSize)
//
//        let rowSize = Size(widthDimension: .absolute(layoutEnvironment.contentWidth),
//                           heightDimension: itemHeight)
//        let rowGroup = Group.horizontal(layoutSize: rowSize,
//                                        subitem: item,
//                                        count: 3)
//        rowGroup.interItemSpacing = .fixed(groupInterItemSpacing)
//
//        var rows = CGFloat(1)
//        if itemsCount > 3 {
//            rows = CGFloat(itemsCount / 3) + 1
//        }
//
//        let verticalGroupHeight = ((rows * itemHeight.dimension) + ((rows - 1) * groupInterItemSpacing))
//        let verticalGroupSize = Size(widthDimension: .absolute(layoutEnvironment.contentWidth),
//                                     heightDimension: .estimated(verticalGroupHeight))
//        let verticalGroup = Group.vertical(layoutSize: verticalGroupSize,
//                                           subitem: rowGroup,
//                                           count: Int(rows))
//        verticalGroup.interItemSpacing = .fixed(groupInterItemSpacing)
//
//        let headerFooterLayoutSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(32)
//        )
//
//        var boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem]()
//        let headerView = NSCollectionLayoutBoundarySupplementaryItem(
//            layoutSize: headerFooterLayoutSize,
//            elementKind: UICollectionView.elementKindSectionHeader,
//            alignment: .top,
//            absoluteOffset: .init(x: 0, y: -16)
//        )
//
//        let section = Section(group: verticalGroup)
//        section.contentInsets = sectionInsets
//        section.orthogonalScrollingBehavior = scrollingBehavior
//
//        boundarySupplementaryItems.append(headerView)
//        section.boundarySupplementaryItems = boundarySupplementaryItems
//
//        return section
//    }
    
    public static func makeCustomWidthAndHeightScrollingCellsLayout(
        itemWidth: Dimension,
        itemHeight: Dimension,
        itemsCount: Int = 1,
        directionType: DirectionType = .vertical,
        groupInterItemSpacing: CGFloat = 0,
        sectionInsets: NSDirectionalEdgeInsets = .zero,
        hasHeader: Bool = false,
        hasFooter: Bool = false,
        scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior = .continuous
    ) -> Section {
        let itemSize = Size(widthDimension: itemWidth, heightDimension: itemHeight)
        let item = Item(layoutSize: itemSize)

        let group: Group = {
            switch directionType {
            case .horizontal:
                var width = itemWidth.dimension * CGFloat(itemsCount)
                width += (CGFloat(itemsCount - 1) * groupInterItemSpacing)
                let size = Size(widthDimension: .estimated(width), heightDimension: itemHeight)
                return Group.horizontal(layoutSize: size, subitem: item, count: itemsCount)
            case .vertical:
                var height = itemHeight.dimension * CGFloat(itemsCount)
                height += (CGFloat(itemsCount - 1) * groupInterItemSpacing)
                let size = Size(widthDimension: itemWidth, heightDimension: .estimated(height))
                return Group.vertical(layoutSize: size, subitem: item, count: itemsCount)
            }
        }()
        group.interItemSpacing = .fixed(groupInterItemSpacing)

        let section = Section(group: group)
        section.contentInsets = sectionInsets
        section.orthogonalScrollingBehavior = scrollingBehavior

        let headerFooterLayoutSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(90)
        )

        var boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem]()
        if hasHeader {
            let headerView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterLayoutSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top,
                absoluteOffset: .init(x: 0, y: -16)
            )
            boundarySupplementaryItems.append(headerView)
        }

        if hasFooter {
            let footerView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerFooterLayoutSize,
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom,
                absoluteOffset: .init(x: 0, y: 16)
            )
            boundarySupplementaryItems.append(footerView)
        }
        section.boundarySupplementaryItems = boundarySupplementaryItems
        return section
    }
}
