//
//  SentMemesTableViewCell.swift
//  MemeMe1.0
//
//  Created by Celia Gómez de Villavedón on 19/4/17.
//  Copyright © 2017 Celia Gómez de Villavedón Pedrosa. All rights reserved.
//

import UIKit

class SentMemesTableViewCell: UITableViewCell {
    
    class SentMemesTableViewCell: UITableViewCell {
        
        @IBOutlet weak var topTextLabel: UILabel!
        @IBOutlet weak var bottomTextLabel: UILabel!
        @IBOutlet weak var memeTextLabel: UILabel!
        @IBOutlet weak var memeDataLabel: UILabel!
        @IBOutlet weak var imageTableView: UIImageView!
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
