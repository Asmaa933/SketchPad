//
//  PreviewCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol PreviewCoordinatorProtocol {
    func popViewController()
}

class PreviewCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension PreviewCoordinator: PreviewCoordinatorProtocol {
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
