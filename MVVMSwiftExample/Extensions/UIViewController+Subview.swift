//
//  UIViewController.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 26/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import UIKit

//allows the injecting child controller and child view to parent controller and parent view

extension UIViewController {
    
    func insertChildController(_ childController: UIViewController, intoParentView parentView: UIView) {
        childController.willMove(toParent: self)
        
        self.addChild(childController)
        childController.view.frame = parentView.bounds
        parentView.addSubview(childController.view)
        
        childController.didMove(toParent: self)
    }
    
}

