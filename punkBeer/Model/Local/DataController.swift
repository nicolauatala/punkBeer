//
//  DataController.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    
    let persistanceContainer: NSPersistentContainer
    var isLoaded: Bool!
    
    init(modelName: String = "punkBeer") {
        self.persistanceContainer = NSPersistentContainer(name: modelName)
        isLoaded = false
    }
    
    var viewContext: NSManagedObjectContext {
        return self.persistanceContainer.viewContext
    }
    
    func load(completion: (() -> Void)? = nil) {
        self.persistanceContainer.loadPersistentStores(completionHandler: {
            storeDescription, error in
            guard error == nil else {
                self.isLoaded = false
                print("Persistenace Store not Loaded!!!")
                fatalError(error!.localizedDescription)
            }
            
            print("Persistance Store loaded successfully")
            self.isLoaded = true
            completion?()
        })
    }
}
