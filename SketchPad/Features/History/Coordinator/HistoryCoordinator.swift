//
//  HistoryCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol HistoryCoordinatorProtocol {
    func showError(message: AppError)
}

class HistoryCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension HistoryCoordinator: HistoryCoordinatorProtocol {
    func showError(message: AppError) {
        let okAction = UIAlertAction(title: TitleConstant.ok.rawValue, style: .default)
        navigationController.showAlert(message: message.rawValue, actions: [okAction])
    }
}
