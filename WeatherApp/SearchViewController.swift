//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-19.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

/*
struct Hit : Codable {
    let name : String
    let sys : [String : String]
    let main : [String : Float]
}

struct WeatherResponse : Codable {
    let count : Int
    let list : [Hit]

} */

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
   
  //  var index = 0
    
   // var searchResult : [String] = []
  // var weatherResponse = WeatherResponse(count: 0, list: [Hit(name: "", sys: ["" : ""], main: ["" : 0.0])])
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("getWeatherResponse().count = \(getWeatherResponse().count)")
        return getWeatherResponse().count
    }
   
    @IBAction func searchButtonClicked(_ sender: Any) {
        createURL()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // self.index = indexPath.row
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        
        cell.searchCellLabel.text = searchResult[indexPath.row]
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createURL() {
       // self.searchResult = [] //RESET!!!!!!
       // if let safeString = searchField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
         //   let url = URL(string: "http://api.openweathermap.org/data/2.5/find?q=\(safeString)&type=like&APPID=3f4234d2c39ddeec6a596ebd592b0a3f&units=metric") {
        searchForHits(searchString: self.searchField.text, searchTableView: searchTableView)
           // self.weatherResponse = WeatherResponse.getWeatherResponse()
     //   } else {
      //      print("Incorrect URL")
      //  }
        searchTableView.reloadData()
    }
    
    /*
    func searchForHits() {
        self.searchResult = []
        if let safeString = searchField.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: "http://api.openweathermap.org/data/2.5/find?q=\(safeString)&type=like&APPID=3f4234d2c39ddeec6a596ebd592b0a3f&units=metric") {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
                print("Got response from server")
                if let actualError = error {
                    print(actualError)
                } else {
                    if let actualData = data {
                        
                        let decoder = JSONDecoder()
                        
                        do {
                           // let weatherResponse = try decoder.decode(WeatherResponse.self, from: actualData)
                             self.weatherResponse = try decoder.decode(WeatherResponse.self, from: actualData)
                            print(self.weatherResponse)
                            
                            DispatchQueue.main.async {
                                
                                for x in 0..<self.weatherResponse.count {
                                self.searchResult.append(self.weatherResponse.list[x].name + ", " + self.weatherResponse.list[x].sys["country"]!)
                                }
                                print("Count is: \(self.weatherResponse.count)")
                            
                                self.searchTableView.reloadData()
                                print("The search array: \(self.searchResult)")
                                
                            }
                        } catch let e {
                            print("Error parson json: \(e)")
                        }
                    } else {
                        print("Data was nil")
                    }
                }
            })
            task.resume()
            print("Sending request")
        } else {
            print("Incorrect URL")
        }
    } */
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Detail" {
            let next : DetailViewController = segue.destination as! DetailViewController
                    let index = self.searchTableView.indexPathForSelectedRow
                    next.cityLabelString = getCityName(index: 0)
                    next.countryLabelString = getCountry(index: 0)
                    next.degreesLabelString = getDegrees(index: 0)
                    next.windLabelString = getWind(index: 0)
                    next.photoString = "Sun_App.jpg"
            
        }
    }

}
