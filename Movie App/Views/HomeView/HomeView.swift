//
//  ContentView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject private var root: RootViewModel
    
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                // MARK: Content Type
                HStack {
                    TypeText("Movies", type: .movie)
                    
                    Spacer().frame(width: 40)
                    
                    TypeText("Series", type: .series)
                }
                
                ScrollView(.vertical, showsIndicators: false)  {
                    VStack(spacing: 25) {
                        
                        //MARK: Carousel View
                        VStack(alignment: .leading) {
                            Text("Trending This Week")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.leading)
                            
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.contents, id: \.id) { content in
                                        if viewModel.contentInFilter(content.id, genreSpecific: false) {
                                            PosterView(poster: content.poster, width: 170, height: 250, cornerRadius: 10)
                                                .onTapGesture { root.accessDetailsView(content) }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Latest Movies")
                                .font(.subheadline)
                                .fontWeight(.bold)
                                .padding(.leading)
                            
                            // MARK: Content Categories
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(Array(viewModel.currentGenres), id: \.self) { genre in
                                        Toggle(isOn: viewModel.isGenreSelected(genre)) {
                                            Text(genre)
                                        }
                                        .toggleStyle(GenreToggleStyle())
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // MARK: Trending Movies Slider
                            LazyVGrid(columns: viewModel.gridColumn, spacing: 15) {
                                ForEach(viewModel.contents, id: \.id) { content in
                                    if viewModel.contentInFilter(content.id, genreSpecific: true) {
                                        PosterView(poster: content.poster, width: 111, height: 164, cornerRadius: 10)
                                            .onTapGesture { root.accessDetailsView(content) }
                                        
                                    }
                                }
                            }
                            .padding(.horizontal, 5)
                        }
                        
                        Spacer()
                    }
                }
            }

            
        }
    }
    
    @ViewBuilder
    private func TypeText(_ name: String, type: ContentType) -> some
    View {
        Text(name)
            .font(.footnote)
            .fontWeight(.medium)
            .foregroundColor(viewModel.selectedContentType == type ? .primary : .secondary)
            .onTapGesture {
                // TODO: with animation
                viewModel.changeContentType(to: type)
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
            .environmentObject(RootViewModel())
    }
}
