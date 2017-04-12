//
//  GameFileStore.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import Foundation

class GameFileStore {
    
    fileprivate let validator: InputValidator
    
    init(validator: InputValidator) {
        self.validator = validator
    }

    func loadMatches(from filename: String) throws -> [(player1: Hand, player2: Hand)]? {
        let bundle = Bundle(for: type(of: self))
        let resource = bundle.path(forResource: filename, ofType: ".txt")

        let data: Data
        do {
            data = try Data(contentsOf: URL(fileURLWithPath: resource!))
        } catch {
            throw ResultsError.FailedLoadingGame("Error: failed to load resource - \(filename)")
        }
        
        let content = String(data: data, encoding: .utf8)
        guard let _content = content else {
            throw ResultsError.FailedLoadingGame("Error: content error.")
        }
        
        let lines = _content.components(separatedBy: "\n").filter { $0.characters.count != 0 }
        try validator.validate(content: lines)
        return process(content: lines)
    }
    
    fileprivate func process(content: [String]) -> [(player1: Hand, player2: Hand)] {
        // Remove the first row
        let rawMatches = content.enumerated().filter { $0.offset != 0}.map { $0.element }
        var matches = [(player1: Hand, player2: Hand)]()
        for rawMatch in rawMatches {
            let regex = "^(Rock|Scissor|Paper) (Rock|Scissor|Paper)$"
            let captureGroups = rawMatch.capturedGroups(withRegex: regex)
            if let capture = captureGroups {
                matches.append((player1: Hand(rawValue: capture[0])!, player2: Hand(rawValue: capture[1])!))
            }
        }
        return matches
    }
}
