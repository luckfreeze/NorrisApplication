//
//  ViewControllerExtensions.swift
//  NorrisApp
//
//  Created by Lucas Moraes on 08/02/21.
//

import UIKit

extension CategoriesViewController: NorrisManagerDelegate {
    func handleSuccess(type: NorrisSuccessType) {
        switch type {
            case .successOnCategories(let categories):
                reloadTableView(with: categories)
                break
            default:
                break
        }
    }
    
    func handleError(type: NorrisErrorType) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7) {
                
                self.tableView.alpha = 0
                
                self.loadingView.alpha = 0
                
                self.errorView.alpha = 1
            }
        }
    }
    
    func reloadTableView(with cat: [String]?) {
        DispatchQueue.main.async {
            self.categories = cat
            self.tableView.reloadData()
            self.animateOn()
        }
    }
    
    func animateOn() {
        UIView.animate(withDuration: 0.7) {
            self.tableView.alpha = 1
            self.errorView.alpha = 0
            self.loadingView.alpha = 0
        }
    }
}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToCategory(detail: categories?[indexPath.row])
    }
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "norrisCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

extension CategoriesViewController {
    func goToCategory(detail: String?) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
             guard let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
        
        detailVC.category = detail
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}






class AstonMartim {
    
    // atributo = característica
    let cor = UIColor.gray
    
    
    
    
}
