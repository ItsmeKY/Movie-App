//
//  ContentView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    // MARK: Content Type
                    HStack {
                        TypeText("Movies", edge: .trailing, selection: "Movies")
                        
                        TypeText("Series", edge: .leading, selection: "TVMovies")
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
                                        ForEach(viewModel.contents.indices, id: \.self) { index in
                                            // TODO: try to make the model Int based IDs using computed prop and see if that can replace indexing
                                            if viewModel.contentInFilter(index, genreSpecific: false) {
                                                PosterView(poster: viewModel.contents[index].poster, width: 170, height: 250, cornerRadius: 10)
                                                    .onTapGesture { viewModel.accessPosterView(index) }
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
                                        ForEach(Array(viewModel.dynamicGenre), id: \.self) { genre in
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
                                    ForEach(viewModel.contents.indices, id: \.self) { index in
                                        if viewModel.contentInFilter(index, genreSpecific: true) {
                                            PosterView(poster: viewModel.contents[index].poster, width: 111, height: 164, cornerRadius: 10)
                                                .onTapGesture { viewModel.accessPosterView(index) }
                                                .onAppear {
                                                    viewModel.requestMoreContentIfNeeded(index: index)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                            
                            Spacer()
                        }
                    }
                }
                
                if viewModel.presentDetailsView {
                    // TODO: are u sure its type safe?
                    DetailsView(content: viewModel.selectedContent ?? .example,
                                index: viewModel.selectedIndex ?? 0,
                                dismiss: viewModel.dismissDetailView,
                                track: viewModel.favoriteStatusUpdate)
                    .zIndex(1)
                    .transition(.offset(y: UIScreen.main.bounds.height))
                }
                
            }
    }
    
    @ViewBuilder
    private func TypeText(_ name: String, edge: Edge.Set, selection: String) -> some
    View {
        Text(name)
            .font(.footnote)
            .fontWeight(.medium)
            .padding(edge)
            .foregroundColor(viewModel.selectedContentType == selection ? .primary : .secondary)
            .onTapGesture {
                // TODO: with animation
                viewModel.selectedContentType = selection
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}
