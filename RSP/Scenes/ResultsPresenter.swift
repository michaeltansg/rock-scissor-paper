//
//  ResultsPresenter.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

protocol ResultsPresenterInput {
    func presentResults(response: Results.Match.Response)
}

protocol ResultsPresenterOutput: class {
    func displayResults(viewModel: Results.Match.ViewModel)
}

class ResultsPresenter: ResultsPresenterInput {
    weak var output: ResultsPresenterOutput!
  
    // MARK: - Presentation logic
  
    func presentResults(response: Results.Match.Response) {
        switch response.result {
        case .success(let game):
            var results = [String]()
            results += game.matchResults.map { $0.rawValue }
            results.append(game.gameResult.rawValue)
            let viewModel = Results.Match.ViewModel(result: Result<[String]>.success(results))
            output.displayResults(viewModel: viewModel)
        case .failure(let error):
            let viewModel = Results.Match.ViewModel(result: Result<[String]>.failure(error))
            output.displayResults(viewModel: viewModel)
        }
    }
}
