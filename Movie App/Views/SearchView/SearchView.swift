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
                        
                        TextField("Search Movies or Series", text: $viewModel.searchedKeyword)
                            .foregroundColor(.primary)
                            .font(.subheadline)
                            .onSubmit { viewModel.loadContent() }
                            .submitLabel(.search)
                        
                    }
                    .padding(.horizontal, 13)
                    .frame(height: 43)
                    .background(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 0.5).opacity(0.5))
                    .background(Color.replacement)
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
                    
                    
                    // MARK: Posters ScrollView
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: gridColumn, spacing: 20) {
                            ForEach(viewModel.searchContent, id: \.id) { content in
                                PosterView(poster: content.poster,
                                           width: 167, height: 245, cornerRadius: 10)
                                    .onTapGesture { root.accessDetailsView(content) }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                
            }
            .edgesIgnoringSafeArea(.bottom)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
//            .preferredColorScheme(.dark)
            .environmentObject(RootViewModel())
    }
}
