//
//  BooksVC.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 07.07.2023.
//

import UIKit
import NYUI
import NYViewModels
import NYModels

final class BooksVC: ViewLoadableVC<BooksView> {
    private let viewModel: BooksVM
    
    public init(viewModel: BooksVM) {
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
        viewModel.updateDynamicBooksDataSource()
    }
}

//MARK: - BooksVC
private extension BooksVC {
    func showSafari(link: String) {
        let url = URL(string: link)
        presentSafariVC(url: url)
    }
}

//MARK: - BooksVC
extension BooksVC: BooksVMDelegating {
    func didTapLink(_ sender: NYViewModels.BooksVM, link: String) {
        showSafari(link: link)
    }
    
    public func collectionView() -> CollectionView? {
        customView.collectionView
    }
}
