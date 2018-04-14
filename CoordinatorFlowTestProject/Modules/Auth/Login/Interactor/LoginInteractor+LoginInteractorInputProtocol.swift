//
//  LoginInteractor+LoginInteractorInputProtocol.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

// MARK: - LoginInteractorInputProtocol
extension LoginInteractor: LoginInteractorInputProtocol {
    
    func makeLogin() {
        LoginService._isLoggedIn = true
        
        presenter.didLogin()
    }
    
    func makeUnsuccessfulLogin() {
        LoginService._isLoggedIn = false
        
        presenter.didLogin()
    }
}
