//
//  HighscoresViewController.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

class HighscoresViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var players = [Player]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .link
        tableView.delegate = self
        tableView.dataSource = self
        print("hingscore view did load")
        getPlayers()
        tableView.reloadData()
    }
    func getPlayers(){
        players.append(contentsOf: [Player(nume: "Gigel", scor: 72),
                       Player(nume: "Bob Bobinski", scor: 69),
                       Player(nume: "Jeff", scor: 420),
                       Player(nume: "Bobbe", scor: 30),
                       Player(nume: "Bobby", scor: 20),
                       Player(nume: "Bobert", scor: 10)]
        )
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
            cell.configureCell(player: players[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
}
