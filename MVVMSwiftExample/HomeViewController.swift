//
//  HomeViewController.swift
//  MVVMSwiftExample
//
//  Created by Dino Bartosak on 25/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

//Root view controller, which presents the GameScoreboardViewController

//https://www.toptal.com/ios/swift-tutorial-introduction-to-mvvm

import UIKit

class HomeViewController: UIViewController {
    
    var gameLibrary: GameServiceProtocol? {
        didSet {
            showGameScoreboardViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showGameScoreboardViewController()
    }
    
    // MARK: Private
    
    fileprivate func showGameScoreboardViewController() {
        if !self.isViewLoaded {
            return
        }
        
        guard let gameLibrary = gameLibrary else {
            return
        }
        
        if let game = gameLibrary.allGames().first {
            
            let controller = UIStoryboard.loadGameScoreboardViewController()
            
            // uncomment this when view model is implemented
            let viewModel = GameScoreboardViewModel(withGame: game)
            controller.viewModel = viewModel
            
            self.insertChildController(controller, intoParentView: self.view)
        }
    }
}


