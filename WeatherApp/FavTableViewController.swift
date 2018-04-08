//
//  FavTableViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    var locationString = [""]
    var favCellSetUp : [[String:String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        loadFavouritesFromDefaults()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavCell", for: indexPath) as! FavTableViewCell
        
        cell.cellIndex = indexPath.row
        cell.favCellImage.image = nil
        cell.favCellCity.text = ""
        cell.favCellCountry.text = ""
        cell.favCellDegrees.text = ""
        cell.favCellWind.text = ""
        
        searchForHits(searchType: "weather?id=", searchString: favArray[indexPath.row]["id"], tableView: nil, function: {
            
            cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png")
            cell.favCellCity.text = favArray[indexPath.row]["name"]!
            cell.favCellCountry.text = "\(idResponse.name), \(idResponse.sys.country)"
            cell.favCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
            cell.favCellWind.text = String(format: "%.1f m / s", idResponse.wind["speed"]!)
            cell.degreesValue = Int(idResponse.main["temp"]!.rounded())
            cell.photoString = idResponse.weather[0].icon
            cell.id = idResponse.id
        })
 
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            saveFavouritesToUserDefaults(favArray : favArray)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! FavTableViewCell
            
        if segue.identifier == "Detail" {
            let next : DetailViewController = segue.destination as! DetailViewController
            
            print("Clicked row: \(cell.cellIndex)")
            next.cityLabelString = cell.favCellCity.text!
            next.photoString = cell.photoString
            next.degreesLabelString = cell.favCellDegrees.text!
            next.degreesValue = cell.degreesValue
            next.windLabelString = cell.favCellWind.text!
            next.countryLabelString = cell.favCellCountry.text!
            next.id = cell.id!
        }
    }
}
