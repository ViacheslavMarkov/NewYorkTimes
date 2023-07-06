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
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.image = UIImage(systemName: "square.and.arrow.up.circle")
        return i
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
        contentView.add([imageView])
        
        NSLayoutConstraint.activate([
            imageView.top.constraint(equalTo: contentView.top),
            imageView.leading.constraint(equalTo: contentView.leading),
            imageView.trailing.constraint(equalTo: contentView.trailing),
            imageView.bottom.constraint(equalTo: contentView.bottom),
        ])
    }
}
