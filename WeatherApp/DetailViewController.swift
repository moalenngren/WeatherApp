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
    
   // ---- NEW VALUES ----
   // var photoString = ""
   // var cityLabelString = ""
   // var countryLabelString = ""
    var degreesValue = 0
    var windValue = 0
   // var cellIndex = 0
   // var id = 0
    
    
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
        var recString : String
        
        switch degreesValue {
        case -100 ... -15:
            recString = "It's freezing out there, don't forget to wear double långkalsonger!!!"
        case -14 ... 0:
            recString = "It's very cold outside, don't forget your långkalsoner!"
        case 1 ... 10:
            recString = "It's still pretty cold outside, you might still wanna use that scarf!"
        case 11 ... 20:
            recString = "It's quite warm outside, bring out your thin jacket!"
        case 21 ... 28:
            recString = "The weather is hot, you might wanna use those shorts!"
        case 29 ... 100:
            recString = "The weather is freaking super hot, you should go naked to survive!"
        default:
            recString = ""
        }
        
        var recString2 : String
        
        switch photoString {
        case "01d": //Sun
            recString2 = "Besides that, now's the time to look really cool in sunglasses."
        case "09d", "10d", "09n", "10n": //RainClody
            recString2 = "Besides that, if you don't wanna be soaked - an umbrella would be perfect today."
        case "11d", "11n": //ThunderCloudy
            recString2 = "Besides that, stay away from open spaces and lakes. There might be some thunder today "
        default:
            recString2 = ""
        }

        self.recommendationText.text = "\(recString) \(recString2)"
        
    }
}

