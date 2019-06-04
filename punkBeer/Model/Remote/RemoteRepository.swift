//
//  RemoteRepository.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation

class RemoteRepository: RepositoryProtocol {
    
    var dataController: DataController
    
    init(dataController: DataController) {
        self.dataController = dataController
    }
    
    func loadBeers(onError: @escaping ErrorCallback, onBeersLoaded: @escaping BeersCallback) {
        let request = URLRequest(url: URL(string: PunkAPI.BASE_URL)!)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            if error != nil {
                self.handleError(error, onError: onError)
                return
            }
            
            do {
                let jsonDic = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)

                var beers = [Beer]()
                if let jsonDic = jsonDic as? [NSDictionary]{
                    for jsonBeerItem in jsonDic {
                        let beer = Beer(context: self.dataController.viewContext)
                        beer.setFrom(jsonBeerItem)
                        beers.append(beer)
                    }
                }
                onBeersLoaded(beers)
            } catch {
                self.handleError(error, onError: onError)
            }
        })
        task.resume()
    }
    
    private func handleError(_ error: Error!, onError: @escaping ErrorCallback) {
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet:
                onError(Errors.NetworkError)
                return
            default:
                onError(Errors.ServerError)
                return
            }
        }
        onError(Errors.ServerError)
    }
}
