//
//  ViewControllerTableViewCell.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1610--2020.
//

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblVraag: UILabel!
    @IBOutlet weak var lblAntwoord1: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
