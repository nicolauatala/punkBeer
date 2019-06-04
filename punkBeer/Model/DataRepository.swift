//
//  BeerRepository.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation

class DataRepository: RepositoryProtocol {
    
    private let localRepository: LocalRepository
    private let remoteRepository: RemoteRepository
    
    init(local: LocalRepository, remote: RemoteRepository) {
        self.localRepository = local
        self.remoteRepository = remote
    }
    
    func  loadBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {
        self.remoteRepository.loadBeers(onError: { (error) in
            print(error)
        }) { (beers) in
            DispatchQueue.main.async { onBeersLoaded(beers) }
        }
    }
    
    func loadFavoritesBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {
        self.localRepository.loadFavoritesBeers(onError: { (error) in
            DispatchQueue.main.async { onError(error) }
        }) { (beers) in
            DispatchQueue.main.async { onBeersLoaded(beers) }
        }
    }
    
}
