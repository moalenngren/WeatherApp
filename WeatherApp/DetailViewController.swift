//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-20.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var degreesLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel! 
    @IBOutlet weak var photo: UIImageView!
    var photoString = ""
    var cityLabelString = ""
    var countryLabelString = ""
    var degreesLabelString = ""
    var windLabelString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photo.image = UIImage(named: photoString)
        cityLabel.text = cityLabelString
        countryLabel.text = countryLabelString
        degreesLabel.text = degreesLabelString
        windLabel.text = windLabelString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
