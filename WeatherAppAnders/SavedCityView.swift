//
//  SavedCityView.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import SwiftUI

struct SavedCityView: View {
    
    let saved: Saved
    
    var body: some View {
        
        LazyVStack {
            
            IconView(url: saved.city)
            
            HStack {
                
                Text(saved.city?.name ?? "--")
                    .font(.system(size: 16, weight: .semibold))
                
                Image(systemName: "location.fill")
            }
            
            Text(saved.city?.temperature ?? "--")
                .font(.system(size: 72, weight: .semibold))
            
            HStack {
                
                conditionView("Humidity", value: saved.city?.humidity)
                
                Spacer()
                
                conditionView("UV", value: saved.city?.uv)
                
                Spacer()
                
                conditionView("Feels Like", value: saved.city?.feelsLike)
            }
            .roundedBackground(8)
            .padding()
        }
    }
    
    private func conditionView(_ name: String, value: String?) -> some View {
        VStack(spacing: 8) {
            
            Text(name)
                .font(.system(size: 14))
                .foregroundStyle(.tertiary)
            
            Text(value ?? "--")
                .font(.system(size: 20, weight: .heavy))
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SavedCityView(saved: .init())
}
