//
//  Searched.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import Foundation
import Observation

@Observable final class Searched {
    
    var city: City?
    
    var isLoading = false
    
    var text = ""
    
    func reset() {
        text = ""
        city = nil
    }
    
    func search() {
        
        isLoading = true
        
        guard let url = City.url(text) else {
            print("Invalid URL")
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                
                self.isLoading = false
                
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
