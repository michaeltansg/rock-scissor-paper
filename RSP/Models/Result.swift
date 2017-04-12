//
//  Result.swift
//  RSP
//
//  Created by Michael Tan on 12/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
