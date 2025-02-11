//
//  SearchedCityView.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import SwiftUI

struct SearchedCityView: View {
    
    @Bindable var searched: Searched
    
    let actions: () -> Void
    
    var body: some View {
        
        if searched.city != nil {
            
            if searched.isLoading {
                
                ProgressView("Fetching City...")
                
            } else {
                
                LabeledContent {
                    
                    IconView(url: searched.city)
                    
                } label: {
                    
                    VStack(alignment: .leading) {
                        
                        Text(searched.city?.name ?? "--")
                            .font(.system(.subheadline, design: .default, weight: .bold))
                        
                        Text(searched.city?.temperature ?? "--")
                            .font(.system(size: 46, weight: .semibold))
                    }
                    .foregroundStyle(.black)
                }
                .roundedBackground()
                .contentShape(.rect)
                .onTapGesture { actions() }
            }
        }
    }
}

#Preview {
    SearchedCityView(searched: .init()) { }
        .padding(.horizontal)
}
