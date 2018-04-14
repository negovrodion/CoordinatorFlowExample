//
//  LoginPresenter.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation
import CoordinatorFlow

// MARK: - LoginVM
final class LoginPresenter {
    var callbacks = TypedCallbackArray()
    
    weak var view: LoginViewInputProtocol!
    var interactor: LoginInteractorInputProtocol!
}
