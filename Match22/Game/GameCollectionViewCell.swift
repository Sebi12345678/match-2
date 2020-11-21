//
//  GameCollectionViewCell.swift
//  Match22
//
//  Created by VM on 11/21/20.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    var isRotated = false
    func reveal(){
        if(!isRotated){
            //contentView.backgroundColor = .black
            let animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
            animation.duration = 1
            animation.toValue = Double.pi/2
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            contentView.layer.add(animation, forKey: "rotate1")
            isRotated = true
        }
        else{
            let animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
            animation.duration = 1
            animation.toValue = 0
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            contentView.layer.add(animation, forKey: "rotate2")
            isRotated = false
        }
    }
}
