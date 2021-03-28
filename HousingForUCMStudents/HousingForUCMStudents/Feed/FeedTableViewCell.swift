//
//  FeedTableViewCell.swift
//  HousingForUCMStudents
//
//  Created by Brayam Corral on 3/21/21.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    @IBOutlet weak var houseImageView: UIImageView!
    @IBOutlet weak var houseAddressLabel: UILabel!
    @IBOutlet weak var houseRoomsLabel: UILabel!
    @IBOutlet weak var housePriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
