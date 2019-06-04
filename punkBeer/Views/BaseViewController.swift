//
//  BaseViewController.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    var dataRespository: DataRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Innitialize data repository, to be accessed by other UIViewControllers
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        dataRespository = appDelegate.dataRepository
    }
}
