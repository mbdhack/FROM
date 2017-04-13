//
//  ScoreTableViewCell.swift
//  From
//
//  Created by Mac user on 3/23/17.
//  Copyright © 2017 Mac user. All rights reserved.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {

    
    @IBOutlet weak var idLAbel: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var score: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
