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
    //easy 4, 6
    let difficulties = ["easy": [2, 2],"medium": [5, 8], "hard": [6, 10]]
    let difficultyNames = ["", "easy", "medium", "hard"]
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
            
            do{
                let json = try JSONSerialization.data(withJSONObject: levels, options: .prettyPrinted)
                self.levels = try JSONDecoder().decode([Level].self, from: json)
            }
            catch{
                print(error)
            }
            self.collectionView.reloadData()
        })
        
        // Do any additional setup after loading the view.
    }
    func goToGame (level: Level?, boardSize: [Int]?, color: UIColor?){
        guard let level = level else {
            return
        }
        if let viewController = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as? GameViewController, let boardSize = boardSize{
            viewController.numberOfColumns = boardSize[0]
            viewController.numberOfRows = boardSize[1]
            viewController.difficulty = difficultyNames[level.difficulty]
            viewController.theme = level.theme ?? ""
            viewController.color = color
            viewController.id = level.id
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
        
        cell.configureCell(lvl: level)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        let cell = collectionView.cellForItem(at: indexPath) as? LevelCollectionViewCell
        //let levelId = cell?.id ?? 0
        
        switch cell?.level?.difficulty {
        case 1:
            goToGame(level: cell?.level, boardSize: difficulties["easy"], color: cell?.color)
        case 2:
            goToGame(level: cell?.level, boardSize: difficulties["medium"], color: cell?.color)
        case 3:
            goToGame(level: cell?.level, boardSize: difficulties["hard"], color: cell?.color)
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
