//
//  PlayerScoreboardViewModel.swift
//  MVVMSwiftExample
//
//  Created by Michael Bullock on 24/04/2020.
//  Copyright © 2020 Toptal. All rights reserved.
//

import Foundation

class PlayerScoreboardViewModel: NSObject, PlayerScoreboardViewModelProtocol {
    
    fileprivate let player: PlayerModel
    fileprivate let game: GameModel
    
    // MARK: PlayerScoreboardViewModel protocol
    
    let playerName: String
    
    let onePointMoveCount: Dynamic<String>
    let twoPointMoveCount: Dynamic<String>
    let assistMoveCount: Dynamic<String>
    let reboundMoveCount: Dynamic<String>
    let foulMoveCount: Dynamic<String>
    
    func onePointMove() {
        makeMove(.onePoint)
    }
    
    func twoPointsMove() {
        makeMove(.twoPoints)
    }
    
    func assistMove() {
        makeMove(.assist)
    }
    
    func reboundMove() {
        makeMove(.rebound)
    }
    
    func foulMove() {
        makeMove(.foul)
    }
    
    // MARK: Init
    
    init(withGame game: GameModel, player: PlayerModel) {
        self.game = game
        self.player = player
        
        self.playerName = player.name
        self.onePointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .onePoint))")
        self.twoPointMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .twoPoints))")
        self.assistMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .assist))")
        self.reboundMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .rebound))")
        self.foulMoveCount = Dynamic("\(game.playerMoveCount(for: player, move: .foul))")
    }
    
    // MARK: Private
    
    fileprivate func makeMove(_ move: PlayerInGameMove) {
        game.addPlayerMove(move, for: player)
        
        onePointMoveCount.value = "\(game.playerMoveCount(for: player, move: .onePoint))"
        twoPointMoveCount.value = "\(game.playerMoveCount(for: player, move: .twoPoints))"
        assistMoveCount.value = "\(game.playerMoveCount(for: player, move: .assist))"
        reboundMoveCount.value = "\(game.playerMoveCount(for: player, move: .rebound))"
        foulMoveCount.value = "\(game.playerMoveCount(for: player, move: .foul))"
    }
    
}
