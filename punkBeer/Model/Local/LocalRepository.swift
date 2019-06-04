//
//  LocalRepository.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation
import CoreData

class LocalRepository: RepositoryProtocol {
    
    var dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func loadBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {}
    
    func loadFavoritesBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {
        if !dataController.isLoaded {
            onError(Errors.LocalDatabaseError)
            return
        }
        
        let fetchRequest: NSFetchRequest<Beer> = Beer.fetchRequest()
        do {
            let results = try dataController.viewContext.fetch(fetchRequest)
            print("Loaded beers from local db with count \(results.count)")
            if results.count <= 0 {
                throw Errors.EmptyDatabaseError
            }
            onBeersLoaded(results)
        } catch {
            print("Fetch Error")
            onError(Errors.LocalDatabaseError)
        }
    }
}
