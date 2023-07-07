//
//  UIStackView+Extension.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis = .horizontal) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
    }

    func add(arrangedSubviews: [UIView]) {
        arrangedSubviews.forEach {
            addArrangedSubview($0)
        }
    }

    func removeArrangedSubviews() {
        arrangedSubviews.forEach {
            removeArrangedSubview($0)
        }
    }
}
