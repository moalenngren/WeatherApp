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
        self.favCellSetUp = []
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
      //  setCellValues()
       // print("ViewWILLAppear: RELOADS")
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


        /* TESTING TESTING TESTING TESTING TESTING TESTING TESTING TESTING TESTING TESTING
        searchForHits(searchType: "weather?id=", searchString: favArray[indexPath.row]["id"], tableView: nil, function: {
            
          // här körs när den är klar!
          //  favArray[indexPath.row]["location"] = "\(idResponse.name), \(idResponse.sys.country)"
          //  self.locationString.append("\(idResponse.name), \(idResponse.sys.country)") //Delete this one??
          //  print("Adds \(String(describing: favArray[indexPath.row]["location"])) to location")
            
            
            cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png")
            cell.favCellCity.text = favArray[indexPath.row]["name"]
            cell.favCellCountry.text = "\(idResponse.name), \(idResponse.sys.country)"
           // cell.favCellCountry.text = favArray[indexPath.row]["location"]
            cell.favCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
            cell.favCellWind.text = String(format: "%.1f m / s", idResponse.wind["speed"]!)
            
            //Test for getting the correct info when clicking a row
            let setUp = ["image" : "\(getWeatherPhoto(weather: favResult[indexPath.row].weather[0].icon)).png",
                "city" : favArray[indexPath.row]["name"]!,
                "country" : "\(favResult[indexPath.row].name), \(favResult[indexPath.row].sys.country)",
                "degrees" : String(format: "%.1f °C", favResult[indexPath.row].main["temp"]!),
                "wind" : String(format: "%.1f m / s", favResult[indexPath.row].wind["speed"]!),
                "id" : "\(favResult[indexPath.row].id)"]
            
            self.favCellSetUp.append(setUp)
                 print("The cell set up: ", self.favCellSetUp[indexPath.row])
            
        }) */
        
        
        
        
        //TESTING TESTING
        if let safeString = favArray[indexPath.row]["id"]?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?id=\(safeString)&type=like&APPID=88a00eb1b4f10cb2a53e66a426a15110&units=metric") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
                print("Got response from server")
                if let actualError = error {
                    print(actualError)
                } else {
                    if let actualData = data {
                        
                        
                        let decoder = JSONDecoder()
                        
                        do {
                            idResponse = try decoder.decode(ListId.self, from: actualData)
                            //print(idResponse)
                            
                            DispatchQueue.main.async {
  
                                print("idResponse is finished")
                                searchResultMunicipalityStrings.append(idResponse.name)
                                //  print("searchMunicipalityStrings are: \(searchResultMunicipalityStrings)")
                                
                                cell.favCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png")
                                cell.favCellCity.text = favArray[indexPath.row]["name"]
                                cell.favCellCountry.text = "\(idResponse.name), \(idResponse.sys.country)"
                                // cell.favCellCountry.text = favArray[indexPath.row]["location"]
                                cell.favCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
                                cell.favCellWind.text = String(format: "%.1f m / s", idResponse.wind["speed"]!)
                                
                                //tableView.reloadData()
                                // function() // Det är klart!
                                // print("The search array: \(searchResult)")
                                
                                
                                let setUp = ["image" : "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png",
                                    "city" : favArray[indexPath.row]["name"]!,
                                    "country" : "\(idResponse.name), \(idResponse.sys.country)",
                                    "degrees" : String(format: "%.1f °C", idResponse.main["temp"]!),
                                    "wind" : String(format: "%.1f m / s", idResponse.wind["speed"]!),
                                    "id" : "\(idResponse.id)"]
                                
                                self.favCellSetUp.append(setUp)
                               // print("The cell set up: ", self.favCellSetUp[indexPath.row])
                                
                            }
                        } catch let e {
                            print("Error parsing json: \(e)")
                            if let jsonString = String(data: actualData, encoding: String.Encoding.utf8) {
                                print("Json string: \(jsonString)")
                            }
                            
                        }
                    } else {
                        print("Data was nil")
                    }
                }
            })
            task.resume()
            print("Sending request")
        }
        else {
            print("Incorrect URL")
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
            favCellSetUp.remove(at: indexPath.row)
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
            
            /*    //Old code, does not work when updating the rows in wrong order
            next.photoString = "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png"
            next.cityLabelString =  favArray[cell.cellIndex]["name"]!
           // next.countryLabelString = favArray[cell.cellIndex]["location"]!
            next.countryLabelString = "\(idResponse.name), \(idResponse.sys.country)"
            next.degreesLabelString = String(format: "%.1f °C", idResponse.main["temp"]!)
            next.windLabelString = String(format: "%.1f m / s", idResponse.wind["speed"]!)
            next.id = idResponse.id */
            print("Clicked row: \(cell.cellIndex)")
            print("The whole cell set up: ", self.favCellSetUp)
            print("Sends this info to detail: \(self.favCellSetUp[cell.cellIndex!])")
            
            next.cityLabelString = cell.favCellCity.text!
          //  next.photoString = cell.favCellImage.image
            next.countryLabelString = cell.favCellCountry.text!
            next.degreesLabelString = cell.favCellDegrees.text!
             next.windLabelString = cell.favCellWind.text!
            
            /*
            next.photoString = self.favCellSetUp[cell.cellIndex!]["image"]!
           next.cityLabelString =  self.favCellSetUp[cell.cellIndex!]["city"]!
            next.countryLabelString = self.favCellSetUp[cell.cellIndex!]["country"]!
            next.degreesLabelString = self.favCellSetUp[cell.cellIndex!]["degrees"]!
            next.windLabelString = self.favCellSetUp[cell.cellIndex!]["wind"]!
           // next.id = self.favCellSetUp[cell.cellIndex]["id"]!
            next.id = idResponse.id //Do something about this, make Int to String?? */
            }

    }
}
