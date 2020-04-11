//
//  ViewController.swift
//  Clima-IOS
//
//  Created by Barry on 4/9/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
   
    
    var weatherManager = WeatherManger();
    var locationManager = CLLocationManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self;
        locationManager.requestWhenInUseAuthorization();
        locationManager.requestLocation();
        
        
        weatherManager.delegate = self;
        searchTextField.delegate = self;
    }
}

// MARK: - UITextFieldDelegate

extension WeatherViewController : UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
            searchTextField.endEditing(true);
    //        searchTextField.text =
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true);
            
            return true;
        }
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if(textField.text != ""){
                return true;
            }
            textField.placeholder = "Type something";
            return false;
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            
            if let city = searchTextField.text {
                weatherManager.fetchWeather(cityName: city);
            }
            
            searchTextField.text = "";
        }
    
}

// MARK: - WeatherMangerDelegate

extension WeatherViewController : WeatherMangerDelegate {
    
    func didUpdateWeather(_ weatherManager : WeatherManger, weather : WeatherModel){
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString;
            self.conditionImageView.image = UIImage(systemName: weather.conditionName);
            self.cityLabel.text = weather.cityName;
        }
    }
    
    func didFailWithError(error: Error) {
        print(error);
    }
    
}

// MARK: - LocationManagerDelegate
extension WeatherViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation();
            
            
            let lat = location.coordinate.latitude;
            let long = location.coordinate.longitude;
            weatherManager.fetchWeather(latitude: lat, longtitude: long);
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription);
    }
    
    @IBAction func updateLocationBtn(_ sender: UIButton) {
        locationManager.requestLocation();
       }
}
