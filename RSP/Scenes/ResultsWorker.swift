//
//  ResultsWorker.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

class ResultsWorker {
    
    let store: GameFileStore
    
    init(store: GameFileStore) {
        self.store = store
    }
    
    // MARK: - Business Logic
    
    func getMatches(from filename: String) throws -> [(player1: Hand, player2: Hand)] {
        return try store.loadMatches(from: filename)!
    }
}
