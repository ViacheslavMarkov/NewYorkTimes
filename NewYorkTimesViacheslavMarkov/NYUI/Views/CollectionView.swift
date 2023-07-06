//
//  CollectionView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 04.07.2023.
//

public final class CollectionView: UICollectionView {
    public init(_ layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
        super.init(frame: .zero, collectionViewLayout: layout)
        setup()
    }

    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }

    private func setup() {
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delaysContentTouches = false
    }
}
