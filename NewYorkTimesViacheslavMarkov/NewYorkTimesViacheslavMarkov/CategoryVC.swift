//
//  CategoryVC.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 02.07.2023.
//

import UIKit
import NYUI
import NYViewModels

final class CategoryVC: ViewLoadableVC<CategoryView> {
    private let viewModel: CategoryVM
    
    public init(viewModel: CategoryVM) {
        self.viewModel = viewModel
        super.init()
        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError(.noStoryboards)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCustomView()
        customView.collectionView.dataSource = viewModel.makeDataSource()
        customView.collectionView.delegate = viewModel
        customView.collectionView.collectionViewLayout = viewModel.makeLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchBooks()
    }
}

//MARK: - CategoryVM
extension CategoryVC: CategoryVMDelegating {
    public func collectionView() -> CollectionView? {
        customView.collectionView
    }
}
