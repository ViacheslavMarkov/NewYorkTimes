//
//  ViewModelDelegating.swift
//  NYViewModels
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYUI
import NYUtilities

public protocol ViewModelDelegating: UIViewController {
    func collectionView() -> CollectionView?
    func tableView() -> TableView?
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    func presentBasicAlert(_ error: GenericError)
}

public extension ViewModelDelegating {
    func collectionView() -> CollectionView? {
        nil
    }

    func tableView() -> TableView? {
        nil
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {}

    func presentBasicAlert(_ error: GenericError) {
        presentBasicAlert(message: error.errorDescription)
    }
}
