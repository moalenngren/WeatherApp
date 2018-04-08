//
//  SearchTableViewCell.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-19.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var searchCellLabel: UILabel!
    
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
