//
//  PlayerScoreboardViewModel.swift
//  MVVMSwiftExample
//
//  Created by Michael Bullock on 24/04/2020.
//  Copyright © 2020 Toptal. All rights reserved.
//

import Foundation

protocol PlayerScoreboardViewModelProtocol {
   
    var playerName: String { get }
    
    var onePointMoveCount: Dynamic<String> { get }
    var twoPointMoveCount: Dynamic<String> { get }
    var assistMoveCount: Dynamic<String> { get }
    var reboundMoveCount: Dynamic<String> { get }
    var foulMoveCount: Dynamic<String> { get }
    
    func onePointMove()
    func twoPointsMove()
    func assistMove()
    func reboundMove()
    func foulMove()
}
