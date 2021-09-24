//
//  DetailViewController.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    var category: String?
    
    lazy var manager = NorrisManager(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstConfig()
        guard let catDetail = category else { return }
        manager.getCategory(catDetail)
        
    }
    
    fileprivate func firstConfig() {
        navigationItem.title = category
    }
}


extension DetailViewController: NorrisManagerDelegate {
    func handleSuccess(type: NorrisSuccessType) {
        switch type {
            case .successOnCategory(let category):
                loadDataOnScreen(using: category)
                break
            default:
                break
        }
    }
    
    func handleError(type: NorrisErrorType) {
        switch type {
            default:
                break
        }
    }
    
    func loadDataOnScreen(using category: Category) {
        DispatchQueue.main.async {
            
            self.descriptionLabel.text = category.description

            guard let imageUrl = URL(string: category.iconUrl!),
                  let imageData = try? Data(contentsOf: imageUrl) else {
                self.thumbImageView.image = UIImage()
                return
            }
            
            self.thumbImageView.image = UIImage(data: imageData)
            self.animateImageViewAndLoading()
        }
    }
    
    func animateImageViewAndLoading() {
        UIView.animate(withDuration: 0.7) {
            self.loading.alpha = 0
            self.thumbImageView.alpha = 1
        }
    }
}
