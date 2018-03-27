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
    
    override func viewDidAppear(_ animated: Bool) {
        searchField.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createURL() {
        searchResult = []
        searchForHits(searchType: "find?q=", searchString: self.searchField.text, tableView: searchTableView, function: {})
    }
    
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