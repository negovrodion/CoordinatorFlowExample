//
//  LoginViewOutputProtocol.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

// MARK: - LoginVCOutputProtocol
protocol LoginViewOutputProtocol: class {
    func didTapToRegistration()
    func didTapToPasswordRestore()
    func didTapLogin()
    func didTapUnsuccessfulLogin()
}
