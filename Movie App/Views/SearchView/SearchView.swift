//
//  SearchView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @EnvironmentObject private var root: RootViewModel
    private var gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20),
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20)
    ]
    
    var body: some View {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                // MARK: Content Search Bar
                VStack(spacing: 25) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        TextField("Search Movies or Series", text: $viewModel.searchContent)
                            .foregroundColor(.primary)
                            .font(.subheadline)
                            .onSubmit {}
                            .submitLabel(.search)
                        
                    }
                    .padding(.horizontal, 13)
                    .frame(height: 43)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 0.5).opacity(0.5))
                    .background(Color.replacement)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 4)
                    
                    
                    // MARK: Posters ScrollView
                    
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .preferredColorScheme(.dark)
            .environmentObject(RootViewModel())
    }
}
