//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by ITHS on 2018-03-18.
//  Copyright © 2018 MoaLenngren. All rights reserved.
//

import UIKit

//var favArray : [[String : Int]] = [[:]]
var favArray : [Int] = []
var searchResult : [String] = []
var weatherResponse = WeatherResponse(count: 0, list: [List(name: "",
                                                            id: 0,
                                                            sys: ["" : ""],
                                                            main: ["" : 0.0],
                                                            wind: ["" : 0.0],
                                                            weather: [Weather(
                                                                description: "",
                                                                icon: "")])])
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
        
func searchForHits(searchString: String?, searchTableView : UITableView) {
    searchResult = []
    weatherResponse = WeatherResponse(count: 0, list: [List(name: "",
                                                                id: 0,
                                                                sys: ["" : ""],
                                                                main: ["" : 0.0],
                                                                wind: ["" : 0.0],
                                                                weather: [Weather(
                                                                    description: "",
                                                                    icon: "")])])
    
    if let safeString = searchString?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
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
                        weatherResponse = try decoder.decode(WeatherResponse.self, from: actualData)
                        print(weatherResponse)
                        
                        DispatchQueue.main.async {
                            
                            for x in 0..<weatherResponse.count {
                                searchResult.append(weatherResponse.list[x].name + ", " + weatherResponse.list[x].sys["country"]!)
                            }
                            print("Count is: \(weatherResponse.count)")
                            
                            searchTableView.reloadData()
                            print("The search array: \(searchResult)")
                            
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
}
    else {
        print("Incorrect URL")
    }
}

func getWeatherResponse() -> WeatherResponse {
    return weatherResponse
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


//May not be useful. Change the names of the pics according to the json instead! And set image to WeatherModel.photo + ".png"
func getWeatherPhoto(weather : String) -> String {
    switch weather {
    case "01d", "01n":
        return "Sun_App"
    case "02d", "03d", "04d", "02n", "03n", "04n":
        return "SunCloudy_App"
    case "09d", "10d", "09n", "10n":
        return "RainCloudy_App"
    case "11d", "11n":
        return "ThunderCloudy_App"
    case "13d", "13n":
        return "SnowCloudy_App"
    case "50d", "50n":
        return "SunCloudy_App" //CHANGE TO MIST_APP
    default:
        return "NoImage"
    }
}

func getWeatherString(index: Int) -> String {
    return "\(getWeatherPhoto(weather: weatherResponse.list[index].weather[0].icon)).png"
}


