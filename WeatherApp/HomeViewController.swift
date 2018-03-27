//
//  FirstViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-15.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let imageArrayTest = ["Sun_App", "SunCloudy_App", "RainCloudy_App", "ThunderCloudy_App", "SnowCloudy_App"]
    let cityArrayTest = ["Stockholm", "Gothenburg", "Skövde", "Lerdala", "New York"]
    let countryArrayTest = ["Sweden", "Sweden", "Sweden", "Sweden", "USA"]
    let degreeArrayTest = ["+3°", "-1°", "-10°", "-13°", "+5°"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArrayTest.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       /* if section == 0 {
            return "Recent"
        } */
        return "Recent Searches"
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        cell.homeCellImage.image = UIImage(named: imageArrayTest[indexPath.row]+".png")
        cell.homeCellCity.text = cityArrayTest[indexPath.row]
        cell.homeCellCountry.text = countryArrayTest[indexPath.row]
        cell.homeCellDegrees.text = degreeArrayTest[indexPath.row]
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }
    
    // func when rows are clicked = opens detail view
    // func when no places are searched for is empty = set header to popular places
    // and if not, set to recent searches
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }


}

