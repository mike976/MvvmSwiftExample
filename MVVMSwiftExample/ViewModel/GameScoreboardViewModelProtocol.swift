//
//  GameScoreboardViewModel.swift
//  MVVMSwiftExample
//
//  Created by Michael Bullock on 24/04/2020.
//  Copyright © 2020 Toptal. All rights reserved.
//

import Foundation

protocol GameScoreboardViewModelProtocol {
    
    var homeTeam: String { get }
    var awayTeam: String { get }

    var time: Dynamic<String> { get }
    var score: Dynamic<String> { get }
    var isFinished: Dynamic<Bool> { get }
    var isPaused: Dynamic<Bool> { get }
    
    func togglePause()
    
    var homePlayers: [PlayerScoreboardViewModelProtocol] { get }
    var awayPlayers: [PlayerScoreboardViewModelProtocol] { get }
}
