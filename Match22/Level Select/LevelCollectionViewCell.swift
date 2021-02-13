//
//  LevelCollectionViewCell.swift
//  Match2
//
//  Created by VM on 10/23/20.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lvlNoLabel: UILabel!
    @IBOutlet weak var starsView: StarsView!
    var difficulty = 0
    var color: UIColor = .gray
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell (nrLvl: Int, lvl: Level){
        let themes = DatabaseManager.shared.themeColors
        if let levelTheme = lvl.theme {
            let colorHex = themes?[levelTheme]
            color = Utils.hexStringToUIColor(hex: colorHex ?? "#888888")
            mainView.backgroundColor = color
        }
            
        lvlNoLabel.text = String(nrLvl)
        
        difficulty = lvl.difficulty
        starsView.setStars(count: difficulty)
    }

}
