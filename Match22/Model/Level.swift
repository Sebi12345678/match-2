//
//  Level.swift
//  Match22
//
//  Created by VM on 2/6/21.
//

import UIKit

class Level: NSObject {
    var id: Int
    var difficulty: Int
    var theme: String?
    init (id: Int, difficulty: Int, theme: String){
    //init (difficulty: Int, theme: String){
        self.id = id
        self.difficulty = difficulty
        self.theme = theme
    }
}
