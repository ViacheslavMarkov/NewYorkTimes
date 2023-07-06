//
//  CategoryViewController.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 02.07.2023.
//

import UIKit
import NYUI

final class CategoryViewController: ViewLoadableVC<CategoryView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addCustomView()
//        view.backgroundColor = .red
    }
}
