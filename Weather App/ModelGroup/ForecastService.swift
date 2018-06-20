//
//  ForecastService.swift
//  Weather App
//
//  Created by Somesh Arora on 6/20/18.
//  Copyright © 2018 Somesh Arora. All rights reserved.
//

import Foundation


class ForecaseService
{
    let forecastAPIKey: String
    let forecastBaseURL:  URL?
    
    // forecaseBaseURL/forecaseAPIKey/latitude, longitude
    
    init(APIKey: String)
    {
        self.forecastAPIKey = APIKey
        forecastBaseURL = URL(string: "https://api.darksky.net/forecast/\(APIKey)")
    }
    
    func getForecast(latitude: Double, longitude: Double, completion: @escaping (CurrentWeather?) -> Void)
    {
        if let forecastURL = URL(string: "\(forecastBaseURL!)/\(latitude),\(longitude)")
        {
            let network = Network(url: forecastURL)
            network.downloadJSONFromURL (_completion: { (jsonDictionary) in
                
                if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: Any]
                {
                    let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
                    completion(currentWeather)
                }
                else
                {
                    completion(nil)
                }
            })
        }
    }
}
