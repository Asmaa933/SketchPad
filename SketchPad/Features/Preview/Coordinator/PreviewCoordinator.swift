//
//  PreviewCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol PreviewCoordinatorProtocol {
    func closeView(canEdit: Bool)
    func presentEnterNameViewController(with sketchData: Sketch)
}

class PreviewCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension PreviewCoordinator: PreviewCoordinatorProtocol {
    
    func closeView(canEdit: Bool) {
        if canEdit {
            navigationController.popViewController(animated: true)
        } else {
            navigationController.dismiss(animated: true)
        }
    }
    
    func presentEnterNameViewController(with sketchData: Sketch) {
        let coordinator = EnterNameCoordinator(navigationController: navigationController)
        let viewModel = EnterNameViewModel(coordinator: coordinator, sketch: sketchData)
        let enterNameViewController = EnterNameViewController(viewModel: viewModel)
        enterNameViewController.modalPresentationStyle = .overCurrentContext
        navigationController.present(enterNameViewController, animated: true)
    }
}
