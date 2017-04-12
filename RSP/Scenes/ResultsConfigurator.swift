//
//  ResultsConfigurator.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

// MARK: - Connect View, Interactor, and Presenter

extension ResultsViewController: ResultsPresenterOutput {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        router.passDataToNextScene(segue: segue)
    }
}

extension ResultsInteractor: ResultsViewControllerOutput {}

extension ResultsPresenter: ResultsInteractorOutput {}

class ResultsConfigurator {

    // MARK: - Object lifecycle
  
    static let sharedInstance = ResultsConfigurator()
  
    private init() {}
  
    // MARK: - Configuration
  
    func configure(viewController: ResultsViewController) {
        let router = ResultsRouter()
        router.viewController = viewController
    
        let presenter = ResultsPresenter()
        presenter.output = viewController
    
        let interactor = ResultsInteractor()
        interactor.output = presenter
    
        viewController.output = interactor
        viewController.router = router
    }
}
