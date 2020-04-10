//
//  WeatherManager.swift
//  Clima-IOS
//
//  Created by Barry on 4/10/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import Foundation

struct WeatherManger {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=cadf6abe191b7d028e7f0372b0373bd7&units=metric";
    
    func fetchWeather (cityName : String){
        let urlStr = "\(weatherUrl)&q=\(cityName)";
    
        performRequest(urlStr: urlStr);
    }
    
    func performRequest(urlStr : String){
        
        if let url = URL(string: urlStr){
            let session = URLSession(configuration: .default);
            
            let task = session.dataTask(with: url,completionHandler: handle(data:response:error:));
            
            task.resume();
        }
    }
    
    func handle(data: Data?,response : URLResponse?, error : Error?){
        if(error != nil){
            print(error!);
            return;
        }
        
        if let safeData = data {
            let dataString = String(data: safeData, encoding: .utf8);
            
            print(dataString);
        }
    }
}
