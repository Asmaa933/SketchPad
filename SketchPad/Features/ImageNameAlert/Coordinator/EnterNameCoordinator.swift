//
//  EnterNameCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

protocol EnterNameCoordinatorProtocol {
    func dismissAlert()
    func showSavedSuccessfully(message: TitleConstant)
}

class EnterNameCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

fileprivate extension EnterNameCoordinator {
    
    func setRootToDrawing() {
        let coordinator = DrawingCoordinator(navigationController: navigationController)
        let viewModel = DrawingViewModel(coordinator: coordinator)
        let drawingViewController = DrawingViewController(viewModel: viewModel)
        navigationController.viewControllers = [drawingViewController]
    }
}

extension EnterNameCoordinator: EnterNameCoordinatorProtocol {
    func dismissAlert() {
        navigationController.dismiss(animated: true)
    }
    
    func showSavedSuccessfully(message: TitleConstant) {
        let okAction = UIAlertAction(title: TitleConstant.ok.rawValue,
                                     style: .default) {[weak self] _ in
            guard let self = self else { return }
            self.dismissAlert()
            self.setRootToDrawing()
        }
        navigationController.showAlert(message: message.rawValue, actions: [okAction])
    }
}
