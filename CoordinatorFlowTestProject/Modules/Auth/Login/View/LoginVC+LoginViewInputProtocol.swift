//
//  LoginVC+LoginViewInputProtocol.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

// MARK: - LoginViewInputProtocol
extension LoginVC: LoginViewInputProtocol {
    func goToRegistration() {
        performSegue(withIdentifier: Constants.toRegistration, sender: nil)
    }
    
    func goToPasswordRestore() {
        performSegue(withIdentifier: Constants.toPasswordRestore, sender: nil)
    }
}
