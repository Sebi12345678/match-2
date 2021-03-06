//
//  HighscoresViewController.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit
import FirebaseDatabase

class HighscoresViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var players = [Player]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .link
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        print("hingscore view did load")
        getPlayers()
        
    }
    func getPlayers(){
        
        DatabaseManager.shared.getData(firstRef:"users", secondRef: nil, completion:{(dictionary, array) in
            guard let users = dictionary else{
                return
            }
            for user in users {
                if let userObject = user.value as? NSDictionary, let userId = user.key as? String{
                let bestScore = userObject["bestScore"] as? Double
                let bestLevel = userObject["bestLevel"] as? Int
                let bestTime = userObject["bestTime"] as? String
                let name = userObject["name"] as? String
                let player = Player(name: name ?? "", id: userId)
                    player.bestLevel = bestLevel
                    player.bestTime = bestTime
                    player.bestScore = bestScore
                    self.players.append(player)
                }
            }
            self.players.sort{$0.bestScore ?? 0 > $1.bestScore ?? 0}
            self.tableView.reloadData()
        })

    }
}
extension HighscoresViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("highscoretable view cell init before")
        if let cell = tableView.dequeueReusableCell(withIdentifier: "HighscoresTableViewCell") as? HighscoresTableViewCell{
        //return  HighscoresTableViewCell()
            print("hinghscore table cell init")
            if players[indexPath.row].id == LoginManager.shared.userId{
                cell.configureCell(player: players[indexPath.row], isCurent: true)
            }
            else {
                cell.configureCell(player: players[indexPath.row], isCurent: false)
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
