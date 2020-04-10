//
//  WeatherData.swift
//  Clima-IOS
//
//  Created by Barry on 4/10/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import Foundation

struct WeatherData : Decodable {
    let name : String;
    let main : Main;
    let weather : [Weather];
}

struct Main : Decodable {
    let temp : Double;
}
