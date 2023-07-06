//
//  ViewLoadable.swift
//  NYUI
//
//  Created by Viacheslav Markov on 04.07.2023.
//

public protocol ViewLoadable: UIViewController {
    associatedtype ViewType: UIView
}

public extension ViewLoadable {
    var customView: ViewType {
        guard let view = view.subviews.first(where: { $0 is ViewType }) as? ViewType else {
            assertionFailure("Couldn't create \(ViewType.self).")
            return ViewType()
        }
        return view
    }

    func addCustomView() {
        let customView: UIView
        switch ViewType.self {
        case is CollectionView.Type:
            customView = CollectionView()
        case is TableView.Type:
            customView = TableView()
        default:
            customView = ViewType()
        }
        view.add([customView])
        customView.autoPinEdgesToSuperView()
    }

    func add(customView: ViewType) {
        view.add([customView])
        customView.autoPinEdgesToSuperView()
    }
}
