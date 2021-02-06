//
//  Level.swift
//  Match22
//
//  Created by VM on 2/6/21.
//

import UIKit

class Level: NSObject {
    var difficulty: Int
    var theme: String?
    init (difficulty: Int, theme: String){
        self.difficulty = difficulty
        self.theme = theme
    }
}
