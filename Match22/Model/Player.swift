//
//  Player.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

class Player: NSObject {
    var name: String
    var score: Double?
    var id: String
    var levelsDone: [Int]?
    //override init (){}
    init (nume: String, scor: Double, id: String){
        self.name = nume
        self.score = scor
        self.id = id
    }
    
}
