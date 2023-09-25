//
//  DetailsView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject private var viewModel = DetailsViewModel()
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var tabBarPresenter: TabBarPresenter

    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: Poster

                        PosterView(poster: Image("Avengers Poster"))
                        .padding(.top, -97)

                        
                        HStack(spacing: 10) {
                            // MARK: Company Name
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.alertYellow)
                                .frame(width: 75, height: 25, alignment: .center)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(lineWidth: 1.5)
                                        .frame(width: 75, height: 25, alignment: .center)
                                        .foregroundColor(.alertYellowBorders)
                                }
                                .overlay {
                                    Text("IMDB")
                                        .font(.caption2)
                                        .fontWeight(.heavy)
                                        .foregroundColor(.black)
                                }
                            
                            //MARK: Ranking and Views
                            HStack(spacing: 5) {
                                    Image(systemName: "star.fill")
                                        .font(.subheadline)
                                        .foregroundColor(.alertYellow)
                                
                                Text(String(5.0))
                                    .fontWeight(.heavy)
                                    .foregroundColor(.alertYellow)
                                
                                Text("(205k reviews)")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .opacity(0.8)
                            }
                            
                            Spacer()
                            
                            Image("Share")
                                .resizable()
                                .frame(width: 21, height: 18, alignment: .center)
                            
                            Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 18, height: 17, alignment: .center)
                                .foregroundColor(viewModel.isFavorite ? .heartRed : .secondary)
                                .onTapGesture { viewModel.isFavorite.toggle() }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: 0) {
                                // MARK: Title of Content
                                Text("Avengers: Infinity War")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                // MARK: Restriction of Content
                                Text("PG-13")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .frame(height: 22)
                                    .padding(.horizontal, 5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(lineWidth: 1)
                                    )
                                    .foregroundColor(.primary.opacity(0.5))
                            }
                            
                            // MARK: Genres of Content
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(viewModel.genres, id: \.self) { genre in
                                        Text(genre)
                                            .font(.caption)
                                            .fontWeight(.medium)
                                            .frame(height: 24, alignment: .center)
                                            .padding(.horizontal, 10)
                                            .background(Color.replacement)
                                            .cornerRadius(8)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // MARK: Information About Content
                            Text("After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos&apos; actions and restore balance to the universe.")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary.opacity(0.8))
                                .padding(.horizontal)
                            
                            Text("**Director:** Anthony Russo, Joe Russo")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary.opacity(0.8))
                                .padding(.horizontal)
                            
                            Text("**Actors:** Robert Downey Jr., Chris Evans, Mark Ruffalo")
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.primary.opacity(0.8))
                                .padding(.horizontal)
                                .padding(.top, -8)
                        }
                        
                        Button(action: {}) {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 48, alignment: .center)
                                .foregroundColor(.focus)
                                .overlay {
                                    HStack {
                                        Text("Watch Trailer")
                                            
                                        Image(systemName: "play.fill")
                                    }
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                    }
                    .edgesIgnoringSafeArea(.top)
                }
            }
            .overlay {
                Circle()
                    .frame(width: 30, height: 30, alignment: .center)
                    .foregroundColor(.white)
                    .overlay {
                        Image(systemName: "multiply")
                            .font(.title3)
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(.leading)
                    .onTapGesture { dismiss() }
            }
        }
        .onAppear { tabBarPresenter.updatePresentState() }
        .onDisappear { tabBarPresenter.updatePresentState() }
        .toolbar(.hidden)
    }

}

struct DetailsView_Previews: PreviewProvider {
        
    static var previews: some View {
        DetailsView()
            .preferredColorScheme(.dark)
            .environmentObject(TabBarPresenter())
    }
}
