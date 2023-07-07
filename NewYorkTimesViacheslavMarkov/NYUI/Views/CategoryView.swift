//
//  CategoryView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

public final class CategoryView: UIView {
    public let collectionView = CollectionView()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(.noStoryboards)
    }
    
    private func setup() {
        add([
            collectionView
        ])

        NSLayoutConstraint.activate([
            collectionView.top.constraint(equalTo: top),
            collectionView.leading.constraint(equalTo: leading),
            collectionView.trailing.constraint(equalTo: trailing),
            collectionView.bottom.constraint(equalTo: bottom)
        ])
    }
}
