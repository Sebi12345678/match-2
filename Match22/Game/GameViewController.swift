//
//  GameViewController.swift
//  Match22
//
//  Created by VM on 11/21/20.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var numberOfColumns = 5
    var numberOfRows = 8
    var cellSpacing : CGFloat = 10
    var selectedCellsCount = 0
    var selectedCells = [IndexPath]()
    var matchNumbers = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        let firstSequence = ([Int] (1...(numberOfColumns*numberOfRows)/2)).shuffled()
        let secondSequence = ([Int] (1...(numberOfColumns*numberOfRows)/2)).shuffled()
        matchNumbers.append(contentsOf: firstSequence)
        matchNumbers.append(contentsOf: secondSequence)
        matchNumbers.shuffle()
        print(matchNumbers)
    }
}
extension GameViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfColumns * numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCollectionViewCell", for: indexPath) as! GameCollectionViewCell
        //cell.contentView.backgroundColor = UIColor.cyan
        cell.matchNumber = matchNumbers[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell
        
        if(selectedCells.count == 1)
        {
            let firstCell = collectionView.cellForItem(at: selectedCells[0]) as? GameCollectionViewCell
            if(firstCell?.matchNumber == cell?.matchNumber && firstCell != cell)
            {
                print("felicitari ai castigat un televizor pe lampa de gaz")
            }
        }
        if(selectedCells.count == 2)
        {
            let firstCell = collectionView.cellForItem(at: selectedCells[0]) as? GameCollectionViewCell
            firstCell?.reveal()
            let secondCell = collectionView.cellForItem(at: selectedCells[1]) as? GameCollectionViewCell
            secondCell?.reveal()
            selectedCells.removeAll()
        }
        else{
            if(cell?.isRotated == false){
                cell?.reveal()
                selectedCells.append(indexPath)
            }
        }
        //cell?.contentView.backgroundColor = UIColor.black
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 10, height: 10)
        let spacingWidth : CGFloat = cellSpacing * (CGFloat (numberOfColumns) + 1.0)
        let widthLeft = collectionView.frame.width - spacingWidth
        let cellWidth = widthLeft/CGFloat(numberOfColumns)
        
        let spacingHeight : CGFloat = cellSpacing * (CGFloat (numberOfRows) + 1.0)
        let heightLeft = collectionView.frame.height - spacingHeight
        let cellHeight = heightLeft/CGFloat(numberOfRows)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, insetForSectionAt: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing , bottom: cellSpacing, right: cellSpacing)
    }
    func collectionView(_: UICollectionView, layout: UICollectionViewLayout, minimumLineSpacingForSectionAt: Int) -> CGFloat {
        return cellSpacing
    }
}
