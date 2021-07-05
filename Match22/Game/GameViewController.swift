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
    var score: Double = 0.0
    var difficulty = "Random"
    var theme = ""
    var color: UIColor? = .gray
    var startingTime: Date = Date()
    var timer: Timer?
    var matchedPairs = 0
    var id: Int = 0
    var imagePath = ""
    
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
        
        
        StorageManager.shared.exists(theme: theme, reqNumOfPics: numberOfRows*numberOfColumns/2, completion: {
            success in
            self.imagePath = "pictures/%@.png"
            if(success){
                self.imagePath = "themes/\(self.theme)/%@.jpeg"
            }
            self.collectionView.reloadData()
        })
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
        var levels = LoginManager.shared.userData?.levelsDone ?? [LevelDone]()
        var idToDelete = -1
        var levelFound = false
        var player = LoginManager.shared.userData
        
        if player?.bestScore == nil {
            player?.bestScore = self.score
            player?.bestTime = self.timerLabel.text
            player?.bestLevel = self.id
        }
        
        
        
        for (index, level) in levels.enumerated() {
            if level.id == self.id && level.score < self.score{
                idToDelete = index
            }
            if self.id == level.id {
                levelFound = true
            }
            if player?.bestScore ?? -Double.infinity < self.score {
                player?.bestScore = self.score
                player?.bestTime = self.timerLabel.text
                player?.bestLevel = self.id
            }
        }
        var newLevel = LevelDone()
        newLevel.id = id
        newLevel.score = score
        newLevel.time = timerLabel.text ?? ""
        
        
        if idToDelete != -1{
            levels.remove(at: idToDelete)
            levels.append(newLevel)
        }
        if(!levelFound){
            levels.append(newLevel)
        }
        
        
        player?.levelsDone = levels
        do{
            let playerData = try JSONEncoder().encode(player)
            let playerDictionary = try JSONSerialization.jsonObject(with: playerData, options: []) as! NSDictionary
            DatabaseManager.shared.saveUser(data: playerDictionary, object: player)
        }
        catch{
            print(error)
        }
        let dialogMessage = UIAlertController(title: "Felicitari!", message: "Ai terminat nivelul in " + (self.timerLabel.text ?? "" ) + " si cu scorul: \(self.score)", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
          })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
        
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
        let path = String.init(format: imagePath, "\(cell.matchNumber)")
        StorageManager.shared.getImage(name: path, completion: {
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
                        self.timer?.invalidate()
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
