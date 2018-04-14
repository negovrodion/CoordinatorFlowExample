//
//  ParentVC.swift
//  CoordinatorFlowTestProject
//
//  Created by Rodion Negov on 3/26/18.
//  Copyright © 2018 Rodion Negov. All rights reserved.
//

import UIKit
import CoordinatorFlow

// MARK: - ParentVC
final class ParentVC: UIViewController {
    
    @IBOutlet weak var parentView: UIView!
    
    var callbacks = TypedCallbackArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func tab1Tap(_ sender: UIButton) {
        guard let vc = callbacks[.loadFirstTab]?(nil) as? FirstTabVC else {
            return
        }
        
        vc.callbacks = callbacks
        
        displayVC(vc: vc)
    }
    
    @IBAction func tab2Tap(_ sender: UIButton) {
        guard let vc = callbacks[.loadSecondTab]?(nil) as? UIViewController else {
            return
        }
        
        displayVC(vc: vc)
    }
    
    fileprivate func displayVC(vc: UIViewController) {
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
        
        vc.view.frame = parentView.bounds
        parentView.addSubview(vc.view)
    }
}
