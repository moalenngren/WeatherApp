//
//  SearchTableViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-16.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit
/*
struct Hit : Codable {
    let name : String
    let sys : [String : String]
}

struct WeatherResponse : Codable {
    let list : [Hit]
}

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController : UISearchController!
    var searchTest : [String] = [] //"Stockholm", "Gothenburg", "Skövde", "New York"
    var searchResult : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Find Location"
        
        definesPresentationContext = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    func downloadResults() {
        if let safeString = searchController.searchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
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
                            let weatherResponse = try decoder.decode(WeatherResponse.self, from: actualData)
                            print(weatherResponse)
                            
                            DispatchQueue.main.async {
                              /*  for index in weatherResponse {
                                    for (key, value) in index {
                                        if key == "title" {
                                            self.searchTest.append(value)
                                        }
                                    }
                                } */
                                
                                
                                self.searchTest.append(weatherResponse.list[0].name)
                            //  self.resultTextView.text = duckResponse.RelatedTopics[0].Text
                                
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
       // searchController.searchBar.becomeFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if searchController.searchBar.text!.count >= 10 {
        downloadResults()
        
        if let text = searchController.searchBar.text?.lowercased() {
            searchResult = searchTest.filter({ $0.lowercased().contains(text) })
            print("filtered")
            
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    }
    
    var shouldUseSearchResult : Bool {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                return false
            } else {
                return searchController.isActive
            }
        } else {
            return false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if shouldUseSearchResult {
                return searchResult.count
            } else {
                return searchTest.count
            }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath)

        let array : [String]
        
        if shouldUseSearchResult {
            array = searchResult
        } else {
            array = searchTest
        }
        cell.textLabel?.text = array[indexPath.row]
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

} */
