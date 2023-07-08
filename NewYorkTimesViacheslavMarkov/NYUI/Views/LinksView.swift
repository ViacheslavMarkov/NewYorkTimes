//
//  LinksView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 08.07.2023.
//

import NYModels

public protocol LinksViewDelegating: AnyObject {
    func didTapLink(_ sender: LinksView, at link: String)
}

public final class LinksView: UIView {
    public weak var delegate: LinksViewDelegating?
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [],
            axis: .vertical
        )
        v.alignment = .fill
        v.distribution = .equalSpacing
        v.spacing = 8
        return v
    }()
    
    public init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        add([
            vStack
        ])
        
        NSLayoutConstraint.activate([
            vStack.top.constraint(equalTo: top, constant: 8),
            vStack.leading.constraint(equalTo: leading, constant: 8),
            vStack.trailing.constraint(equalTo: trailing, constant: -8),
            vStack.bottom.constraint(equalTo: bottom, constant: -8),
        ])
    }
    
    public func configureUI(items: [BuyLinksData]) {
        if vStack.arrangedSubviews.isEmpty {
            addViews(items: items)
        } else {
            if vStack.arrangedSubviews.count == items.count {
                for (value, view) in zip(items, vStack.arrangedSubviews) {
                    (view as? DictionaryView)?.keyLabel.text = value.name
                    (view as? DictionaryView)?.valueLabel.text = value.url
                }
            } else {
                vStack.removeArrangedSubviews()
                addViews(items: items)
            }
        }
    }
    
    private func makeView(name: String, link: String, tag: Int) -> DictionaryView {
        let v = DictionaryView()
        v.configureUI(key: name, value: link)
        v.keyLabel.numberOfLines = 1
        v.valueLabel.numberOfLines = 1
        v.valueLabel.isUserInteractionEnabled = true
        v.valueLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
        v.tag = tag
        return v
    }
    
    @objc
    private func labelTapped(sender: UITapGestureRecognizer) {
        guard
            let label = sender.view as? UILabel,
            var link = label.text
        else { return }
        let _ = link.removeFirst()
        let trimmedString = link.trimmingCharacters(in: .whitespaces)
        delegate?.didTapLink(self, at: trimmedString)
    }
    
    private func addViews(items: [BuyLinksData]) {
        for (index, value) in items.enumerated() {
            let v = makeView(name: value.name, link: value.url, tag: index)
            vStack.addArrangedSubview(v)
        }
    }
}

