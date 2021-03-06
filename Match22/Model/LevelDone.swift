//
//  LevelDone.swift
//  Match22
//
//  Created by VM on 3/6/21.
//

import UIKit

class LevelDone: NSObject {
    var id: Int
    var score: Double
    var time: String
    init (id: Int, score: Double, time: String)
    {
        self.id = id
        self.score = score
        self.time = time
    }
}

