//
//  ResultsInteractor.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

protocol ResultsInteractorInput {
    func getResults(request: Results.Match.Request)
}

protocol ResultsInteractorOutput {
    func presentResults(response: Results.Match.Response)
}

class ResultsInteractor: ResultsInteractorInput {
    var output: ResultsInteractorOutput!
    var worker: ResultsWorker!
  
    // MARK: - Business logic
  
    func getResults(request: Results.Match.Request) {
        // NOTE: Create some Worker to do the work
    
        worker = ResultsWorker(store: GameFileStore(validator: InputValidator.sharedInstance))
        do {
            let matches = try worker.getMatches(from: request.filename)
            let matchWinners = resolveMatch(matches: matches)
            let gameWinner = resolveWinner(matchWinners: matchWinners)
            let game = Game(matchResults: matchWinners, gameResult: gameWinner)
            
            let response = Results.Match.Response(result: Result<Game>.success(game))
            output.presentResults(response: response)
        } catch {
            let response = Results.Match.Response(result: Result<Game>.failure(error))
            output.presentResults(response: response)
        }
    }

    func resolveMatch(matches: [(player1: Hand, player2: Hand)]) -> [MatchWinner] {
        return matches.map {
            switch($0) {
            case (Hand.Scissor, Hand.Paper),
                 (Hand.Paper, Hand.Rock),
                 (Hand.Rock, Hand.Scissor):
                return MatchWinner.Player1
            case (Hand.Paper, Hand.Scissor),
                 (Hand.Rock, Hand.Paper),
                 (Hand.Scissor, Hand.Rock):
                return MatchWinner.Player2
            default:
                return MatchWinner.Draw
            }
        }
    }
    
    func resolveWinner(matchWinners: [MatchWinner]) -> GameWinner {
        let winner = matchWinners.map {
            switch $0 {
            case .Draw: return 0
            case .Player1: return 1
            case .Player2: return -1
            }
            }.reduce(0, +)
        switch winner {
        case _ where winner > 0: return .Player1
        case _ where winner < 0: return .Player2
        // Alternative:
        //case 1...Int.max: return .Player1
        //case Int.min ..< 0: return .Player2
        default: return .Draw
        }
    }
}
