//
//  InputValidator.swift
//  RSP
//
//  Created by Michael Tan on 12/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import Foundation

class InputValidator {
    
    static let sharedInstance = InputValidator()
    
    private init() {}

    func validate(content: [String]) throws -> Void {
        if content.count < 2 {
            throw ResultsError.ValidationError("Invalid input: File content invalid")
        }

        guard let match = content[0].matches(withRegex: "^[0-9]+$"), match.count != 0 else {
            throw ResultsError.ValidationError("Invalid input: Missing number of matches!")
        }

        let numberOfMatches = Int(match[0])
        if (content.count - 1) != numberOfMatches {
            throw ResultsError.ValidationError("Invalid input: Matches do not tally!")
        }
        
        for row in 1..<content.count {
            if content[row].capturedGroups(withRegex: "^(Rock|Scissor|Paper) (Rock|Scissor|Paper)$") == nil {
                throw ResultsError.ValidationError("Invalid format: \(content[row])")
            }
        }
    }
}
