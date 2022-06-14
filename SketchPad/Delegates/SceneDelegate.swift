//
//  SceneDelegate.swift
//  SketchPad
//
//  Created by Asmaa Tarek on 09/06/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let appCoordinator: AppCoordinatorProtocol = AppCoordinator(window: window)
        appCoordinator.start()
    }
}

