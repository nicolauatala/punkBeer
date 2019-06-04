//
//  BeerDetailViewController.swift
//  punkBeer
//
//  Created by Nicolau Atala on 13/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import UIKit

class BeerDetailViewController: UIViewController {

    static let STORYBOARD_ID = "BeerDetailViewController"

    var beer: Beer!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var dataController: DataController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = beer.name
        tagLineLabel.text = beer.tagline
        descriptionTextView.text = beer.beerDescription
    }

    class func instantiate(caller: UIViewController, beer: Beer) -> BeerDetailViewController {
        let contentViewController: BeerDetailViewController = caller.storyboard?.instantiateViewController(withIdentifier: STORYBOARD_ID) as! BeerDetailViewController
        contentViewController.beer = beer
        return contentViewController
    }
    
    @IBAction func favorite(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataController = appDelegate.dataController
        
        let beer = Beer(context: dataController.viewContext)
        beer.id = self.beer.id
        beer.name = self.beer.name
        beer.beerDescription = self.beer.beerDescription
        beer.tagline = self.beer.tagline
        try? dataController.viewContext.save()
    }
}
