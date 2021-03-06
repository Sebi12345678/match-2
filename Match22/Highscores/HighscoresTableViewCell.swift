//
//  HighscoresTableViewCell.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

class HighscoresTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerLevelLabel: UILabel!
    @IBOutlet weak var playerTimeLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(player:Player, isCurent: Bool) {
        if(isCurent){
            contentView.backgroundColor = .yellow
        }
        playerNameLabel.text = player.name
        playerScoreLabel.text = String(player.bestScore ?? 0.0)
        playerLevelLabel.text = String(player.bestLevel ?? 0)
        playerTimeLabel.text = player.bestTime ?? "99:99"
    }
}
