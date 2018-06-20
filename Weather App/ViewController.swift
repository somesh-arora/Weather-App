//
//  ViewController.swift
//  Weather App
//
//  Created by Somesh Arora on 6/20/18.
//  Copyright © 2018 Somesh Arora. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    let forecastAPIKey = "43a68eb0e80b803fe4e058098f2bd7c7"
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.4233)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let forecastService = ForecaseService(APIKey: forecastAPIKey)
        forecastService.getForecast(latitude: coordinate.lat, longitude: coordinate.long) { (currentWeather) in
            if let currentWeather = currentWeather
            {
                DispatchQueue.main.async
                {
                    if let temperature = currentWeather.temperature
                    {
                        self.temperatureLabel.text = "\(temperature)"
                    }
                    else
                    {
                        self.temperatureLabel.text = "-"
                    }
                    if let summary = currentWeather.summary
                    {
                        self.summaryLabel.text = "\(summary)"
                    }
                    else
                    {
                        self.summaryLabel.text = "-"
                    }
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

