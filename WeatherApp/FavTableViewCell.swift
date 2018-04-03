//
//  FavTableViewCell.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var favCellImage: UIImageView!
    @IBOutlet weak var favCellCity: UILabel!
    @IBOutlet weak var favCellCountry: UILabel!
    @IBOutlet weak var favCellWind: UILabel!
    @IBOutlet weak var favCellDegrees: UILabel!
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
