//
//  LevelSelectViewController.swift
//  Match2
//
//  Created by VM on 10/23/20.
//

import UIKit


class LevelSelectViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let numberOfColumns = 3
    
    let difficulties = ["easy": [4, 6],"medium": [5, 8], "hard": [6, 10]]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LevelCollectionViewCell")

        // Do any additional setup after loading the view.
    }
}
extension LevelSelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCollectionViewCell", for: indexPath) as! LevelCollectionViewCell
        cell.configureCell(nrLvl: indexPath.row+1, dif: Int.random(in: 1...3))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? LevelCollectionViewCell
    
        switch cell?.difficulty {
        case 1:
            print(difficulties["easy"])
        case 2:
            print(difficulties["medium"])
        case 3:
            print(difficulties["hard"])
        default:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 10, height: 10)
        let spacings : CGFloat = 10.0 * (CGFloat (numberOfColumns) + 1.0)
        let widthLeft = collectionView.frame.width - spacings
        let cellSize = widthLeft/CGFloat(numberOfColumns)
        return CGSize(width: cellSize, height: cellSize)
    }
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10 , bottom: 10, right: 10)
    }
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return 10
    }
}
