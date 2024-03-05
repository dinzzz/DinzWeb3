//
//  WalletDetailsDatabaseService.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 02.03.2024..
//

import CoreData
import Foundation
import Combine

class WalletDetailsDatabaseService {
    static let shared = WalletDetailsDatabaseService()
    
    private var persistentContainer: NSPersistentContainer
    private let coreDataLocationContainerKey = "WalletDetails"
    
    private var fetchSubject = PassthroughSubject<Model.CacheModel, Never>()
    var fetchPublisher: AnyPublisher<Model.CacheModel, Never> {
        return fetchSubject.eraseToAnyPublisher()
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: coreDataLocationContainerKey)
        persistentContainer.loadPersistentStores { _,_ in }
    }
    
    func saveWalletDetails(model: Model.CacheModel) {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSOverwriteMergePolicy
        
        WalletDetails.from(model: model, context: context)
        
        do {
            try context.save()
        } catch {
            print("Error saving in database")
        }
    }
    
    func loadWalletDetails(address: String) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<WalletDetails>(entityName: "WalletDetails")
        fetch.predicate = NSPredicate(format: "address == %@", address)
        
        do {
            let walletDetails = try context.fetch(fetch)
            guard let details = walletDetails.first else { return }
            fetchSubject.send(details.toModel())
        } catch {
            print("Error fetching from database")
        }
    }
    
    func saveOrUpdateWalletDetails(model: Model.CacheModel) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<WalletDetails>(entityName: "WalletDetails")
        fetch.predicate = NSPredicate(format: "address == %@", model.address)
        
        do {
            let walletDetails = try context.fetch(fetch)
            guard let details = walletDetails.first else { 
                WalletDetails.from(model: model, context: context)
                try context.save()
                return
            }
            
            details.address = model.address
            details.nftsCount = Int32(model.nftsCount)
            details.transactionsCount = Int32(model.transactionsCount)
            details.accountBalance = model.accountBalance
            details.createdAt = model.createdAt
            details.updatedAt = Date()
            details.nfts = Set(model.nfts.map { DBNFTModel.from(model: $0, context: context) })
            try context.save()
        } catch {
            print("Error fetching from database")
        }
    }
}

extension WalletDetailsDatabaseService {
    func test() {
        saveWalletDetails(model: .init(address: "Address2",
                                       nftsCount: 2,
                                       transactionsCount: 2,
                                       accountBalance: "Balance",
                                       createdAt: Date(),
                                       updatedAt: Date(),
                                       nfts: [.init(contract: .init(address: "Address2")),
                                                .init(contract: .init(address: "Address23"))]))
    }
    
    func checkDatabase() {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<WalletDetails>(entityName: "WalletDetails")

        do {
            let walletDetails = try context.fetch(fetch)
            
            for object in walletDetails {
                print("\(object)")
            }
            try context.save()
        } catch {
            print("Error fetching")
        }
    }
}
