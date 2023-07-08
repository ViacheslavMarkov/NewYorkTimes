//
//  BooksVM.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 07.07.2023.
//


import NYNetworking
import NYUtilities
import NYUI
import NYModels

public protocol BooksVMDelegating: ViewModelDelegating {
}

public final class BooksVM: ModernListVM<BookSection, BookSection.Item>, ModernListModeling {
    public weak var delegate: BooksVMDelegating?
    
    public var data = [BookSection: [BookSection.Item]]()
    public var snapshot = Snapshot()
    
    private let books: [BookData]
    
    public init(
        books: [BookData]
    ) {
        self.books = books
        super.init()
    }
    
    public func applySnapshot(animatingDifferences: Bool = true) {
        if snapshot.numberOfSections == .zero {
            snapshot.appendSections(BookSection.allCases)
        }
        
        for (key, value) in data {
            snapshot.appendItems(value, toSection: key)
        }
        
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    public func updateDynamicBooksDataSource() {
        var listItems: [BookSection.Item] = []
        books.forEach { book in
            let item = BookSection.Item.list(item: book)
            listItems.append(item)
        }
        
        data = [
            .first: listItems
        ]
        
        applySnapshot()
    }
}

//MARK: - UICollectionViewDataSource
extension BooksVM {
    public func makeDataSource() -> DataSource? {
        guard let collectionView = delegate?.collectionView() else { return nil }
        
        let registration = CellRegistrationFactory.makeBookCellRegistration(delegate: self)
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier) in
            switch itemIdentifier {
            case .list(let item):
                let cell: BookCVCell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: item)
                return cell
            }
        }
        
        return dataSource
    }
}

// MARK: - UICollectionViewDelegate
extension BooksVM {
    public func makeLayout() -> UICollectionViewLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        
        return UICollectionViewCompositionalLayout(sectionProvider: { [weak self] sectionIndex, layoutEnvironment in
            guard
                let self = self,
                let section = self.sectionFrom(section: sectionIndex)
            else {
                return nil
            }
            
            switch section {
            case .first:
                return CellLayoutFactory.makeFullWidthAndHeightWithoutHeaderCellLayout(
                    itemWidth: .fractionalWidth(1),
                    itemHeight: .estimated(60)
                )
            }
        }, configuration: config)
    }
    
    func expandCell() {
        
    }
}

// MARK: - BookCVCellDelegating
extension BooksVM: BookCVCellDelegating {
    
}
