//
//  TableView.swift
//  NYUI
//
//  Created by Viacheslav Markov on 04.07.2023.
//

public final class TableView: UITableView {
    public init(_ style: UITableView.Style = .plain) {
        super.init(frame: .zero, style: style)
        setup()
    }

    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }

    private func setup() {
        backgroundColor = .white
        showsHorizontalScrollIndicator = false
        showsVerticalScrollIndicator = false
        delaysContentTouches = false
    }
}
