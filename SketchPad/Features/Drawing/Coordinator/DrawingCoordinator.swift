//
//  DrawingCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol DrawingCoordinatorProtocol {
    func showImagePicker()
    var imageDidPicked: ((Data) -> Void)? { get set }
}

class DrawingCoordinator: NSObject {
    
    private var navigationController: UINavigationController
    var imageDidPicked: ((Data) -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}

extension DrawingCoordinator: DrawingCoordinatorProtocol {
    
    func showImagePicker() {
    }
   
}

}
