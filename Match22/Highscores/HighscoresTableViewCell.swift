//
//  HighscoresTableViewCell.swift
//  Match2
//
//  Created by VM on 10/16/20.
//

import UIKit

class HighscoresTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerScoreLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .cyan
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(player:Player) {
        playerNameLabel.text = player.name
        playerScoreLabel.text = String(player.score ?? 0.0)
    }
}
