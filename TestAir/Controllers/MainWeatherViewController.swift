//
//  WeatherViewController.swift
//  TestAir
//
//  Created by Rimvydas on 2024-08-31.
//

import UIKit

class MainWeatherViewController: UIViewController {
    
    enum WeatherAppError: LocalizedError {
        case networkError
        case parsingError
        case unknownError
        case customError(message: String)
        
        var errorDescription: String? {
            switch self {
            case .networkError:
                return "Network error occurred. Please check your internet connection."
            case .parsingError:
                return "Failed to parse the weather data."
            case .unknownError:
                return "An unknown error occurred."
            case .customError(let message):
                return message
            }
        }
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    @IBAction func historyButtonPressed(_ sender: Any) {
        goToListview(forHistory: true)
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    private func goToListview(forHistory showHistory: Bool, withModel weatherData: WeatherModel? = nil) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let destinationVC = storyboard.instantiateViewController(withIdentifier: "WeatherListViewController") as? WeatherListViewController {
            destinationVC.weatherManager = weatherManager
            destinationVC.showHistory = showHistory
            destinationVC.weatherData = weatherData
            navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
    
    private func getWeather(forCity cityName: String) {
        weatherManager.fetchWeather(cityName: cityName) { weatherData, error in
            DispatchQueue.main.async {
                self.searchTextField.text = ""
                
                if let error = error {
                    // Handle the error by creating a custom error with a message
                    let customError = WeatherAppError.customError(message: error.localizedDescription)
                    self.displayError(customError)
                } else if let weatherData = weatherData {
                    // If no error, proceed with the weather data
                    self.goToListview(forHistory: false, withModel: weatherData)
                } else {
                    // Handle unexpected case where both weatherData and error are nil
                    let unknownError = WeatherAppError.unknownError
                    self.displayError(unknownError)
                }
            }
        }
    }

    // Example function to display the error
    private func displayError(_ error: WeatherAppError) {
        let alertController = UIAlertController(title: "Error", message: error.errorDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: - UITextFieldDelegate
extension MainWeatherViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let cityName = searchTextField.text, cityName != "" {
            getWeather(forCity: cityName)
        }
    }
}
