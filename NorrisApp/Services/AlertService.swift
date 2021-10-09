//
//  AlertService.swift
//  NorrisApp
//
//  Created by Lucas Vinicius S. Corrêa de Moraes on 09/10/21.
//

import UIKit

class AlertService {
    static func `default`(in viewController: UIViewController, with title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        viewController.present(alert, animated: true, completion: completion)
    }
}
