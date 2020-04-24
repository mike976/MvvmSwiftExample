//
//  Team.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//


//Contains team name and players list (three players in each team).

import Foundation

class TeamModel: NSObject {
    
    let identifier: String
    var name: String
    var players: [PlayerModel]
    
    init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
        self.players = []
    }
    
    func addPlayer(_ player: PlayerModel) {
        self.players.append(player)
    }

    func containsPlayer(_ player: PlayerModel) -> Bool {
        var contains: Bool = false
        for currentPlayer in players {
            if currentPlayer.identifier == player.identifier {
                contains = true
                break
            }
        }
        
        return contains
    }
    
}
