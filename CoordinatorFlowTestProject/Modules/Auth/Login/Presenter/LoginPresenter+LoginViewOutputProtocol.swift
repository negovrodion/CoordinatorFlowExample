//
//  LoginPresenter+LoginViewInputProtocol.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

// MARK: - LoginViewOutputProtocol
extension LoginPresenter: LoginViewOutputProtocol {
    func didTapToRegistration() {
        view.goToPasswordRestore()
    }
    
    func didTapToPasswordRestore() {
        view.goToPasswordRestore()
    }
    
    func didTapLogin() {
        interactor.makeLogin()
    }
    
    func didTapUnsuccessfulLogin() {
        interactor.makeUnsuccessfulLogin()
    }
}
