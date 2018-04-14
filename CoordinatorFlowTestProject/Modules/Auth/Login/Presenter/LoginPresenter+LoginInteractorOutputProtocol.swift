//
//  LoginPresenter+LoginInteractorOutputProtocol.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

// MARK: - LoginInteractorOutputProtocol
extension LoginPresenter: LoginInteractorOutputProtocol {
    
    func didLogin() {
        _ = callbacks[.didLogin]?(nil)
    }
    
}
