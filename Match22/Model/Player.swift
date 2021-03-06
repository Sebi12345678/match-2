//
//  Player.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

class Player: NSObject {
    var name: String
    var bestScore: Double?
    var bestLevel: Int?
    var bestTime: String?
    var id: String
    var levelsDone: [LevelDone]?
    //override init (){}
    init (name: String, id: String){
        self.name = name
        self.id = id
    }
}
