//
//  GameScoreboardEditorViewModelFromGame.swift
//  MVVMSwiftExample
//
//  Created by Michael Bullock on 24/04/2020.
//  Copyright © 2020 Toptal. All rights reserved.
//

import Foundation

class GameScoreboardViewModel: NSObject, GameScoreboardViewModelProtocol {
    
    let game: Game
    
    struct Formatter {
        static let durationFormatter: DateComponentsFormatter = {
            let dateFormatter = DateComponentsFormatter()
            dateFormatter.unitsStyle = .positional
            return dateFormatter
        }()
    }
    
    // MARK: GameScoreboardEditorViewModel protocol
    
    var homeTeam: String
    var awayTeam: String
    
    let time: Dynamic<String>
    let score: Dynamic<String>
    let isFinished: Dynamic<Bool>
    let isPaused: Dynamic<Bool>
    
    
    func togglePause() {
        if isPaused.value {
            startTimer()
        } else {
            pauseTimer()
        }
        
        self.isPaused.value = !isPaused.value
    }
    
    let homePlayers: [PlayerScoreboardViewModel]
    let awayPlayers: [PlayerScoreboardViewModel]
    
    // MARK: Init
    
    init(withGame game: Game) {
        self.game = game
        
        self.homeTeam = game.homeTeam.name
        self.awayTeam = game.awayTeam.name
        
        self.time = Dynamic(GameScoreboardViewModel.timeRemainingPretty(for: game))
        self.score = Dynamic(GameScoreboardViewModel.scorePretty(for: game))
        self.isFinished = Dynamic(game.isFinished)
        self.isPaused = Dynamic(true)
        
        self.homePlayers = GameScoreboardViewModel.playerViewModels(from: game.homeTeam.players, game: game)
        self.awayPlayers = GameScoreboardViewModel.playerViewModels(from: game.awayTeam.players, game: game)
        
        super.init()
        subscribeToNotifications()
    }
    
    // MARK: deinit
    
    deinit {
        unsubscribeFromNotifications()
    }
    
    // MARK: Private
    
    fileprivate var gameTimer: Timer?
    fileprivate func startTimer() {
        let interval: TimeInterval = 0.001
        gameTimer = Timer.schedule(repeatInterval: interval) { timer in
            self.game.time += interval
            self.time.value = GameScoreboardViewModel.timeRemainingPretty(for: self.game)
        }
    }
    
    fileprivate func pauseTimer() {
        gameTimer?.invalidate()
        gameTimer = nil
    }
    
    fileprivate static func playerViewModels(from players: [Player], game: Game) -> [PlayerScoreboardViewModel] {
        var playerViewModels: [PlayerScoreboardViewModel] = [PlayerScoreboardViewModel]()
        for player in players {
            playerViewModels.append(PlayerScoreboardMoveEditorViewModelFromPlayer(withGame: game, player: player))
        }
        
        return playerViewModels
    }
    
    fileprivate func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(gameScoreDidChangeNotification(_:)),
                                               name: NSNotification.Name(rawValue: GameNotifications.GameScoreDidChangeNotification),
                                               object: game)
    }
    
    fileprivate func unsubscribeFromNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc fileprivate func gameScoreDidChangeNotification(_ notification: NSNotification){
        self.score.value = GameScoreboardViewModel.scorePretty(for: game)
        
        if game.isFinished {
            self.isFinished.value = true
        }
    }
    
    // MARK: String Utils
    
    fileprivate static func timeFormatted(totalMillis: Int) -> String {
        let millis: Int = totalMillis % 1000 / 100 // "/ 100" <- because we want only 1 digit
        let totalSeconds: Int = totalMillis / 1000
        
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60)
        
        return String(format: "%02d:%02d.%d", minutes, seconds, millis)
    }
    
    fileprivate static func timeRemainingPretty(for game: Game) -> String {
        return timeFormatted(totalMillis: Int(game.time * 1000))
    }
    
    fileprivate static func scorePretty(for game: Game) -> String {
        return String(format: "\(game.homeTeamScore) - \(game.awayTeamScore)")
    }
    
}
