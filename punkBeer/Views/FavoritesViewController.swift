//
//  FavoritesViewController.swift
//  punkBeer
//
//  Created by Nicolau Atala on 28/04/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import UIKit

class FavoritesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var beers: [Beer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: BeerTableViewCell.BEER_VIEW_CELL, bundle: nil), forCellReuseIdentifier: BeerTableViewCell.BEER_VIEW_CELL)
        
        dataRespository.loadFavoritesBeers(onError: { error in
            //            self.setViewState(.EMPTY)
            //            self.showError(error)
        }, onBeersLoaded: { beers in
            //            self.setViewState(.IDLE)
            self.beers = beers
            self.tableView.reloadData()
        })
    }
    
}


extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let beer = beers?[indexPath.row] {
            let contentViewContoller = BeerDetailViewController.instantiate(caller: self, beer: beer)
            self.navigationController?.pushViewController(contentViewContoller, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beers![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.BEER_VIEW_CELL, for: indexPath) as! BeerTableViewCell
        
        cell.nameLabel.text = beer.name
        cell.descriptionLabel.text = beer.beerDescription
        cell.taglineLabel.text = beer.tagline
        
        return cell
    }
}

