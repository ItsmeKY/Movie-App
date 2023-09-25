//
//  DetailsViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

final class DetailsViewModel: ObservableObject {
    // TODO: For now keep it a variable
    @Published var isFavorite: Bool = false
    
    var genres: [String] = ["Action", "Drama", "Sci-fi", "Superhero"]
    
}
