//
//  SettingsVC.swift
//  CoordinatorFlowTestProject
//
//  Created by Negov, Rodion on 28.03.2018.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

// MARK: - SettingsVC
class SettingsVC: UIViewController {
    var callbacks = TypedCallbackArray()
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        _ = callbacks[.didLogout]?(nil)
    }
}

