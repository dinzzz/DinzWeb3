//
//  IncomingTransactionsDatabaseService.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 05.03.2024..
//

import CoreData
import Foundation
import Combine

class IncomingTransactionsDatabaseService {
    static let shared = IncomingTransactionsDatabaseService()
    
    private var persistentContainer: NSPersistentContainer
    private let coreDataLocationContainerKey = "IncomingTransactions"
    
    private var fetchSubject = PassthroughSubject<Model.IncomingTransactionsCacheModel, Never>()
    var fetchPublisher: AnyPublisher<Model.IncomingTransactionsCacheModel, Never> {
        return fetchSubject.eraseToAnyPublisher()
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: coreDataLocationContainerKey)
        persistentContainer.loadPersistentStores { _,_ in }
    }

    func saveIncomingTransactions(model: Model.IncomingTransactionsCacheModel) {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSOverwriteMergePolicy
        
        IncomingTransactions.from(model: model, context: context)
        
        do {
            try context.save()
        } catch {
            print("Error saving in database")
        }
    }
    
    func loadIncomingTransactions(address: String) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<IncomingTransactions>(entityName: "IncomingTransactions")
        fetch.predicate = NSPredicate(format: "address == %@", address)
        
        do {
            let incomingTransactions = try context.fetch(fetch)
            guard let details = incomingTransactions.first else { return }
            fetchSubject.send(details.toModel())
        } catch {
            print("Error fetching from database")
        }
    }
    
    func saveOrUpdateWalletDetails(model: Model.IncomingTransactionsCacheModel) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<IncomingTransactions>(entityName: "IncomingTransactions")
        fetch.predicate = NSPredicate(format: "address == %@", model.address)
        
        do {
            let incomingTransactions = try context.fetch(fetch)
            guard let incomingTransactions = incomingTransactions.first else {
                IncomingTransactions.from(model: model, context: context)
                try context.save()
                return
            }
            
            incomingTransactions.address = model.address
            incomingTransactions.transfers = Set(model.transactions.map { DBAssetTransferModel.from(model: $0, context: context) })
            
            try context.save()
        } catch {
            print("Error fetching from database")
        }
    }
}
