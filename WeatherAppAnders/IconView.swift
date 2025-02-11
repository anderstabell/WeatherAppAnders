//
//  IconView.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import SwiftUI

struct IconView: View {
    
    let url: (any Iconable)?
    
    var body: some View {
        
        AsyncImage(url: url?.icon) { image in
            
            image
                .resizable()
                .scaledToFit()
                .frame(width: 128, height: 128)
            
        } placeholder: {
            
            ProgressView()
        }
    }
}

protocol Iconable: Decodable, Equatable {
    
    var icon: URL? { get }
}
