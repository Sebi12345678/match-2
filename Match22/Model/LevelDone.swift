//
//  LevelDone.swift
//  Match22
//
//  Created by VM on 3/6/21.
//

import UIKit

struct LevelDone: Codable {
    var id: Int
    var score: Double
    var time: String
    init ()
    {
        self.id = 0
        self.score = 0.0
        self.time = ""
    }
}

