//
//  FavTableViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
    var favData : [ListId?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavouritesFromDefaults()
        
        for x in favArray {
            print("APPENDING FROM FAVARRAY TO FAVDATA")
            favData.append(ListId(name: x["name"]!,
                                  id: Int(x["id"]!)!,
                                  sys: Sys(country: "", sunrise: 0, sunset: 0),
                                  main: ["temp" : 0.0],
                                  wind: ["speed" : 0.0],
                                  weather: [Weather(
                                    description: "",
                                    icon: "")]))
        }
        downloadData()
    }
    
    func downloadData() {
        for x in 0..<favArray.count {
            downloadWeather(searchString: favArray[x]["id"], tableView: tableView, function: { listId in
                self.favData[x] = listId
                self.tableView.reloadData()
            })
        }
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
        
        if let data = favData[indexPath.row] {
            cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: data.weather[0].icon)).png")
            cell.favCellCity.text = favArray[indexPath.row]["name"]!
            cell.favCellCountry.text = "\(data.name), \(data.sys.country)"
            cell.favCellDegrees.text = String(format: "%.1f °C", data.main["temp"]!)
            cell.favCellWind.text = String(format: "%.1f m / s", data.wind["speed"]!)
            cell.degreesValue = Int(data.main["temp"]!.rounded())
            cell.photoString = data.weather[0].icon
            cell.id = data.id
        }
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
            favData.remove(at: indexPath.row) //???
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            saveFavouritesToUserDefaults(favArray : favArray)
        } else if editingStyle == .insert {
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
