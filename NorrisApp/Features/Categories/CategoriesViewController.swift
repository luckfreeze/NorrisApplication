//
//  ViewController.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    lazy var manager = NorrisManager(delegate: self)
    
    var categories: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstConfig()
    
        manager.getCategories()
    }
    
    fileprivate func firstConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
        navigationItem.backButtonTitle = ""
    }
    
    @IBAction func handleErrorTouchUpInside(_ sender: UIButton) {
        manager.getCategories()
        
        UIView.animate(withDuration: 0.7) {
            self.tableView.alpha = 0
            self.errorView.alpha = 0
            self.loadingView.alpha = 1
        }
    }
}
