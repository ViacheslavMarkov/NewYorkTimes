//
//  CategoryVM.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYNetworking
import NYUtilities
import NYUI
import NYModels

public protocol CategoryVMDelegating: ViewModelDelegating {
    
}

public final class CategoryVM: ModernListVM<CategorySection, CategorySection.Item>, ModernListModeling {
    public var data: [CategorySection: [CategorySection.Item]] {
        let emptyMessItem = CategorySection.Item.emptyMessage(item: "No categories!")
        
        return [
            .list: [],
            .emptyMessage: [emptyMessItem]
        ]
    }
    public var snapshot = Snapshot()
    public weak var delegate: CategoryVMDelegating?
    
    public override init() {
        super.init()
    }
    
    public func applySnapshot(animatingDifferences: Bool = true) {
        if snapshot.numberOfSections == .zero {
            snapshot.appendSections(CategorySection.allCases)
        }
        
        for (key, value) in data {
            snapshot.appendItems(value, toSection: key)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
}

// MARK: - UICollectionViewDataSource
public extension CategoryVM {
    func makeDataSource() -> DataSource? {
        guard let collectionView = delegate?.collectionView() else { return nil }
        
        let registration = CellRegistrationFactory.makeCategoryCellRegistration(delegate: self)
        
        let emptyMessageSnapshotCellReg = CellRegistrationFactory.makeEmptyMessageSnapshotCellRegistration()
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) in
            switch itemIdentifier {
            case .list(let item):
                let cell: CategoryCVCell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
                return cell
            case .emptyMessage(item: let item):
                return collectionView.dequeueConfiguredReusableCell(using: emptyMessageSnapshotCellReg, for: indexPath, item: item)
            }
        }
        
        let labelSupplementaryViewRegistration = UICollectionView.SupplementaryRegistration
        <CVSupplementaryViewLabel>(elementKind: CVSupplementaryViewLabel.elementKind) { [weak self] (supplementaryView, _, indexPath) in
            guard let section = self?.sectionFrom(section: indexPath.section) else { return }
            supplementaryView.label.textColor = .black
            supplementaryView.label.font = UIFont.systemFont(ofSize: 42, weight: .regular)
            supplementaryView.label.text = CategorySection.list.title
        }
        
        dataSource?.supplementaryViewProvider = { [weak self] (collectionView, _, indexPath) in
            guard let section = self?.sectionFrom(section: indexPath.section) else { return nil }

            switch section {
            case .list:
                return collectionView.dequeueConfiguredReusableSupplementary(
                    using: labelSupplementaryViewRegistration,
                    for: indexPath
                )
            default:
                return nil
            }
        }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
public extension CategoryVM {
    func makeLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, layoutEnvironment in
            guard
                let self = self,
                let section = self.sectionFrom(section: sectionIndex)
            else {
                return nil
            }
            
            switch section {
            case .list:
                let itemSpacing = CGFloat(2)
                let columns = CGFloat(3)
                let itemWidth = (layoutEnvironment.contentWidth / columns) - ((columns - 1) * itemSpacing)
                
                return CellLayoutFactory.makeCategorySnapshotScrollingLayout(
                    itemWidth: .absolute(itemWidth),
                    itemHeight: .absolute(170),
                    layoutEnvironment: layoutEnvironment,
                    itemsCount: self.data[.list]?.count ?? 0,
                    groupInterItemSpacing: itemSpacing
                )
            case .emptyMessage:
                return CellLayoutFactory.makeCustomWidthAndHeightScrollingCellsLayout(
                    itemWidth: .absolute(UIScreen.main.bounds.width),
                    itemHeight: .absolute(self.data[.list]?.isEmpty ?? true ? 100 : 0),
                    itemsCount: 1,
                    groupInterItemSpacing: 0,
                    sectionInsets: .init(top: 0, leading: 0, bottom: 0, trailing: 0),
                    hasHeader: false,
                    scrollingBehavior: .none
                )
            }
        }, configuration: config)
    }
}

// MARK: - CategoryCVCellDelegating
extension CategoryVM: CategoryCVCellDelegating {
    
}
