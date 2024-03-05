//
//  OwnedNFTsDatabaseService.swift
//  DinzWeb3
//
//  Created by Dino Bozic on 05.03.2024..
//

import CoreData
import Foundation
import Combine

class OwnedNFTsDatabaseService {
    static let shared = OwnedNFTsDatabaseService()
    
    private var persistentContainer: NSPersistentContainer
    private let coreDataLocationContainerKey = "OwnedNFTs"
    
    private var fetchSubject = PassthroughSubject<Model.OwnerNftsCacheModel, Never>()
    var fetchPublisher: AnyPublisher<Model.OwnerNftsCacheModel, Never> {
        return fetchSubject.eraseToAnyPublisher()
    }
    
    init() {
        persistentContainer = NSPersistentContainer(name: coreDataLocationContainerKey)
        persistentContainer.loadPersistentStores { _,_ in }
    }
    
    func saveOwnedNfts(model: Model.OwnerNftsCacheModel) {
        let context = persistentContainer.newBackgroundContext()
        context.mergePolicy = NSOverwriteMergePolicy
        
        OwnedNFTs.from(model: model, context: context)
        
        do {
            try context.save()
        } catch {
            print("Error saving in database")
        }
    }
    
    func loadOwnedNfts(address: String) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<OwnedNFTs>(entityName: "OwnedNFTs")
        fetch.predicate = NSPredicate(format: "address == %@", address)
        
        do {
            let ownedNfts = try context.fetch(fetch)
            guard let details = ownedNfts.first else { return }
            fetchSubject.send(details.toModel())
        } catch {
            print("Error fetching from database")
        }
    }
    
    func saveOrUpdateWalletDetails(model: Model.OwnerNftsCacheModel) {
        let context = persistentContainer.newBackgroundContext()
        let fetch = NSFetchRequest<OwnedNFTs>(entityName: "OwnedNFTs")
        fetch.predicate = NSPredicate(format: "address == %@", model.address)
        
        do {
            let ownedNFTs = try context.fetch(fetch)
            guard let ownedNFTs = ownedNFTs.first else {
                OwnedNFTs.from(model: model, context: context)
                try context.save()
                return
            }
            
            ownedNFTs.address = model.address
            ownedNFTs.nfts = Set(model.nfts.map { DBNFTModel.from(model: $0, context: context) })
            
            try context.save()
        } catch {
            print("Error fetching from database")
        }
    }
}
