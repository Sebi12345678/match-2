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
    var id: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell (lvl: Level){
        let themes = DatabaseManager.shared.themeColors
        if let levelTheme = lvl.theme {
            let colorHex = themes?[levelTheme]
            color = Utils.hexStringToUIColor(hex: colorHex ?? "#888888")
            mainView.backgroundColor = color
        }
            
        lvlNoLabel.text = String(lvl.id)
        id = lvl.id
        difficulty = lvl.difficulty
        starsView.setStars(count: difficulty)
    }

}
