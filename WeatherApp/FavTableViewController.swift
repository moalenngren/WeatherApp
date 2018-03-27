//
//  FavTableViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class FavTableViewController: UITableViewController {
    
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
        
        //WHY IS THIS LOOPING?!???!!?
        searchForHits(searchType: "weather?id=", searchString: String(favArray[indexPath.row]), tableView: self.tableView, function: {
            
          // här körs när den är klar!
            cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png") 
            cell.favCellCity.text = idResponse.name
            cell.favCellCountry.text = idResponse.sys.country
            cell.favCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
            
        })
        return cell
    }
    
    func setCellValues() {
        
    }
    
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
    //    searchForHits(searchType: "weather?id=", searchString: String(favArray[cell.cellIndex]), tableView: tableView, function: {
            
            if segue.identifier == "Detail" {
                let next : DetailViewController = segue.destination as! DetailViewController
            next.cityLabelString = idResponse.name
            next.countryLabelString = idResponse.sys.country
          //  next.countryLabelString = idResponse.sys[0].country
            next.degreesLabelString = String(format: "%.1f °C", idResponse.main["temp"]!)
            next.windLabelString = String(format: "%.1f m / s", idResponse.wind["speed"]!)
            next.photoString = "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png"
          //  next.cellIndex = cell.cellIndex
            next.id = Int(idResponse.id)
                
            }
      //  })
    }
}
