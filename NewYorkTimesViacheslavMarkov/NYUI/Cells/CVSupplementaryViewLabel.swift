//
//  CVSupplementaryViewLabel.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

public final class CVSupplementaryViewLabel: UICollectionReusableView {
    public static var elementKind = UICollectionView.elementKindSectionHeader

    public let label: UILabel = {
        let l = UILabel()
        l.textColor = .black
        l.textAlignment = .center
        l.numberOfLines = 0
        return l
    }()

    public lazy var labelTopConstraint = label.top.constraint(equalTo: top)
    public lazy var labelLeadingConstraint = label.leading.constraint(equalTo: leading, constant: 24)
    public lazy var labelTrailingConstraint = label.trailing.constraint(equalTo: trailing, constant: -24)
    public lazy var labelBottomConstraint = label.bottom.constraint(equalTo: bottom)

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }

    private func setup() {
        add([
            label
        ])

        NSLayoutConstraint.activate([
            labelTopConstraint,
            labelLeadingConstraint,
            labelTrailingConstraint,
            labelBottomConstraint
        ])
    }

    public func configure(insets: UIEdgeInsets) {
        labelTopConstraint.constant = insets.top
        labelLeadingConstraint.constant = insets.left
        labelTrailingConstraint.constant = -insets.right
        labelBottomConstraint.constant = -insets.bottom
        
        layoutIfNeeded()
    }
}
