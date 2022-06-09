//
//  TabBarCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit


protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }

}

class TabBarCoordinator {
   
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        tabBarController = UITabBarController()
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
     
    func start() {
    }
    
}
