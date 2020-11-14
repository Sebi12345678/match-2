//
//  StarsView.swift
//  Match2
//
//  Created by VM on 10/23/20.
//

import UIKit
let emptyStarName = "star-image-dis"
let fullStarName = "star-image"

class StarsView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        comminit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        comminit()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds
    }
    func comminit() {
        Bundle.main.loadNibNamed("StarsView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
    }
    func setStars(count: Int) {
        switch(count){
        case 1: setEasyDif()
        case 2: setMediumDif()
        case 3: setHardDif()
        default: setMediumDif()
        }
    }
    func setEasyDif(){
        firstStar.image = UIImage(named: fullStarName)
        secondStar.image = UIImage(named: emptyStarName)
        thirdStar.image = UIImage(named: emptyStarName)
    }
    func setMediumDif(){
        firstStar.image = UIImage(named: fullStarName)
        secondStar.image = UIImage(named: fullStarName)
        thirdStar.image = UIImage(named: emptyStarName)
    }
    func setHardDif(){
        firstStar.image = UIImage(named: fullStarName)
        secondStar.image = UIImage(named: fullStarName)
        thirdStar.image = UIImage(named: fullStarName)
    }
}
