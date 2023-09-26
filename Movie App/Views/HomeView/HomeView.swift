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
        NavigationStack {
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                VStack(spacing: 15) {
                    // MARK: Content Type
                    HStack {
                        TypeText("Movies", edge: .trailing, selection: 0)
                        
                        TypeText("Series", edge: .leading, selection: 1)
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
                                        ForEach(viewModel.contents) { content in
                                            PosterView(poster: content.poster, width: 170, height: 250, cornerRadius: 10)
                                                .onTapGesture { viewModel.accessPosterView() }
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
                                
                                // MARK: Trending Movies Slider
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(viewModel.categories, id: \.self) { category in
                                            Toggle(isOn: viewModel.isCategorySelected(category)) {
                                                Text(category)
                                            }
                                            .toggleStyle(CategoryToggleStyle())
                                        }
                                    }
                                    .padding(.leading)
                                }
                                
                                
                                LazyVGrid(columns: viewModel.gridColumn, spacing: 15) {
                                    ForEach(viewModel.contents) { content in
                                        PosterView(poster: content.poster, width: 111, height: 164, cornerRadius: 10)
                                            .onTapGesture { viewModel.accessPosterView() }
//                                          
                                    }
                                }
                                .padding(.horizontal, 5)
                            }
                            
                            Spacer()
                        }
                    }
                }
                
            }
            .navigationDestination(isPresented: $viewModel.presentDetailsView) {
                DetailsView()
            }
        }
        .toolbar(.hidden, for: .bottomBar)
        .onAppear {
            Task {
//                await viewModel.loadContentConcurrent()
            }
        }

        
    }
    
    @ViewBuilder
    private func TypeText(_ name: String, edge: Edge.Set, selection: Int) -> some
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
