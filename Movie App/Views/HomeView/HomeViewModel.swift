//
//  HomeViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    // Write code
    @Published var selectedType: Int = 0
    @Published var categorySelected: String = "All"
    
    @Published var presentDetailsView: Bool = false
    
    var gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0)
    ]
    var categories: [String] = ["All", "Action", "Thriller", "Romantic", "Adventure"]
    
    func isCategorySelected(_ category: String) -> Binding<Bool> {
        Binding<Bool> {
            self.categorySelected == category
        } set: { isSelected in
            if isSelected { self.categorySelected = category }
        }
    }
    
    // TODO: param will take model info
    func accessPosterView() {
        withAnimation {
            self.presentDetailsView = true
        }
    }
}


