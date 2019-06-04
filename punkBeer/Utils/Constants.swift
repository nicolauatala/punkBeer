//
//  Constants.swift
//  punkBeer
//
//  Created by Nicolau Atala on 06/05/19.
//  Copyright © 2019 Nicolau Atala. All rights reserved.
//

import Foundation


class PunkAPI {
    static let BASE_URL = "https://api.punkapi.com/v2/beers"
}

enum Errors: Error {
    case NetworkError
    case ServerError
    case LocalDatabaseError
    case EmptyDatabaseError
    case UnknownError
}
