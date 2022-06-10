//
//  HistoryCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol HistoryCoordinatorProtocol {
    
}

class HistoryCoordinator {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
}

extension HistoryCoordinator: HistoryCoordinatorProtocol {
    
}
