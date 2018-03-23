//
//  SearchViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-19.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchField: UITextField!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getWeatherResponse().count
    }
   
    @IBAction func searchButtonClicked(_ sender: Any) {
        createURL()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchTableViewCell
        
        cell.cellIndex = indexPath.row
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
        searchResult = []
        searchForHits(searchString: self.searchField.text, searchTableView: searchTableView)
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
        let cell = sender as! SearchTableViewCell
        
        if segue.identifier == "Detail" {
            let next : DetailViewController = segue.destination as! DetailViewController
                    next.cityLabelString = getCityName(index: cell.cellIndex)
                    next.countryLabelString = getCountry(index: cell.cellIndex)
                    next.degreesLabelString = getDegrees(index: cell.cellIndex)
                    next.windLabelString = getWind(index: cell.cellIndex)
                    next.photoString = getWeatherString(index: cell.cellIndex)
                    next.cellIndex = cell.cellIndex
                    next.id = weatherResponse.list[cell.cellIndex].id 
        }
    }
}
