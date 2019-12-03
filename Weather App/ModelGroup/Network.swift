//
//  Network.swift
//  Weather App
//
//  Created by Somesh Arora on 6/20/18.
//  Copyright © 2018 Somesh Arora. All rights reserved.
//

import Foundation

class Network {
    typealias JSONDictionaryHandler = (([String : Any]?) -> Void)
    lazy var configuration: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configuration)
    let url: URL
    
    init(url : URL) {
        self.url = url
    }
    
    func downloadJSONFromURL(_completion: @escaping JSONDictionaryHandler) {
        let request = URLRequest(url: self.url)
        let datatask = session.dataTask(with: request) { (data, response, error) in
            if error == nil {
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        if let data = data {
                            do {
                                let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                _completion(jsonDictionary as? [String : Any])
                            }
                            catch let error as NSError {
                                print("Error processing the data: \(error.localizedDescription)")
                            }
                        }
                    default:
                        print("HTTP Response Code: \(httpResponse.statusCode)")
                    }
                }
            }
            else {
                print("Error: \(error?.localizedDescription ?? "Unknown Error")")
            }
        }
        datatask.resume()
    }
    
}
