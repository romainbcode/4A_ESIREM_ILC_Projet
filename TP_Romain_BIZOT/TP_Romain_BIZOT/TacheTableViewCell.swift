//
//  TacheTableViewCell.swift
//  TP_Romain_BIZOT
//
//  Created by Romain Bizot on 07/11/2022.
//

import UIKit

class TacheTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var dateTache: UILabel!
    //@IBOutlet weak var BoutonTache: UIButton!
    @IBOutlet weak var NomTache: UILabel!
    @IBOutlet weak var etatTache: UIImageView!
}
