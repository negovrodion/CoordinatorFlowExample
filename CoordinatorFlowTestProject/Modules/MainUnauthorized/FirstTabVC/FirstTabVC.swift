//
//  FirstTabVC.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/26/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

// MARK: - FirstTabVC
final class FirstTabVC: UIViewController {
    var callbacks = TypedCallbackArray()
    
    
    @IBAction func didTapShowNotification(_ sender: UIButton) {
        _ = callbacks[.showNotification]?(nil)
    }
}
