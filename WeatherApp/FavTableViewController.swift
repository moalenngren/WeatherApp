//
//  FavTableViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
  /*
    var favStructArray = [FavStruct]()
    var favStruct = FavStruct()
    
    struct FavStruct {
        var photo = ""
        var country = ""
        var city = ""
        var degrees = ""
        var wind = ""
        var id = 0
    }*/
    
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
      //  setCellValues()
        print("ViewWILLAppear: RELOADS")
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
        
        cell.favCellImage.image = nil
        cell.favCellCity.text = ""
        cell.favCellCountry.text = ""
        cell.favCellDegrees.text = ""
        
        searchForHits(searchType: "weather?id=", searchString: String(favArray[indexPath.row]), tableView: self.tableView, function: {
            
          // här körs när den är klar!
            cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png") 
            cell.favCellCity.text = idResponse.name
            cell.favCellCountry.text = idResponse.sys.country
            cell.favCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
            
        })
        
        print("cellForRowAt")
        
        /*
        cell.favCellImage.image = UIImage(named: favStructArray[indexPath.row].photo)
        cell.favCellCity.text = favStructArray[indexPath.row].city
        cell.favCellCountry.text = favStructArray[indexPath.row].country
        cell.favCellDegrees.text = favStructArray[indexPath.row].degrees */
        
        return cell
    }
    
    
    /*
    func setCellValues() {
        for x in favArray {
            print("setCellValues")
            searchForHits(searchType: "weather?id=", searchString: String(x), tableView: self.tableView, function: {
                
                print("Setting all cell values to struct from: \(idResponse)")
                self.favStruct.photo = "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png"
                self.favStruct.city = idResponse.name
                self.favStruct.country = idResponse.sys.country
                self.favStruct.degrees = String(format: "%.1f °C", idResponse.main["temp"]!)
                self.favStruct.wind = String(format: "%.1f m / s", idResponse.wind["speed"]!)
                self.favStruct.id = idResponse.id
                
                self.favStructArray.append(self.favStruct)
                print("FavStructArray contains: \(self.favStructArray)")
                
            })
        }
    } */
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 87
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
    //Change fav array here??????
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! FavTableViewCell
            
        if segue.identifier == "Detail" {
            let next : DetailViewController = segue.destination as! DetailViewController
            /*
                next.cityLabelString = favStructArray[cell.cellIndex].city
                next.countryLabelString = favStructArray[cell.cellIndex].country
                next.degreesLabelString = String(format: "%.1f °C", favStructArray[cell.cellIndex].degrees)
                next.windLabelString = String(format: "%.1f m / s", favStructArray[cell.cellIndex].wind)
                next.photoString = "\(getWeatherPhoto(weather: favStructArray[cell.cellIndex].photo)).png"
                next.id = Int(idResponse.id)
                */
            
           next.photoString = "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png"
            next.cityLabelString = idResponse.name
            next.countryLabelString = idResponse.sys.country
            next.degreesLabelString = String(format: "%.1f °C", idResponse.main["temp"]!)
             next.windLabelString = String(format: "%.1f m / s", idResponse.wind["speed"]!)
            next.id = idResponse.id
            }

    }
}
