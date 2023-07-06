//
//  ViewLoadableVC.swift
//  NYUI
//
//  Created by Viacheslav Markov on 04.07.2023.
//

import NYUtilities

open class ViewLoadableVC<CustomView: UIView>: UIViewController, ViewLoadable {
    public typealias ViewType = CustomView

    public init() {
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder: NSCoder) {
        assertionFailure(.noStoryboards)
        return nil
    }
}
