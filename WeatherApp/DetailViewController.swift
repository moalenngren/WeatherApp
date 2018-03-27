//
//  DetailViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-20.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var addButton: UIButton!
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
    //var saveAs = ["":0]
    var cellIndex = 0
    var id = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = UIImage(named: photoString)
        cityLabel.text = cityLabelString
        countryLabel.text = countryLabelString
        degreesLabel.text = degreesLabelString
        windLabel.text = windLabelString
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeButtonLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeButtonLabel() {
        if favArray.contains(id)  {
            addButton.setTitle("Remove Favourite", for: .normal)
            print("Item is a favourite, changes label to Remove From Favourites")
        } else {
            addButton.setTitle("Add To Favourites", for: .normal)
            print("Item is not favourite, changes label to Add To Favourites")
        }
    }
    
    //Move this content to Model?????
    @IBAction func addToFavourites(_ sender: UIButton) {
       if favArray.contains(id) {
            favArray = favArray.filter() {$0 != id}
            print("Removes from favourites, the array is: \(favArray)")
        } else {
            favArray.append(id)
            print("Adds to favourites, the array is: \(favArray[0])")
        }
       changeButtonLabel()
    }
}

