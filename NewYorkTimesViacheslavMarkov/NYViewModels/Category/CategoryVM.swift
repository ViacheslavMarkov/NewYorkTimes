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
    func cellTapped(_ sender: CategoryVM)
}

public final class CategoryVM: ModernListVM<CategorySection, CategorySection.Item>, ModernListModeling {
    public var data = [CategorySection: [CategorySection.Item]]()
    public var snapshot = Snapshot()
    public weak var delegate: CategoryVMDelegating?
    
    private var responseData: OverviewData?
    
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
    
    public func fetchBooks() {
        let bookNamesAPI = CategoryAPI(requestObject: EmptyRequest())
        NetworkRequestManager.shared.call(bookNamesAPI) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                print(error)
            case .success(let response):
                print(response)
                self.responseData = response.results
            }
            self.updateDynamicBooksDataSource()
        }
    }
    
    private func updateDynamicBooksDataSource() {
        guard
            let response = responseData,
            let list = responseData?.lists
        else { return }
//        let models = list.compactMap({ CategoryModel.init(id: UUID().uuidString, name: $0.displayName, date: response.publishedDate) })
        
        var listItems: [CategorySection.Item] = []
        list.forEach { category in
            let model: CategoryModel = .init(id: UUID().uuidString, name: category.displayName, date: response.publishedDate)
            let item = CategorySection.Item.list(item: model)
            listItems.append(item)
        }
        let emptyMessItem = CategorySection.Item.emptyMessage(item: "No books!")
        
        data = [
            .list: listItems,
            .emptyMessage: [emptyMessItem]
        ]
        
        applySnapshot()
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
                return CellLayoutFactory.makeFullWidthAndHeightCellLayout(
                    itemWidth: .fractionalWidth(1),
                    itemHeight: .estimated(60)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard
            let item = itemFrom(indexPath: indexPath)
        else { return }
        
        switch item {
        case .list(let item):
            delegate?.cellTapped(self)
            print("Selected: \(item)")
        default:
            assertionFailure("Wrong item sent to \(#function).")
        }
        print("Selected: \(indexPath)")
    }
}

// MARK: - CategoryCVCellDelegating
extension CategoryVM: CategoryCVCellDelegating {
    
}
