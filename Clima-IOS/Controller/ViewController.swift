//
//  ViewController.swift
//  Clima-IOS
//
//  Created by Barry on 4/9/20.
//  Copyright © 2020 Barry. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManger();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self;
    }


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

