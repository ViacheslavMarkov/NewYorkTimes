//
//  BookCVCell.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import NYModels
import NYUtilities
import UIKit

public protocol BookCVCellDelegating: AnyObject {
    
}

public final class BookCVCell: UICollectionViewCell {
    public weak var delegate: BookCVCellDelegating?
    
    private let mainView = BookDetailView()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setup() {
        contentView.add([
            mainView
        ])

        mainView.autoPinEdgesToSuperView()
    }
    
    public func configureUI(with model: BookData) {
        mainView.configureUI(with: model)
    }
}
