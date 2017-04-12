//
//  ResultsError.swift
//  RSP
//
//  Created by Michael Tan on 12/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import Foundation

enum ResultsError: Error {
    case FailedLoadingGame(String)
    case ValidationError(String)
}
