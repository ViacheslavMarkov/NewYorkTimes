//
//  CategoryCVCell.swift
//  NYUI
//
//  Created by Viacheslav Markov on 06.07.2023.
//

import NYModels
import NYUtilities
import UIKit

public protocol CategoryCVCellDelegating: AnyObject {
    
}

public final class CategoryCVCell: UICollectionViewCell {
    public weak var delegate: CategoryCVCellDelegating?
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [name, date],
            axis: .vertical
        )
        v.alignment = .fill
        v.distribution = .equalSpacing
        v.spacing = 8
        v.backgroundColor = .black.withAlphaComponent(0.2)
        v.set(cornerRadius: 8)
        return v
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.textAlignment = .center
        return l
    }()
    
    private lazy var date: UILabel = {
        let l = UILabel()
        l.textAlignment = .right
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .gray
        return l
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }
    
    private func setup() {
        contentView.add([vStack])
        
        NSLayoutConstraint.activate([
            vStack.top.constraint(equalTo: contentView.top),
            vStack.leading.constraint(equalTo: contentView.leading, constant: 16),
            vStack.trailing.constraint(equalTo: contentView.trailing, constant: -16),
            vStack.bottom.constraint(equalTo: contentView.bottom, constant: -12),
        ])
    }
    
    public func configureUI(with model: CategoryModel) {
        name.text = model.name
        date.text = model.date
    }
}
