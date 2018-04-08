//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

var defaults = UserDefaults.standard
var favArray : [[String : String]] = []
var recentArray : [[String : String]] = []
var searchResult : [String] = []
var weatherResponse = WeatherResponse(count: 0, list: [List(name: "",
                                                            id: 0,
                                                            sys: ["" : ""],
                                                            main: ["" : 0.0],
                                                            wind: ["" : 0.0],
                                                            weather: [Weather(
                                                                description: "",
                                                                icon: "")])])

var idResponse = ListId(name: "",
                      id: 0,
                      sys: Sys(country: "", sunrise: 0, sunset: 0),
                      main: ["" : 0.0],
                      wind: ["" : 0.0],
                      weather: [Weather(
                        description: "",
                        icon: "")])

struct Weather : Codable {
    let description : String
    let icon : String
}

struct List : Codable {
    let name : String
    let id : Int
    let sys : [String : String]
    let main : [String : Float]
    let wind : [String : Float]
    let weather : [Weather]
}

struct WeatherResponse : Codable {
    let count : Int
    let list : [List]
}

struct Sys : Codable {
    let country : String
    let sunrise : Int
    let sunset : Int
}

struct ListId : Codable {
    let name : String
    let id : Int
    let sys : Sys
    let main : [String : Float]
    let wind : [String : Float]
    let weather : [Weather]
}
        
func searchForHits(searchType: String, searchString: String?, tableView : UITableView?, function: @escaping () -> ()) {
    searchResult = []
    
    if let safeString = searchString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
    let url = URL(string: "http://api.openweathermap.org/data/2.5/\(searchType)\(safeString)&type=like&APPID=88a00eb1b4f10cb2a53e66a426a15110&units=metric") {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in
            print("Got response from server")
            
            if let actualError = error {
                print(actualError)
            } else {
                if let actualData = data {
                    let decoder = JSONDecoder()
                    
                    do {
                        if searchType == "find?q=" {
                            weatherResponse = try decoder.decode(WeatherResponse.self, from: actualData)
                          //print(weatherResponse)
                        } else {
                            idResponse = try decoder.decode(ListId.self, from: actualData)
                          //print(idResponse)
                        }
                        
                        DispatchQueue.main.async {
                            if searchType == "find?q=" {
                                for x in 0..<weatherResponse.count {
                                    searchResult.append(weatherResponse.list[x].name + ", " + weatherResponse.list[x].sys["country"]!)
                                }
                                if tableView != nil {
                                    tableView?.reloadData()
                                }
                            } else {
                                print("idResponse is finished")
                            }
                            function()
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
}

func getCityName(index: Int) -> String {
    return weatherResponse.list[index].name
}

func getCountry(index: Int) -> String {
   return weatherResponse.list[index].sys["country"]!
}

func getDegrees(index: Int) -> String {
    return String(format: "%.1f °C", weatherResponse.list[index].main["temp"]!)
}

func getWind(index: Int) -> String {
    return String(format: "%.1f m / s", weatherResponse.list[index].wind["speed"]!)
}

func saveFavouritesToUserDefaults(favArray : [[String:String]]) {
    defaults.set(favArray, forKey: "favourites")
}

func saveRecentsToDefaults(recentArray : [[String:String]]) {
    defaults.set(recentArray, forKey: "recents")
}

func loadFavouritesFromDefaults() {
    if let favourites = defaults.value(forKey: "favourites") as? [[String:String]] {
        favArray = favourites
    }
}

func loadRecentsFromDefaults() {
    if let recents = defaults.value(forKey: "recents") as? [[String:String]] {
        recentArray = recents
    } else {
        recentArray = []
    }
}

func getWeatherPhoto(weather : String) -> String {
    switch weather {
    case "01d":
        return "Sun_App"
    case "01n":
        return "Moon_App"
    case "02d", "03d", "04d":
        return "SunCloudy_App"
    case "02n", "03n", "04n":
        return "MoonCloudy_App"
    case "09d", "10d", "09n", "10n":
        return "RainCloudy_App"
    case "11d", "11n":
        return "ThunderCloudy_App"
    case "13d", "13n":
        return "SnowCloudy_App"
    case "50d", "50n":
        return "Misty_App"
    default:
        return "NoImage"
    }
}

func getWeatherString(index: Int) -> String {
    return "\(weatherResponse.list[index].weather[0].icon)"
}



