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
   
    var tabBarController: UITabBarController
    
    init() {
        tabBarController = UITabBarController()
    }
}

fileprivate extension TabBarCoordinator {
    func getTabBarTab(_ tab: Tab) -> UINavigationController {
        let rootViewController = viewController(for: tab)
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem.title = tab.tabTitle
        navigationController.tabBarItem.image = UIImage.getImage(from: tab.imageName).withRenderingMode(.alwaysTemplate)
        return navigationController
     }
     
    func viewController(for tab: Tab) -> UIViewController {
         var viewController = UIViewController()
        switch tab {
        case .drawing:
            viewController = DrawingViewController()
        case .history:
            viewController = HistoryViewController()
        }
        return viewController
     }
    
    func prepareTabBarController(with tabControllers: [UIViewController]) {
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.tabBar.backgroundColor = UIColor.color(for: .tabbarBackgroundColor)
        UITabBar.appearance().tintColor = .color(for: .tintColor)
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
     
    func start() {
        let tabs = Tab.allCases
        let controllers = tabs.map(getTabBarTab(_:))
        prepareTabBarController(with: controllers)
    }
    
}
