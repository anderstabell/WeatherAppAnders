//
//  City.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import Foundation
import CoreLocation
import Observation

@Observable final class City: Iconable {
    
    var name: String {
        location.name
    }
    
    var icon: URL? {
        URL(string: "https:\(current.condition.icon)")
    }
    
    var temperature: String {
        Int(current.temp_f).formatted() + "°"
    }
    
    var feelsLike: String {
        Int(current.feelslike_f).formatted() + "°"
    }
    
    var humidity: String {
        (Double(current.humidity) / 100).formatted(.percent)
    }
    
    var uv: String { current.uv.formatted() }
    
    private let location: Location
    private let current: Current
    
    private struct Location: Decodable {
        let name: String
    }
    
    private struct Current: Decodable {
        let temp_f: Double
        let condition: Condition
        let humidity: Int
        let feelslike_f: Double
        let uv: Double
    }
    
    private struct Condition: Decodable {
        let icon: String
    }
    
    static func == (lhs: City, rhs: City) -> Bool {
        lhs.name == rhs.name
    }
    
    /// - important: This should be stored on server side for security reasons
    private static let apiKey = "e21889c26acb4f51be8152551250702"
    
    static func url(_ location: String) -> URL? {
        guard let url = URL(string: "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(location)") else {
            print("Invalid URL")
            return nil
        }
        return url
    }
}
