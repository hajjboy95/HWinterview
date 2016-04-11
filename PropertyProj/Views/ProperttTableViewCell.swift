//
//  PropertyTableViewCell.swift
//
//  Created by Ismail El-habbash on 4/9/16.
//  Copyright © 2016 Ismail El-Habbash. All rights reserved.
//

import UIKit

class PropertyTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
//    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var lowestPriceLabel: UILabel!
    @IBOutlet weak var overallRatingLabel: UILabel!
    @IBOutlet weak var hostelTypeLabel: UILabel!
    
    var cellInfo:Hostel? {
        didSet{
            
            titleLabel.text = cellInfo!.name
            hostelTypeLabel.text = cellInfo!.type
            lowestPriceLabel.text = "100"
            overallRatingLabel.text = "\(cellInfo!.overallRating)"
        }
    }
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
