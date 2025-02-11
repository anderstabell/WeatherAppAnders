//
//  MainView.swift
//  WeatherAppAnders
//
//  Created by Anders Tabell on 2/10/25.
//

import SwiftUI

struct MainView: View {
    
    /// Name of the saved city, if it exists.
    @AppStorage("selectedCity") private var selectedCityName: String?
    
    @State private var saved = Saved()
    @State private var search = Searched()
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                if showSavedCity {
                    
                    SavedCityView(saved: saved)
                    
                } else {
                    
                    if search.text.isEmpty {
                        
                        ContentUnavailableView(
                            "No City Selected",
                            systemImage: "",
                            description: Text("Please search for a city"))
                        .foregroundStyle(.primary)
                        
                    } else {
                        
                        SearchedCityView(searched: search) { update() }
                    }
                }
            }
            .padding()
        }
        .onAppear { loadSavedCity() }
        .onChange(of: saved.city) { selectedCityName = $1?.name }
        .safeAreaInset(edge: .top) {
            TextField(
                "Search",
                text: $search.text,
                prompt: Text("Search Location"))
            .roundedBackground()
            .onSubmit { search.search() }
            .overlay {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.tertiary)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.trailing)
            }
            .padding()
        }
    }
    
    private var showSavedCity: Bool {
        selectedCityName != nil && search.text.isEmpty
    }
    
    private func loadSavedCity() {
        guard let selectedCityName else { return }
        saved.load(selectedCityName)
    }
    
    private func update() {
        saved.city = search.city
        search.reset()
    }
}

#Preview {
    MainView()
}

extension View {
    
    func roundedBackground(_ cornerRadius: CGFloat = 16) -> some View {
        self
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(.rect(cornerRadius: cornerRadius))
    }
}
