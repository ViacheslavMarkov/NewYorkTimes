//
//  BookDetailView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYModels
import NYUtilities

public protocol BookDetailViewDelegating: AnyObject {
    func didTapLink(_ sender: BookDetailView, link: String)
}

public final class BookDetailView: UIView {
    private let imageWidth: CGFloat = UIScreen.main.bounds.width / 5
    private let listKeys = ["Author", "Description", "Published", "Rank"]
    
    public weak var delegate: BookDetailViewDelegating?
    
    private let mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.2)
        v.set(cornerRadius: 8)
        return v
    }()
    
    private let linksView: LinksView = {
        let l = LinksView()
        l.backgroundColor = .white
        l.set(borderColor: .black, borderWidth: 1)
        return l
    }()
    
    private let imageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .clear
        i.set(cornerRadius: 4)
        return i
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        l.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return l
    }()
    
    private let authorView = DictionaryView()
    private let descriptionView = DictionaryView()
    private let publishedView = DictionaryView()
    private let rankView = DictionaryView()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        add([
            mainView
        ])
        
        mainView.add([
            imageView,
            name,
            authorView,
            descriptionView,
            publishedView,
            rankView,
            linksView
        ])
        
        NSLayoutConstraint.activate([
            mainView.top.constraint(equalTo: top),
            mainView.leading.constraint(equalTo: leading, constant: 16),
            mainView.trailing.constraint(equalTo: trailing, constant: -16),
            mainView.bottom.constraint(equalTo: bottom, constant: -16),
            
            imageView.top.constraint(equalTo: name.top),
            imageView.trailing.constraint(equalTo: mainView.trailing, constant: -16),
            imageView.width.constraint(equalToConstant: imageWidth),
            imageView.height.constraint(lessThanOrEqualToConstant: imageWidth * 1.5),
            
            name.top.constraint(equalTo: mainView.top, constant: 4),
            name.leading.constraint(equalTo: mainView.leading, constant: 16),
            name.trailing.constraint(equalTo: imageView.leading, constant: -16),
            
            authorView.top.constraint(equalTo: name.bottom, constant: 12),
            authorView.leading.constraint(equalTo: mainView.leading, constant: 16),
            authorView.trailing.constraint(equalTo: imageView.leading, constant: -16),
            
            descriptionView.top.constraint(equalTo: authorView.bottom, constant: 12),
            descriptionView.leading.constraint(equalTo: mainView.leading, constant: 16),
            descriptionView.trailing.constraint(equalTo: imageView.leading, constant: -16),
            
            publishedView.top.constraint(equalTo: descriptionView.bottom, constant: 12),
            publishedView.leading.constraint(equalTo: mainView.leading, constant: 16),
            publishedView.trailing.constraint(equalTo: imageView.leading, constant: -16),
            
            rankView.top.constraint(equalTo: publishedView.bottom, constant: 12),
            rankView.leading.constraint(equalTo: mainView.leading, constant: 16),
            rankView.trailing.constraint(equalTo: imageView.leading, constant: -16),
            
            linksView.top.constraint(equalTo: rankView.bottom, constant: 12),
            linksView.leading.constraint(equalTo: mainView.leading, constant: 16),
            linksView.trailing.constraint(equalTo: imageView.leading, constant: -16),
            linksView.bottom.constraint(equalTo: mainView.bottom, constant: -8)
        ])
        
        linksView.delegate = self
    }
    
    public func configureUI(with model: BookData) {
        name.text = model.publisher
        
        imageView.imageFromServerURLWithCompletion(urlString: model.imageUrlString) { [weak self] (image) in
            self?.imageView.image = image
        }
        authorView.configureUI(key: listKeys[0], value: model.author)
        descriptionView.configureUI(key: listKeys[1], value: model.description)
        publishedView.configureUI(key: listKeys[2], value: model.publisher)
        rankView.configureUI(key: listKeys[3], value: "\(model.rank)")
        
        linksView.configureUI(items: model.buyLinks)
    }
}

extension BookDetailView: LinksViewDelegating {
    public func didTapLink(_ sender: LinksView, at link: String) {
        delegate?.didTapLink(self, link: link)
    }
}
