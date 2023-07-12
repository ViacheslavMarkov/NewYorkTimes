//
//  CategoryVC.swift
//  NewYorkTimesViacheslavMarkov
//
//  Created by Viacheslav Markov on 02.07.2023.
//

import UIKit
import NYUI
import NYViewModels
import NYModels
import NYNetworking

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
        viewModel.fetchBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

//MARK: - CategoryVMDelegating
extension CategoryVC: CategoryVMDelegating {
    func cellTapped(_ sender: NYViewModels.CategoryVM, books: [BookData]) {
        print("cellTapped")
        showBooksVC(with: books)
    }
    
    public func collectionView() -> CollectionView? {
        customView.collectionView
    }
}

//MARK: - CategoryVC
private extension CategoryVC {
    func showBooksVC(with books: [BookData]) {
        let vm = BooksVM(books: books)
        let vc = BooksVC(viewModel: vm)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupNotification() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(statusManager),
                         name: .flagsChanged,
                         object: nil)
    }
    
    @objc
    func statusManager(_ notification: Notification) {
        viewModel.fetchBooks()
    }
}
