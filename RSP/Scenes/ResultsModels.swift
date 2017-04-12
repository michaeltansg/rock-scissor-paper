//
//  ResultsModels.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

struct Results {
    struct Match {
        struct Request {
            let filename: String
        }
        struct Response {
            let result: Result<Game>
        }
        struct ViewModel {
            let result: Result<[String]>
        }
    }
}
