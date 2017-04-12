//
//  Game.swift
//  RSP
//
//  Created by Michael Tan on 12/4/17.
//  Copyright © 2017 exclusivebinary. All rights reserved.
//

import Foundation

enum MatchWinner: String {
    case Draw = "Draw"
    case Player1 = "Player 1 wins"
    case Player2 = "Player 2 wins"
}

enum GameWinner: String {
    case Draw = "Game draw. No winner"
    case Player1 = "Winner: Player 1"
    case Player2 = "Winner: Player 2"
}

struct Game {
    let matchResults: [MatchWinner]
    let gameResult: GameWinner
}
