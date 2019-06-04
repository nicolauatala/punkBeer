//
//  AppDelegate.swift
//  punkBeer
//
//  Created by Nicolau Atala on 27/04/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var dataController: DataController!
    var dataRepository: DataRepository!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        dataController = DataController()
        dataController.load()
        let localRepository = LocalRepository(dataController: dataController)
        let remoteRepository = RemoteRepository(dataController: dataController)
        
        dataRepository = DataRepository(local: localRepository, remote: remoteRepository)
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "punkBeer")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

