//
//  EmptyMessageCell.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYModels

public final class EmptyMessageCell: UICollectionViewCell {
    public var label: UILabel = {
        let l = UILabel()
        l.textColor = .black.withAlphaComponent(0.6)
        l.numberOfLines = 0
        return l
    }()

    public override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setup() {
        contentView.add([
            label
        ])

        NSLayoutConstraint.activate([
            label.centerX.constraint(equalTo: contentView.centerX),
            label.centerY.constraint(equalTo: contentView.centerY),
        ])
    }

    public func configure(item: String) {
        label.text = item
    }
}
