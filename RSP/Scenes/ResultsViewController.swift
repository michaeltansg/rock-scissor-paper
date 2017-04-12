//
//  ResultsViewController.swift
//  RSP
//
//  Created by Michael Tan on 11/4/17.
//  Copyright (c) 2017 exclusivebinary. All rights reserved.
//

import UIKit

protocol ResultsViewControllerInput {
    func displayResults(viewModel: Results.Match.ViewModel)
}

protocol ResultsViewControllerOutput {
    func getResults(request: Results.Match.Request)
}

class ResultsViewController: UIViewController, ResultsViewControllerInput {
    var output: ResultsViewControllerOutput!
    var router: ResultsRouter!
    
    var cellModels = [String]()
  
    // MARK: - Object lifecycle
  
    override func awakeFromNib() {
        super.awakeFromNib()
        ResultsConfigurator.sharedInstance.configure(viewController: self)
    }
  
    // MARK: - View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadMatches()
    }
  
    // MARK: - Event handling
  
    func loadMatches() {
        guard let filename = selectedGameFile() else {
            return
        }
        let request = Results.Match.Request(filename: filename)
        output.getResults(request: request)
    }
  
    // MARK: - Display logic
  
    func displayResults(viewModel: Results.Match.ViewModel) {
        let result = viewModel.result
        switch result {
        case .success(let results):
            cellModels = results
        case .failure(let error):
            cellModels = []
            switch error as! ResultsError {
            case .FailedLoadingGame(let reason):
                showErrorMessage(reason)
            case .ValidationError(let reason):
                showErrorMessage(reason)
            }
        }
        tableView.reloadData()
    }
    
    // MARK: - Actions

    @IBAction func segmentChanged(_ sender: Any) {
        loadMatches()
    }
    
    // MARK: - Private methods
    
    fileprivate func selectedGameFile() -> String? {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            return "game1"
        case 1:
            return "game2"
        case 2:
            return "game3"
        case 3:
            return "game4"
        case 4:
            return "game5"
        default:
            return nil
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
}

extension ResultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = cellModels[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "CellModel")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "CellModel")
        }
        cell!.textLabel?.text = cellModel
        return cell!
    }
}
