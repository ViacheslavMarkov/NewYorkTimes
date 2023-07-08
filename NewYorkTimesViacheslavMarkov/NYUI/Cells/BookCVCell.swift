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
    func didTapLink(_ sender: BookCVCell, link: String)
}

public final class BookCVCell: UICollectionViewCell {
    public weak var delegate: BookCVCellDelegating?
    
    public let mainView = BookDetailView()
    
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
        
        mainView.delegate = self
    }
    
    public func configureUI(with model: BookData) {
        mainView.configureUI(with: model)
    }
}

//MARK: - BookDetailViewDelegating
extension BookCVCell: BookDetailViewDelegating {
    public func didTapLink(_ sender: BookDetailView, link: String) {
        delegate?.didTapLink(self, link: link)
    }
}
