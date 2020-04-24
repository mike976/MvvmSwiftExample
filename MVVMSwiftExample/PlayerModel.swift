//
//  Player.swift
//  MVVMExample
//
//  Created by Dino Bartosak on 15/09/16.
//  Copyright © 2016 Toptal. All rights reserved.
//

//A single player with a name.


import Foundation

class PlayerModel: NSObject {
    
    let identifier: String
    var name: String
    
    init(name: String, identifier: String) {
        self.name = name
        self.identifier = identifier
    }
}
