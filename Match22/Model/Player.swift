//
//  Player.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

struct Player: Codable{
    var name: String
    var bestScore: Double?
    var bestLevel: Int?
    var bestTime: String?
    var id: String?
    var levelsDone: [LevelDone]?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case bestScore = "bestScore"
        case bestLevel = "bestLevel"
        case bestTime = "bestTime"
        //case id = "id"
        case levelsDone = "levelsDone"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        bestScore = try? container.decode(Double.self, forKey: .bestScore)
        bestLevel = try? container.decode(Int.self, forKey: .bestLevel)
        levelsDone = try? container.decode([LevelDone].self, forKey: .levelsDone)
        bestTime = try? container.decode(String.self, forKey: .bestTime)
        //levelsDone = try? container.decode([LevelDone].self, forKey: .levelsDone)
        
        
    }
}
