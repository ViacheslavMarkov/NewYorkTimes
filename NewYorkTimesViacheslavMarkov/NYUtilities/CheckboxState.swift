//
//  ExpandState.swift
//  NYUtilities
//
//  Created by Viacheslav Markov on 08.07.2023.
//

import UIKit

public enum ExpandState {
    case up
    case down
    
    var image: UIImage? {
        return self == .up
        ? UIImage(systemName: "dock.arrow.down.rectangle")
        : UIImage(systemName: "dock.arrow.up.rectangle")
    }
    
    mutating func toggle() {
        if self == .up {
            self = ExpandState.down
        } else {
            self = ExpandState.up
        }
    }
}
