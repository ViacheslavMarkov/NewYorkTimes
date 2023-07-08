//
//  DictionaryView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 07.07.2023.
//

public final class DictionaryView: UIView {
    private lazy var keyLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.numberOfLines = 1
        l.minimumScaleFactor = 0.8
        l.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return l
    }()
    
    private lazy var valueLabel: UILabel = {
        let l = UILabel()
        l.textAlignment = .left
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
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
            keyLabel,
            valueLabel
        ])
        
        NSLayoutConstraint.activate([
            keyLabel.top.constraint(equalTo: top),
            keyLabel.leading.constraint(equalTo: leading),
            keyLabel.bottom.constraint(lessThanOrEqualTo: bottom),
            keyLabel.width.constraint(equalToConstant: 80),
            
            valueLabel.top.constraint(equalTo: keyLabel.top),
            valueLabel.leading.constraint(equalTo: keyLabel.trailing, constant: 4),
            valueLabel.trailing.constraint(equalTo: trailing, constant: -12),
            valueLabel.bottom.constraint(equalTo: bottom),
        ])
    }
    
    public func configureUI(key: String, value: String) {
        keyLabel.text = key
        valueLabel.text = ": \(value)"
    }
}
