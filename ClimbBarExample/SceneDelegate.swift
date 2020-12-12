//
//  SeceneDelegate.swift
//  ClimbBarExample
//
//  Created by keisuke yamagishi on 2020/12/12.
//  Copyright © 2020 Shichimitoucarashi. All rights reserved.
//
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let storyboard = UIStoryboard(name: "Root", bundle: nil)
        guard let rootViewcontroller = storyboard.instantiateInitialViewController() else { return }
        let navigationController = UINavigationController(rootViewController: rootViewcontroller)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

