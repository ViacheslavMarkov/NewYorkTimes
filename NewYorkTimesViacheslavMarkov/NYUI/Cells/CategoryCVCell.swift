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
    
    private let mainView: UIView = {
        let v = UIView()
        v.backgroundColor = .black.withAlphaComponent(0.2)
        v.set(cornerRadius: 8)
        return v
    }()
    
    private lazy var vStack: UIStackView = {
        let v = UIStackView(
            arrangedSubviews: [name, date],
            axis: .vertical
        )
        v.alignment = .fill
        v.distribution = .equalSpacing
        v.spacing = 8
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
        contentView.add([
            mainView
        ])
        
        mainView.add([
            vStack
        ])
        
        NSLayoutConstraint.activate([
            mainView.top.constraint(equalTo: contentView.top),
            mainView.leading.constraint(equalTo: contentView.leading, constant: 16),
            mainView.trailing.constraint(equalTo: contentView.trailing, constant: -16),
            mainView.bottom.constraint(equalTo: contentView.bottom, constant: -16),
            
            vStack.top.constraint(equalTo: mainView.top,constant: 4),
            vStack.leading.constraint(equalTo: mainView.leading, constant: 4),
            vStack.trailing.constraint(equalTo: mainView.trailing, constant: -4),
            vStack.bottom.constraint(equalTo: mainView.bottom, constant: -4),
        ])
    }
    
    public func configureUI(with model: CategoryModel) {
        name.text = model.name
        date.text = model.date
    }
}
