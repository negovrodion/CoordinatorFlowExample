//
//  LoginVC.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/24/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit

// MARK: - LoginVC
final class LoginVC: UIViewController {
    var presenter: LoginViewOutputProtocol!

    enum Constants {
        static let toPasswordRestore = "toPasswordRestore"
        static let toRegistration    = "toRegistration"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "LoginVC"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        if identifier == Constants.toPasswordRestore, let vc = segue.destination as? PasswordRestoreVC {
            vc.vm = PasswordRestoreVM()
        } else if identifier == Constants.toRegistration, let vc = segue.destination as? RegistrationVC {
            vc.vm = RegistrationVM()
        }
    }
    
    @IBAction func toRegistration(_ sender: UIButton) {
        presenter.didTapToRegistration()
    }
    
    @IBAction func toPasswordRestore(_ sender: UIButton) {
        presenter.didTapToPasswordRestore()
    }
    
    @IBAction func toLogin(_ sender: UIButton) {
        presenter.didTapLogin()
    }
    
    @IBAction func unsuccessfulLogin(_ sender: UIButton) {
        presenter.didTapUnsuccessfulLogin()
    }
}
