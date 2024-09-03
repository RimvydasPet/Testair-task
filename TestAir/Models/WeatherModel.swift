//
//  WeatherModel.swift
//  TestAir
//
//  Created by Rimvydas on 2024-08-31.
//


import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let icon: String
    let description: String
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    var dt: Int?
    var date: Date? {
        guard let dt = dt else { return nil }
        return Date(timeIntervalSince1970: TimeInterval(dt))
    }
    var formattedDate: String? {
        guard let date = date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE\ndd"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
}

