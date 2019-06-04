//
//  SearchViewController.swift
//  punkBeer
//
//  Created by Nicolau Atala on 28/04/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var beers: [Beer]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        self.setViewState(.EMPTY)
        
        tableView.register(UINib(nibName: BeerTableViewCell.BEER_VIEW_CELL, bundle: nil), forCellReuseIdentifier: BeerTableViewCell.BEER_VIEW_CELL)
        
        setViewState(.LOADING)
        dataRespository.loadBeers(onError: { error in
            self.setViewState(.EMPTY)
            self.showError(error)
        }, onBeersLoaded: { beers in
            self.setViewState(.IDLE)
            self.beers = beers
            self.tableView.reloadData()
            if (beers.count == 0){
                self.showError(Errors.ServerError)
            }
        })
    }
    
    enum ViewState {
        case LOADING
        case EMPTY
        case IDLE
    }
    
    func setViewState(_ viewState: ViewState) {
        switch viewState {
        case .LOADING:
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            break
        case .EMPTY:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        case .IDLE:
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
            break
        }
    }
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let beer = beers?[indexPath.row] {
            let contentViewContoller = BeerDetailViewController.instantiate(caller: self, beer: beer)
            self.navigationController?.pushViewController(contentViewContoller, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController: UITableViewDataSource {
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
