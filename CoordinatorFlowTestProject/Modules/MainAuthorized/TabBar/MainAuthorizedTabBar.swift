//
//  MainAuthorizedTabBar.swift
//  CoordinatorFlowTestProject
//
//  Created by Negov, Rodion on 04.04.2018.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

class MainAuthorizedTabBar: UITabBarController {
    var callbacks = TypedCallbackArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if childViewControllers.count > 1, var vc = childViewControllers[1] as? CoordinatorModuleProtocol {
            vc.callbacks = callbacks
        }
    }
}
