//
//  TestDriverViewController.swift
//  StateTableView
//
//  Created by Kevin Yu on 10/22/18.
//  Copyright © 2018 Kevin Yu. All rights reserved.
//

import UIKit
import StateUITableView

class TestDriverViewController: UIViewController, StateTableViewProtocol {

    @IBOutlet weak var stateTableView: StateTableView!
    
    let CELL_IDENTIFIER = "cell"
    let datums = ["duck", "dog", "goose"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set up delegates
        stateTableView.stateDelegate = self
        stateTableView.errorDelegate = self
        
        // set up some flags for handling default behavior
        stateTableView.useDefaultErrors = true
        
        // set current state, defaults empty
        // stateTableView.currentState = .empty
        
        stateTableView.register(UITableViewCell.self,
                                     forCellReuseIdentifier: CELL_IDENTIFIER)
    }
    
    // MARK: Test Driver Buttons
    // any webservices or long-running tasks should just
    // change the stateTableView's currentState at each important interval
    
    @IBAction func loadButtonAction(_ sender: Any) {
        stateTableView.currentState = .loading
    }
    @IBAction func errorButtonAction(_ sender: Any) {
        stateTableView.currentState = .error
    }
    @IBAction func emptyButtonAction(_ sender: Any) {
        stateTableView.currentState = .empty
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        stateTableView.currentState = .loaded
    }
}

extension TestDriverViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER,
                                                 for: indexPath)
        cell.textLabel?.text = datums[indexPath.row]
        return cell
    }
}

extension TestDriverViewController: StateTableViewErrorProtocol {
    func loadingMessage(forStateTableRect rect: CGRect) -> UIView! {
        let activityIndicator = UIActivityIndicatorView(frame: rect)
        activityIndicator.style = .whiteLarge
        activityIndicator.color = UIColor.red
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    func errorMessage(forStateTableRect rect: CGRect) -> UIView! {
        return defaultErrorMessage(text: "There was an error processing your request",
                                   rect: rect)
    }
    
    func emptyMessage(forStateTableRect rect: CGRect) -> UIView! {
        return defaultErrorMessage(text: "There is no data to show",
                                   rect: rect)
    }
    
    /// helper method for error message label generation
    func defaultErrorMessage(text: String, rect: CGRect) -> UIView {
        let errorLabel = UILabel(frame: rect)
        errorLabel.text = text
        errorLabel.textColor = .black
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.font = UIFont.systemFont(ofSize: 14.0)
        errorLabel.sizeToFit()
        return errorLabel
    }
}
