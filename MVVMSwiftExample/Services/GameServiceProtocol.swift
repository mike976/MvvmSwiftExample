//
//  GameLibrary.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 18/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

import Foundation

enum GameLibraryNotifications {
    static let GameLibraryGameAdded    = "GameLibraryGameAdded"
    static let GameLibraryGameRemoved  = "GameLibraryGameRemoved"
    static let GameLibraryGameUpdated  = "GameLibraryGameUpdated"
}

protocol GameServiceProtocol {
    func allGames() -> [GameModel]
    func addGame(_ game: GameModel) // posts GameLibraryGameAdded notifications
    func removeGame(_ game: GameModel) // posts GameLibraryGameRemoved notifications
    func updateGame(_ game: GameModel) // posts GameLibraryGameUpdated notifications
}
