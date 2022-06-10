//
//  UINavigationControllerExtension.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

extension UINavigationController {
    func showAlert(error: AppError, actions: [UIAlertAction]) {
        let message = error.rawValue
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        present(alert, animated: true)
    }
}
