//
//  HistoryCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol HistoryCoordinatorProtocol {
    func showError(message: AppError, actions: [UIAlertAction])
    func previewSketch(with sketch: Sketch)
    func goToDrawing()
}

class HistoryCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension HistoryCoordinator: HistoryCoordinatorProtocol {
    
    func showError(message: AppError, actions: [UIAlertAction]) {
        navigationController.showAlert(message: message.rawValue,
                                       actions: actions)
    }
    
    func previewSketch(with sketch: Sketch) {
        let coordinator = PreviewCoordinator(navigationController: navigationController)
        let viewModel = PreviewViewModel(coordinator: coordinator,
                                         canEdit: false,
                                         sketch: sketch)
        let previewViewController = PreviewViewController(viewModel: viewModel)
        navigationController.present(previewViewController,
                                     animated: true)
    }
    
    func goToDrawing() {
        guard let tabBarController = navigationController.tabBarController else { return }
        tabBarController.selectedIndex = 0
    }
}
