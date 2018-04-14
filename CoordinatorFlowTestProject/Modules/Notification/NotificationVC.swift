//
//  NotificationVC.swift
//  CoordinatorFlowTestProject
//
//  Created by Negov, Rodion on 28.03.2018.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

// MARK: - NotificationVC
final class NotificationVC: UIViewController {
    
    var callbacks = TypedCallbackArray()
    
    @IBAction func didTapLogout(_ sender: UIButton) {
        // https://objectpartners.com/2013/04/08/dismissing-modal-and-current-uiviewcontrollers-in-the-same-delegate/
        // if presentingViewController not dismissing or removing from vie stack, it is okay to use animated: true
        dismiss(animated: false, completion: { [weak self] in
            _ = self?.callbacks[.didLogout]?(nil)
        })
    }
}
