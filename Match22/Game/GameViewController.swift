//
//  GameViewController.swift
//  Match22
//
//  Created by VM on 11/21/20.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var difficultyLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    var numberOfColumns = 5
    var numberOfRows = 8
    var cellSpacing : CGFloat = 10
    var selectedCellsCount = 0
    var selectedCells = [IndexPath]()
    var matchNumbers = [Int]()
    var score = 0
    var difficulty = "Random"
    var color: UIColor? = .gray
    var startingTime: Date = Date()
    var timer: Timer?
    var matchedPairs = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        difficultyLabel.text = "Difficulty: " + difficulty
        
        scoreLabel.text = "Score: \(score)" 
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        let firstSequence = ([Int] (1...(numberOfColumns*numberOfRows)/2)).shuffled()
        let secondSequence = ([Int] (1...(numberOfColumns*numberOfRows)/2)).shuffled()
        matchNumbers.append(contentsOf: firstSequence)
        matchNumbers.append(contentsOf: secondSequence)
        matchNumbers.shuffle()
        print(matchNumbers)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime(){
        let timeString = timerLabel.text
        guard let timeArray = timeString?.split(separator: ":") else { return }
        var minutes = Int(timeArray[0]) ?? 0
        var seconds = Int(timeArray[1]) ?? 0
        seconds=seconds+1
        if seconds == 60{
            seconds = 0
            minutes = minutes + 1
        }
        let newTimeString = String(format: "%02d:%02d", minutes, seconds)
        timerLabel.text = newTimeString
    }
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    func finishLevel(){
        
        navigationController?.popViewController(animated: true)
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
        //"pictures/\(cell.matchNumber).png"
        print(cell.matchNumber)
        cell.backCardView.backgroundColor = color
        StorageManager.shared.getImage(name: "pictures/\(cell.matchNumber).png", completion: {
            image in cell.frontCardView.image = image
        })
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GameCollectionViewCell
        
        if(selectedCells.count == 1)
        {
            let firstCell = collectionView.cellForItem(at: selectedCells[0]) as? GameCollectionViewCell
            if(firstCell?.matchNumber == cell?.matchNumber && firstCell != cell)
            {
                matchedPairs = matchedPairs + 1
                firstCell?.willDisappear = true
                cell?.willDisappear = true
                score += 10
                scoreLabel.text = "Score: \(score)"
                selectedCells.removeAll()
                if(cell?.isRotated == false){
                    cell?.reveal()
                }
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0, execute: {cell?.disappear()
                    firstCell?.disappear()
                    if self.matchedPairs == self.numberOfColumns*self.numberOfRows/2 {
                        DispatchQueue.main.asyncAfter(deadline: .now()+3, execute: {self.finishLevel()})
                    }
                })
                return
            }
            else{
                score -= 1
                scoreLabel.text = "Score: \(score)"
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
