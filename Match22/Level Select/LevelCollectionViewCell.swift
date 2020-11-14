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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configureCell (nrLvl: Int, dif: Int){
        lvlNoLabel.text = String(nrLvl)
        starsView.setStars(count: dif)
    }

}
