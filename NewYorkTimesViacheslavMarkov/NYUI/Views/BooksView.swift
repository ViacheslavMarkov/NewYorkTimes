//
//  BooksView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public final class BooksView: UIView {
    public let collectionView = CollectionView()
    
    private let title: UILabel = {
        let l = UILabel()
        l.text = "Books"
        l.font = UIFont.systemFont(ofSize: 24)
        l.textAlignment = .center
        return l
    }()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError(.noStoryboards)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .white
    }
    
    private func setup() {
        add([
            title,
            collectionView
        ])

        NSLayoutConstraint.activate([
            title.top.constraint(equalTo: safeTop, constant: 12),
            title.leading.constraint(equalTo: leading, constant: 16),
            title.trailing.constraint(equalTo: trailing, constant: -16),
            title.height.constraint(equalToConstant: 24),
            
            collectionView.top.constraint(equalTo: title.bottom, constant: 12),
            collectionView.leading.constraint(equalTo: leading),
            collectionView.trailing.constraint(equalTo: trailing),
            collectionView.bottom.constraint(equalTo: bottom)
        ])
    }
}
