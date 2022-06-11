//
//  EnterNameCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 11/06/2022.
//

import UIKit

protocol EnterNameCoordinatorProtocol {
    
}

class EnterNameCoordinator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension EnterNameCoordinator: EnterNameCoordinatorProtocol {

}
