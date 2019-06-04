//
//  BeerProtocol.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    typealias ErrorCallback = ((Errors) -> Void)
    typealias BeersCallback = (([Beer]) -> Void)
    func loadBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback)
    func loadFavoritesBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback)
}

extension RepositoryProtocol {
    func loadFavoritesBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {}
}
