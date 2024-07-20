//
//  AppRouter.swift
//  HomeTest
//
//  Created by Qamar Al Amassi on 20/07/2024.
//

import UIKit
import SwiftUI
//Module For handling Main Application Routing
class AppRouter: NSObject {
    
    static let shared = AppRouter()
    var window : UIWindow!
    
    //Singletone pattern
    private override init() {
    }
    
    func startApp(using window: UIWindow) {
        self.window = window
        
        let contentView = MainScreen()

        let viewController: UIViewController = UIHostingController(rootView: contentView)
      
        window.rootViewController = viewController
        
        window.makeKeyAndVisible()
    }
    
   
}
