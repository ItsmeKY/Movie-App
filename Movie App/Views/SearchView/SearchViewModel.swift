//
//  SearchViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

final class SearchViewModel: ObservableObject {
    
    @Published var searchContent: String = ""
    
    @Published var presentDetailsView: Bool = false
    
    var gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20),
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20)
    ]
    
    func accessPosterView() {
        withAnimation {
            self.presentDetailsView = true
        }
    }
}
