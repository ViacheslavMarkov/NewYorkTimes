//
//  CellRegistrationFactory.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYModels

public enum CellRegistrationFactory {
    public static func makeCategoryCellRegistration(
        delegate: CategoryCVCellDelegating?,
        _ customHandler: ((_ cell: CategoryCVCell, _ indexPath: IndexPath, _ item: CategoryModel) -> Void)? = nil
    ) -> UICollectionView.CellRegistration<CategoryCVCell, CategoryModel> {
        genericHandler(defaultHandler: { cell, _, item in
            cell.configureUI(with: item)
//            cell.configureVideoUI(item.hlsUrl)
            cell.delegate = delegate
        }, customHandler)
    }
    
    public static func makeEmptyMessageSnapshotCellRegistration(
        _ customHandler: ((_ cell: EmptyMessageCell, _ indexPath: IndexPath, _ item: String) -> Void)? = nil
    ) -> UICollectionView.CellRegistration<EmptyMessageCell, String> {
        genericHandler(defaultHandler: { cell, _, item in
            cell.configure(item: item)
        }, customHandler)
    }
    
    public static func makeBookCellRegistration(
        delegate: BookCVCellDelegating?,
        _ customHandler: ((_ cell: BookCVCell, _ indexPath: IndexPath, _ item: BookData) -> Void)? = nil
    ) -> UICollectionView.CellRegistration<BookCVCell, BookData> {
        genericHandler(defaultHandler: { cell, _, item in
            cell.configureUI(with: item)
            cell.delegate = delegate
        }, customHandler)
    }
}

// MARK: - Helpers
private extension CellRegistrationFactory {
    static func genericHandler<Cell: UICollectionViewCell, Item: Hashable>(
        defaultHandler: @escaping(_ cell: Cell,
                                  _ indexPath: IndexPath,
                                  _ item: Item) -> Void,
        _ customHandler: ((_ cell: Cell,
                           _ indexPath: IndexPath,
                           _ item: Item) -> Void)? = nil
    ) -> UICollectionView.CellRegistration<Cell, Item> {
        if let customHandler = customHandler {
            return UICollectionView.CellRegistration<Cell, Item>(handler: customHandler)
        }
        return UICollectionView.CellRegistration<Cell, Item>(handler: defaultHandler)
    }
}
