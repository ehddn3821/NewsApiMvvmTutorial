//
//  SceneDelegate.swift
//  NewsApiMvvmTutorial
//
//  Created by dwKang on 2022/03/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let rootVC = ViewController()
        let navRootVC = UINavigationController(rootViewController: rootVC)
        window?.rootViewController = navRootVC
        window?.makeKeyAndVisible()
    }
}

