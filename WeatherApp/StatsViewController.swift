//
//  StatsViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-26.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit
import GraphKit 

class StatsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, GKBarGraphDataSource {
    
    @IBOutlet weak var diagram: GKBarGraph!
    @IBOutlet weak var picker1: UIPickerView!
    @IBOutlet weak var picker2: UIPickerView!
    
    var picker1Id = 0
    var picker2Id = 0
    
    var diagramTitles = ["Error", "Error", "Error", "Error", "Error", "Error"]
    var diagramColors = [UIColor.red, UIColor.red, UIColor.gray, UIColor.gray, UIColor.blue, UIColor.blue]
    var diagramValues = [0, 0, 0, 0, 0, 0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diagram.dataSource = self
        diagram.barHeight = 300
        diagram.barWidth = 40
       // diagram.draw()
        
        self.picker1.delegate = self
        self.picker1.dataSource = self
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadFavouritesFromDefaults()
        picker1.reloadAllComponents()
        picker2.reloadAllComponents()
    }
    
    func numberOfBars() -> Int {
        return 6
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        return diagramValues[index] as NSNumber
    }
    
    func titleForBar(at index: Int) -> String! {
        return diagramTitles[index]
    }
    
    func colorForBar(at index: Int) -> UIColor! {
        return diagramColors[index]
    }
    
    @IBAction func compareButton(_ sender: Any) {
        searchForHits(searchType: "weather?id=", searchString: favArray[picker1Id]["id"], tableView: nil, function: {
            self.diagramTitles[0] = "\(Int(idResponse.main["temp"]!.rounded()))°C"
            self.diagramValues[0] = Int(idResponse.main["temp"]!.rounded()) * 2
            self.diagramTitles[2] = "\(Int(idResponse.wind["speed"]!.rounded()))m/s" //WHY IS THIS NIL?????
            self.diagramValues[2] = Int(idResponse.wind["speed"]!) * 7
            self.diagramTitles[4] = "\(Int(idResponse.main["humidity"]!))%"
            self.diagramValues[4] = Int(idResponse.main["humidity"]!)
        
            searchForHits(searchType: "weather?id=", searchString: favArray[self.picker2Id]["id"], tableView: nil, function: {
               // self.diagramTitles[1] = (String(format: "%.1f°C", idResponse.main["temp"]!))
               // var number = idResponse.main["temp"]!
               // self.diagramTitles[1] = "\(number.rounded())°C"
                self.diagramTitles[1] = "\(Int(idResponse.main["temp"]!.rounded()))°C"
                self.diagramValues[1] = Int(idResponse.main["temp"]!.rounded()) * 2
                self.diagramTitles[3] = "\(Int(idResponse.wind["speed"]!.rounded()))m/s"
                self.diagramValues[3] = Int(idResponse.wind["speed"]!) * 7
                self.diagramTitles[5] = "\(Int(idResponse.main["humidity"]!))%"
                self.diagramValues[5] = Int(idResponse.main["humidity"]!)
                
                self.diagram.draw()
                print("compareButton Clicked, diagramTitles are now: \(self.diagramTitles)")
                print("compareButton Clicked, and diagramValues are now: \(self.diagramValues)")
            
            })
            
        })
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    // Catpure the picker view selection
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker1 {
            picker1Id = row
        }
        if pickerView == picker2 {
             picker2Id = row
        }
    }
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return favArray.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print("favArray is \(favArray)" )
        return favArray[row]["name"]
    }
    
    func drawRect() {

    }
}
