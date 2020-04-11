//
//  WeatherManager.swift
//  Clima-IOS
//
//  Created by Barry on 4/10/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import Foundation

protocol WeatherMangerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManger, weather : WeatherModel);
    func didFailWithError(error : Error);
}


struct WeatherManger {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=cadf6abe191b7d028e7f0372b0373bd7&units=metric";
    
    var delegate: WeatherMangerDelegate?;
    
    
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
            delegate?.didFailWithError(error: error!)
            return;
        }
        
        if let safeData = data {
            if let weather = self.parseJson(safeData){
                
                self.delegate?.didUpdateWeather(self,weather: weather)
                
            }
        }
    }
    
    func parseJson(_ weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder();
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData);
            
            let id = decodedData.weather[0].id;
            let temp = decodedData.main.temp;
            let name = decodedData.name;
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather;
        } catch  {
            delegate?.didFailWithError(error: error);
            return nil;
        }
    }
    
    
}
