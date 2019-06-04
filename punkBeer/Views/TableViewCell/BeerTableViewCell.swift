//
//  BeerTableViewCell.swift
//  punkBeer
//
//  Created by Nicolau Atala on 28/04/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import UIKit

class BeerTableViewCell: UITableViewCell {

    static let BEER_VIEW_CELL = "BeerTableViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
