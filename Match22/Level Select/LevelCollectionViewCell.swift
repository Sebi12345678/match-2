//
//  LevelCollectionViewCell.swift
//  Match2
//
//  Created by VM on 10/23/20.
//

import UIKit

class LevelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lvlNoLabel: UILabel!
    @IBOutlet weak var starsView: StarsView!
    var difficulty = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell (nrLvl: Int, dif: Int){
        lvlNoLabel.text = String(nrLvl)
        difficulty = dif
        starsView.setStars(count: dif)
    }

}
