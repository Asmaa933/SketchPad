//
//  TabBarCoordinator.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 10/06/2022.
//

import UIKit


protocol TabBarCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get }

}

class TabBarCoordinator {
   
    private(set) var tabBarController: UITabBarController
    
    init() {
        tabBarController = UITabBarController()
    }
}

fileprivate extension TabBarCoordinator {
    func getTabBarTab(_ tab: Tab) -> UINavigationController {
        let navigationController = UINavigationController()
        let rootViewController = viewController(for: tab,with: navigationController)
        navigationController.viewControllers = [rootViewController]
        navigationController.isNavigationBarHidden = true
        navigationController.tabBarItem.title = tab.tabTitle
        navigationController.tabBarItem.image = UIImage.getImage(from: tab.imageName).withRenderingMode(.alwaysTemplate)
        return navigationController
     }
     
    func viewController(for tab: Tab, with navigationController: UINavigationController) -> UIViewController {
         var viewController = UIViewController()
        switch tab {
        case .drawing:
            let coordinator = DrawingCoordinator(navigationController: navigationController)
            let viewModel = DrawingViewModel(coordinator: coordinator)
            viewController = DrawingViewController(viewModel: viewModel)
        case .history:
            let coordinator = HistoryCoordinator(navigationController: navigationController)
            let viewModel = HistoryViewModel(coordinator: coordinator, dataProvider: HistoryDataProvider())
            viewController = HistoryViewController(viewModel: viewModel)
        }
        return viewController
     }
    
    func prepareTabBarController(with tabControllers: [UIViewController]) {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]
        UITabBarItem.appearance().setTitleTextAttributes(attributes, for: .normal)
        UITabBar.appearance().tintColor = .color(for: .tintColor)
        tabBarController.setViewControllers(tabControllers, animated: true)
        tabBarController.tabBar.backgroundColor = UIColor.color(for: .tabBarBackgroundColor)
        
    }
}

extension TabBarCoordinator: TabBarCoordinatorProtocol {
     
    func start() {
        let tabs = Tab.allCases
        let controllers = tabs.map(getTabBarTab(_:))
        prepareTabBarController(with: controllers)
    }
    
}
