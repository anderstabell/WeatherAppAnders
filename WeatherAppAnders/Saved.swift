//
//  Saved.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import Foundation
import Observation

@Observable final class Saved {
    
    var city: City?
    
    func load(_ location: String) {
        
        guard let url = City.url(location) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                if let error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data else {
                    print("No data received")
                    return
                }
                
                do {
                    
                    let decoder = JSONDecoder()
                    self.city = try decoder.decode(City.self, from: data)
                    
                } catch {
                    
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }
        .resume()
    }
}
