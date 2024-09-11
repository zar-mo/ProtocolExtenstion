//
//  CountryCell.swift
//  ProtocolExtenstion
//
//  Created by Abouzar Moradian on 9/10/24.
//

import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    static let identifier: String = "CountryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
