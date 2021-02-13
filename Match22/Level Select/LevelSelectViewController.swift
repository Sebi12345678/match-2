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
    var levels: [Level] = [Level]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "LevelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LevelCollectionViewCell")
        
        DatabaseManager.shared.getData(firstRef:"levels", secondRef: nil, completion:{(dictionary, array) in
            guard let levels = array else {
                return
            }
            
            for (id, level) in levels.enumerated() {
                if let levelObject = level as? NSDictionary{
                if let difficulty = levelObject["difficulty"] as? Int,
                   let theme = levelObject["theme"] as? String{
                    self.levels.append(Level(id: id,difficulty: difficulty, theme: theme))
                }
                }
            }
            self.collectionView.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }
    func goToGame (boardSize: [Int]?, difficulty: String, color: UIColor?){
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController, let boardSize = boardSize{
            viewController.numberOfColumns = boardSize[0]
            viewController.numberOfRows = boardSize[1]
            viewController.difficulty = difficulty
            viewController.color = color
            navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
extension LevelSelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return levels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LevelCollectionViewCell", for: indexPath) as! LevelCollectionViewCell
        let level = levels[indexPath.row]
        
        cell.configureCell(nrLvl: indexPath.row+1, lvl: level)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? LevelCollectionViewCell
    
        switch cell?.difficulty {
        case 1:
            goToGame(boardSize: difficulties["easy"], difficulty: "easy", color: cell?.color)
        case 2:
            goToGame(boardSize: difficulties["medium"], difficulty: "medium", color: cell?.color)
        case 3:
            goToGame(boardSize: difficulties["hard"], difficulty: "hard", color: cell?.color)
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
