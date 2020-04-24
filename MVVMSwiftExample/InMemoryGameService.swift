//
//  InMemoryGameLibrary.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 18/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

class InMemoryGameService: NSObject, GameServiceProtocol {
    
    fileprivate var games: [GameModel] = []
    
    override init() {
        super.init()

        // add some teams
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
        addDummyGame()
    }
    
    fileprivate func addDummyGame() {
        let homeTeam: TeamModel = TeamModel(name: "Ballerz", identifier: UUID().uuidString)
        homeTeam.addPlayer(PlayerModel(name: "Shaq", identifier: UUID().uuidString))
        homeTeam.addPlayer(PlayerModel(name: "A.I.", identifier: UUID().uuidString))
        homeTeam.addPlayer(PlayerModel(name: "T-Mac", identifier: UUID().uuidString))
        
        let awayTeam: TeamModel = TeamModel(name: "Ringerz", identifier: UUID().uuidString)
        awayTeam.addPlayer(PlayerModel(name: "Hakeem", identifier: UUID().uuidString))
        awayTeam.addPlayer(PlayerModel(name: "Air Carter", identifier: UUID().uuidString))
        awayTeam.addPlayer(PlayerModel(name: "Kobe", identifier: UUID().uuidString))
        
        let game: GameModel = GameModel(homeTeam: homeTeam, awayTeam: awayTeam, identifier: UUID().uuidString)
        self.games.append(game)
    }
    
    // MARK: GameLibrary Protocol
    
    func allGames() -> [GameModel] {
        return games
    }
    
    func addGame(_ game: GameModel) {
        for currentGame in games {
            if currentGame.identifier == game.identifier {
                return
            }
        }
        
        games.append(game)
        NotificationCenter.default.post(notification(GameLibraryNotifications.GameLibraryGameAdded, game: game))
    }
    
    func removeGame(_ game: GameModel) {
        var indexToRemove: Int?
        for index in 0...games.count-1 {
            let currentGame = games[index]
            if currentGame.identifier == game.identifier {
                indexToRemove = index
                break
            }
        }
        
        if let indexToRemove = indexToRemove {
            games.remove(at: indexToRemove)
            NotificationCenter.default.post(notification(GameLibraryNotifications.GameLibraryGameRemoved, game: game))
        }
    }
    
    func updateGame(_ game: GameModel) {
        var existingGame: GameModel?
        for currentGame in games {
            if currentGame.identifier == game.identifier {
                existingGame = currentGame
                break
            }
        }
        
        if let existingGame = existingGame {
            existingGame.homeTeam = game.homeTeam
            existingGame.awayTeam = game.awayTeam
            existingGame.homeTeamScore = game.homeTeamScore
            existingGame.awayTeamScore = game.awayTeamScore
            
            NotificationCenter.default.post(notification(GameLibraryNotifications.GameLibraryGameUpdated, game: existingGame))
        }
    }
    
    // MARK: Private
    
    fileprivate func notification(_ name: String, game: GameModel) -> Notification {
        let notification: Notification = Notification(name: Notification.Name(rawValue: name), object: self, userInfo: ["game" : game])
        
        return notification
    }
    
}
