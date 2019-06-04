//
//  PunkBeer.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation

extension Beer {
    
    func setFrom(_ jsonBeer: Any){
        let beer = jsonBeer as! NSDictionary
        self.id = beer["id"] as? String
        self.name = beer["name"] as? String
        self.beerDescription = beer["description"] as? String
        self.tagline = beer["tagline"] as? String
    }
}
