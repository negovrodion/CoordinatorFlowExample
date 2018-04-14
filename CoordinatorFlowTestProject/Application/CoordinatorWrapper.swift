//
//  CoordinatorWrapper.swift
//  GTT
//
//  Created by Rodion Negov on 3/14/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

// MARK: - CoordinatorWrapper
class CoordinatorWrapper {
    
    var appCoordinator = ApplicationCoordinator()
    
    // MARK: - Constants
    fileprivate enum Constants {
        static let authStoryboard = "Auth"
        static let loginVC        = "LoginVC"
        
        static let mainAuthorized       = "MainAuthorized"
        static let mainAuthorizedTabBar = "MainAuthorizedTabBar"
        
        static let mainUnauthorized = "MainUnauthorized"
        static let parentVC         = "ParentVC"
        static let firstTabVC       = "FirstTabVC"
        static let secondTabVC      = "SecondTabVC"
        
        static let notificationStoryboard = "Notification"
    }
    
    init() {
        appCoordinator.startAction = { [weak self] in
            guard LoginService.isLoggedIn else {
                self?.appCoordinator.loadCoordinator(with: .auth)
                
                return
            }
            
            self?.appCoordinator.loadCoordinator(with: .login)
        }
        
        addAuthModuleCoordinator()
        addNotificationCoordinator()
    }

    // MARK: - Auth
    fileprivate func addAuthModuleCoordinator() {
        var callbacks = TypedCallbackArray()

        callbacks[.didLogin] = { [weak self] _ in
            self?.addMainCoordinator()
            self?.appCoordinator.loadCoordinator(with: .main)
            
            return nil
        }

        let coordinatorDescription = CoordinatorDescription(type: .auth, callbacks: callbacks)

        let presentPolicy = PresentPolicy(storyboardName: Constants.authStoryboard,
                                          loadNavigationControllerFromStoryboard: true,
                                          vcName: Constants.loginVC) { [weak self] () -> (UIViewController?) in

            let vc: LoginVC? = self?.appCoordinator.loadViewController(type: .auth)
            let presenter    = LoginPresenter()
            let interactor   = LoginInteractor()
                                            
            presenter.interactor = interactor
            interactor.presenter = presenter
            presenter.view       = vc
            vc?.presenter        = presenter
                                            
            presenter.callbacks = callbacks

            return vc
        }

        appCoordinator.addModuleCoordinator(with: coordinatorDescription, presentPolicy: presentPolicy)
        
        appCoordinator.setDependency(when: .auth, remove: [.main, .notification])
    }
    
    // MARK: - MainUnauthorized
    fileprivate func addMainUnauthorizedCoordinator(parentCoordinator: Coordinator) {
        var callbacks = TypedCallbackArray()
        
        callbacks[.loadFirstTab] = { [weak coord = parentCoordinator] _ in
            
            let vc = coord?.loadViewController(type: .mainUnauthorized, identifire: Constants.firstTabVC)
            
            return vc
        }
        
        callbacks[.loadSecondTab] = { [weak coord = parentCoordinator] _ in
            
            let vc = coord?.loadViewController(type: .mainUnauthorized, identifire: Constants.secondTabVC)
            
            return vc
        }
        
        callbacks[.showNotification] = { [weak self] _ in
            self?.appCoordinator.loadCoordinator(with: .notification)
        }
        
        let coordinatorDescription = CoordinatorDescription(type: .mainUnauthorized, callbacks: callbacks)
        
        let presentPolicy = PresentPolicy(storyboardName: Constants.mainUnauthorized,
                                          loadNavigationControllerFromStoryboard: true,
                                          vcName: Constants.parentVC) { [weak coord = parentCoordinator] () ->
                                            (UIViewController?) in
                                            
            let vc: ParentVC? = coord?.loadViewController(type: .mainUnauthorized)
            vc?.callbacks     = callbacks
            
            return vc
        }
        
        parentCoordinator.addModuleCoordinator(with: coordinatorDescription, presentPolicy: presentPolicy)
    }
    
    fileprivate func addMainAuthorizedCoordinator(parentCoordinator: Coordinator) {
        var callbacks = TypedCallbackArray()
        
        callbacks[.didLogout] = { [weak self] _ in
            self?.appCoordinator.loadCoordinator(with: .auth)
        }
        
        let coordinatorDescription = CoordinatorDescription(type: .mainAuthorized, callbacks: callbacks)
        
        let presentPolicy = PresentPolicy(storyboardName: Constants.mainAuthorized) {
            [weak coord = parentCoordinator] () -> (UIViewController?) in
            
            let vc: MainAuthorizedTabBar? = coord?.loadViewController(type: .mainAuthorized)
            vc?.callbacks     = callbacks
            
            return vc
        }
        
        parentCoordinator.addModuleCoordinator(with: coordinatorDescription, presentPolicy: presentPolicy)
    }
    
    fileprivate func addMainCoordinator() {
        var callbacks = TypedCallbackArray()
        
        callbacks[.didLogout] = { [weak self] _ in
            self?.appCoordinator.loadCoordinator(with: .auth)
        }
        
        let coordinatorDescription = CoordinatorDescription(type: .main, callbacks: callbacks)
        let coordinator            = Coordinator()
        
        coordinator.startAction = { [weak coord = coordinator] in
            if !LoginService.isLoggedIn {
                coord?.loadCoordinator(with: .mainUnauthorized)
            } else {
                coord?.loadCoordinator(with: .mainAuthorized)
            }
        }
        
        addMainUnauthorizedCoordinator(parentCoordinator: coordinator)
        addMainAuthorizedCoordinator(parentCoordinator: coordinator)
        
        appCoordinator.addCoordinator(coordinator: coordinator, with: coordinatorDescription)
        
        appCoordinator.setDependency(when: .main, remove: [.auth, .notification])
    }

    // MARK: - Notification
    fileprivate func addNotificationCoordinator() {
        var callbacks = TypedCallbackArray()

        callbacks[.didLogout] = { [weak self] _ in
            self?.appCoordinator.loadCoordinator(with: .auth)
        }

        let coordinatorDescription = CoordinatorDescription(type: .notification,
                                                            removeAllFromNavigationControllerStackBeforeLoad: false,
                                                            clearCoordinatorsStackWhenLoad: false, callbacks: callbacks)

        let presentPolicy = PresentPolicy(storyboardName: Constants.notificationStoryboard,
                                          presentStyle: .presentModally(true),
                                          vcName: nil) { [weak self] () -> (UIViewController?) in
            let notificationVC: NotificationVC? = self?.appCoordinator.loadViewController(type: .notification)
            notificationVC?.callbacks           = callbacks

            return notificationVC
        }

        appCoordinator.addModuleCoordinator(with: coordinatorDescription, presentPolicy: presentPolicy)
    }
    
}

// MARK: - CoordinatorType
extension CoordinatorType {
    static let notification     = CoordinatorType(rawValue: "notification")
    static let mainUnauthorized = CoordinatorType(rawValue: "mainUnauthorized")
    static let mainAuthorized   = CoordinatorType(rawValue: "mainAuthorized")
    static let auth             = CoordinatorType(rawValue: "auth")
}

// MARK: - CallbackType
extension CallbackType {
    static let didLogin  = CallbackType(rawValue: "didLogin")
    static let didLogout = CallbackType(rawValue: "didLogout")
    
    static let loadFirstTab  = CallbackType(rawValue: "loadFirstTab")
    static let loadSecondTab = CallbackType(rawValue: "loadSecondTab")
    
    static let showNotification = CallbackType(rawValue: "showNotification")
    
    
    static let didRefresh        = CallbackType(rawValue: "didRefresh")
    static let didTapTimeEnter   = CallbackType(rawValue: "didTapTimeEnter")
    static let didTapTimeApprove = CallbackType(rawValue: "didTapTimeApprove")
}
