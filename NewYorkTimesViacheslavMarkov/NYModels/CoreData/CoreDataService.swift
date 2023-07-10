//
//  CoreDataService.swift
//  NYModels
//
//  Created by Viacheslav Markov on 10.07.2023.
//

import CoreData
import NYUtilities

public class CoreDataService {
    
    private init() {}
    private static let managedContext = CoreDataStack.shared.managedContext
    
    public static func retrieveDataFromDB() -> OverviewDBModel? {
        var model: OverviewDBModel?
        let request: NSFetchRequest<OverviewDBModel> = OverviewDBModel.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            model = data.first
        }
        return model
    }
    
    public static func retrieveOverviewDescriptionDBModel() -> [OverviewDescriptionDBModel]? {
        var models: [OverviewDescriptionDBModel]?
        let request: NSFetchRequest<OverviewDescriptionDBModel> = OverviewDescriptionDBModel.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    public static func retrieveBookDBModel() -> [BookDBModel]? {
        var models: [BookDBModel]?
        let request: NSFetchRequest<BookDBModel> = BookDBModel.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    public static func retrieveBuyLinksDBModel() -> [BuyLinksDBModel]? {
        var models: [BuyLinksDBModel]?
        let request: NSFetchRequest<BuyLinksDBModel> = BuyLinksDBModel.fetchRequest()
        if let data = try? CoreDataStack.shared.managedContext.fetch(request) {
            models = data
        }
        return models
    }
    
    public static func save(new model: OverviewData) {
        
        CoreDataStack.shared.clearAllBD()
        
        let modelDB: OverviewDBModel
        if let alreadyExistModelDB = retrieveDataFromDB() {
            modelDB = alreadyExistModelDB
        } else {
            modelDB = OverviewDBModel(context: managedContext)
        }
        
        modelDB.publishedDate = model.publishedDate
        
        let list = createListOverviewDescriptionDBModel(list: model.lists)
        var nsSet: Set<OverviewDescriptionDBModel> = []
        list.forEach({ item in
            nsSet.insert(item)
        })
        
        modelDB.addToList(nsSet as NSSet)
        
        CoreDataStack.shared.saveContext()
    }
    
    
    private static func createListOverviewDescriptionDBModel(list: [OverviewDescriptionData]) -> [OverviewDescriptionDBModel] {
        var listDB: [OverviewDescriptionDBModel]
        if let alreadyExistModelDB = retrieveOverviewDescriptionDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [OverviewDescriptionDBModel(context: managedContext)]
        }
        
        list.forEach { model in
            let item = OverviewDescriptionDBModel(context: managedContext)
            item.listId = Int16(model.listId)
            item.displayName = model.displayName
            
            let books = createListBookDBModel(books: model.books, with: String(model.listId))
            var nsSet: Set<BookDBModel> = []
            books.forEach({ item in
                nsSet.insert(item)
            })
            item.addToBooks(nsSet as NSSet)
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    private static func createListBookDBModel(books: [BookData], with parentId: String) -> [BookDBModel] {
        var listDB: [BookDBModel]
        if let alreadyExistModelDB = retrieveBookDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [BookDBModel(context: managedContext)]
        }
        
        books.forEach { book in
            let item = BookDBModel(context: managedContext)
            item.author = book.author
            item.descriptions = book.description
            item.imageUrlString = book.imageUrlString
            item.publisher = book.publisher
            
            let bookId = UUID().uuidString
            item.bookId = bookId

            let links = createListBuyLinksDBModel(links: book.buyLinks, with: bookId)
            var nsSet: Set<BuyLinksDBModel> = []
            links.forEach({ item in
                nsSet.insert(item)
            })
            
            item.addToLinks(nsSet as NSSet)
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    private static func createListBuyLinksDBModel(links: [BuyLinksData], with parentId: String) -> [BuyLinksDBModel] {
        var listDB: [BuyLinksDBModel]
        if let alreadyExistModelDB = retrieveBuyLinksDBModel() {
            listDB = alreadyExistModelDB
        } else {
            listDB = [BuyLinksDBModel(context: managedContext)]
        }
        
        links.forEach { link in
            let item = BuyLinksDBModel(context: managedContext)
            item.name = link.name
            item.url = link.url
            item.parentId = parentId
            
            let linkId = UUID().uuidString
            item.linkId = linkId
            
            listDB.append(item)
        }
        
        return listDB
    }
    
    public static func getModelsFromDB() -> OverviewData {
        let model = retrieveDataFromDB()
        
        guard
            let listsDB = model?.list?.allObjects as? [OverviewDescriptionDBModel]
        else {
            return OverviewData.init(publishedDate: "", lists: [])
        }
        let list = createOverviewDescriptionData(listDB: listsDB)
        
        let overview = OverviewData(
            publishedDate: model?.publishedDate ?? "",
            lists: list
        )
        
        return overview
    }
    
    private static func createOverviewDescriptionData(listDB: [OverviewDescriptionDBModel]) -> [OverviewDescriptionData] {
        var list = [OverviewDescriptionData]()
        listDB.forEach({ model in
            guard
                let booksDB = model.books!.allObjects as? [BookDBModel]
            else {
                return
            }
            let books = createBooksData(booksDB: booksDB)
            let item = OverviewDescriptionData(
                listId: Int(model.listId),
                displayName: model.displayName ?? "",
                books: books)
            list.append(item)
        })
        return list
    }
    
    private static func createBooksData(booksDB: [BookDBModel]) -> [BookData] {
        var list = [BookData]()
        booksDB.forEach({ model in
            guard
                let linksDB = model.links?.allObjects as? [BuyLinksDBModel]
            else {
                return
            }
            let links = createLinksData(linksDB: linksDB)
            let item = BookData(
                imageUrlString: model.imageUrlString ?? "",
                author: model.author ?? "",
                description: model.descriptions ?? "",
                rank: Int(model.rank),
                publisher: model.publisher ?? "",
                buyLinks: links
            )
            list.append(item)
        })
        return list
    }
    
    private static func createLinksData(linksDB: [BuyLinksDBModel]) -> [BuyLinksData] {
        var list = [BuyLinksData]()
        linksDB.forEach({ model in
            let item = BuyLinksData(
                name: model.name ?? "",
                url: model.url ?? ""
            )
            list.append(item)
        })
        return list
    }
}
