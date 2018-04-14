//
//  LoginService.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import Foundation

final class LoginService {
    
    static var _isLoggedIn: Bool = false
    
    static var isLoggedIn: Bool {
        return _isLoggedIn
    }
}
