//
//  HistoryCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol HistoryCoordinatorProtocol {
    func showError(message: AppError)
    func previewSketch(with imageData: Data)
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
    
    func previewSketch(with imageData: Data) {
        let coordinator = PreviewCoordinator(navigationController: navigationController)
        let viewModel = PreviewViewModel(coordinator: coordinator, canEdit: false, imageData: imageData)
        let previewViewController = PreviewViewController(viewModel: viewModel)
        navigationController.present(previewViewController, animated: true)
    }
}
