//
//  UINavigationControllerExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

extension UINavigationController {
    func showAlert(message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
