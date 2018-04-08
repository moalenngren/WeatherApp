//
//  FirstViewController.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-15.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var homeTableView: UITableView!
    
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var cloud2: UIImageView!
    @IBOutlet weak var cloud1: UIImageView!
    @IBOutlet weak var cloud3: UIImageView!
    @IBOutlet weak var sun: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    var dynamicAnimator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.bannerView)
        gravity = UIGravityBehavior(items: [logo])
        gravity.magnitude = 0.4
        collision = UICollisionBehavior(items: [logo])
        collision.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(gravity)
        dynamicAnimator.addBehavior(collision)
        
        UIView.animate(withDuration: 4.0, animations: ({
            self.sun.transform = CGAffineTransform(rotationAngle: 360)
        }))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRecentsFromDefaults()
        homeTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Recent Searches"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 74
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        
        cell.homeCellImage.image = nil
        cell.homeCellCity.text = ""
        cell.homeCellCountry.text = ""
        cell.homeCellDegrees.text = ""
        
        searchForHits(searchType: "weather?id=", searchString: recentArray[indexPath.row]["id"], tableView: nil, function: { 
            
        cell.homeCellImage.image = UIImage(named: "\(getWeatherPhoto(weather: idResponse.weather[0].icon)).png")
        cell.homeCellCity.text = recentArray[indexPath.row]["name"]!
        cell.homeCellCountry.text = "\(idResponse.name), \(idResponse.sys.country)"
        cell.homeCellDegrees.text = String(format: "%.1f °C", idResponse.main["temp"]!)
        cell.degreesValue = Int(idResponse.main["temp"]!.rounded())
        cell.windValue = idResponse.wind["speed"]! 
        cell.photoString = idResponse.weather[0].icon
        cell.id = idResponse.id
        })
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! HomeTableViewCell
        
        if segue.identifier == "Detail" {
            let next : DetailViewController = segue.destination as! DetailViewController
            
            next.cityLabelString = cell.homeCellCity.text!
            next.photoString = cell.photoString
            next.degreesLabelString = cell.homeCellDegrees.text!
            next.degreesValue = cell.degreesValue
            next.windLabelString = "\(Int(cell.windValue.rounded()))m/s" 
            next.countryLabelString = cell.homeCellCountry.text!
            next.id = cell.id
        }
    }
}

