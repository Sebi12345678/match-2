//
//  GameCollectionViewCell.swift
//  Match22
//
//  Created by VM on 11/21/20.
//

import UIKit

class GameCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backCardView: UIView!
    @IBOutlet weak var frontCardView: UIImageView!
    var matchNumber = 0
    var isRotated = false
    func reveal(){
        
        CATransaction.begin()
        CATransaction.setCompletionBlock  ({
            if(self.isRotated)
            {
                self.frontCardView.isHidden = false
                self.frontCardView.transform = CGAffineTransform(scaleX: 0.0, y: 1.0)
                UIView.animate(withDuration: 1, animations: {
                    self.frontCardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        })
        
        if(!isRotated){
            //contentView.backgroundColor = .black
            //let transaction = CATransaction()


            isRotated = true
            
            let animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
            animation.duration = 1
            animation.toValue = Double.pi/2
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            backCardView.layer.add(animation, forKey: "rotate1")
            
            
}
        else{
            self.frontCardView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            UIView.animate(withDuration: 1, animations: {
                self.frontCardView.transform = CGAffineTransform(scaleX: 0.01, y: 1.0)
            },completion:{ _ in
                let animation = CABasicAnimation.init(keyPath: "transform.rotation.y")
                animation.duration = 1
                animation.toValue = 0
                animation.fillMode = .forwards
                animation.isRemovedOnCompletion = false
                self.backCardView.layer.add(animation, forKey: "rotate2")
                self.isRotated = false
                self.frontCardView.isHidden = true
            })
            print("hide")
        }
        CATransaction.commit()
        
        
    }
}
