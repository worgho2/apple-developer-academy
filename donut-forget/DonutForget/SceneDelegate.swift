//
//  SceneDelegate.swift
//  DonutForget
//
//  Created by João Conrado Santana de Lima Dembiski on 11/02/20.
//  Copyright © 2020 João Conrado Santana de Lima Dembiski. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo  : UISceneSession, options  : UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            // Create the SwiftUI view that provides the window contents.
            //            let contentView = ContentView( taskStore: TaskStore() )
            let contentView = InitialTabView()
            
            
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

