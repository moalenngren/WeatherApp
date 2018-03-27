//
//  HomeTableViewCell.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-15.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var homeCellImage: UIImageView!
    @IBOutlet weak var homeCellCity: UILabel!
    @IBOutlet weak var homeCellCountry: UILabel!
    @IBOutlet weak var homeCellDegrees: UILabel!
    var cellIndex : Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
