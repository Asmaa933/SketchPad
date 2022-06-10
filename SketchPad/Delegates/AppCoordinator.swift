//
//  AppCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    
}

class AppCoordinator {
   
    private var window: UIWindow?
    private var rootViewController: TabBarCoordinatorProtocol
    
    init(window: UIWindow?) {
        self.window = window
        self.rootViewController = TabBarCoordinator()
    }
}

extension AppCoordinator: AppCoordinatorProtocol {
    
    func start() {
        window?.rootViewController = rootViewController.tabBarController
        rootViewController.start()
        window?.makeKeyAndVisible()
    }
}
