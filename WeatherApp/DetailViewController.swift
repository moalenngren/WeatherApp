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
    @IBOutlet weak var recommendationText: UITextView!
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeButtonLabel()
        calculateRecommendation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func changeButtonLabel() {
        if favArray.contains(where: {$0 == ["name": cityLabelString, "id": String(id)]}) {
            addButton.setTitle("Remove Favourite", for: .normal)
            print("Item is a favourite, changes label to Remove From Favourites")
        } else {
            addButton.setTitle("Add To Favourites", for: .normal)
            print("Item is not favourite, changes label to Add To Favourites")
        }
    }
    
    //Move this content to Model?????
    @IBAction func addToFavourites(_ sender: UIButton) {
        if favArray.contains(where: {$0 == ["name": cityLabelString, "id": String(id)]}) {
            favArray = favArray.filter() {$0 != ["name": cityLabelString, "id": String(id)]}
            print("Removes from favourites, the favArray is now: \(favArray)")
        } else {
            favArray.append(["name" : cityLabelString, "id": String(id)])
            print("Adds name + id to favourites, the favArray is now: \(favArray)")
        }
        saveFavouritesToUserDefaults(favArray : favArray)
       changeButtonLabel()
    }
    
    func calculateRecommendation() {
        var string : String
        
        switch photoString {
        case "01d":
            string = "It's sunny today"
        default:
            string = "No recommendations for you today"
        }
        self.recommendationText.text = string
        
    }
}

