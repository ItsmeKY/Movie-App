//
//  DetailsView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

struct DetailsView: View {
    
    @StateObject private var viewModel = DetailsViewModel()
    // Learned: Environment Object cannot be nested in a class, only views (ie structs)
    @EnvironmentObject private var root: RootViewModel

//    private var content: ContentModel
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: Poster

                        PosterView(poster: root.selectedContent.poster)
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
                                if let rating = root.selectedContent.aggregateRating {
                                    Image(systemName: "star.fill")
                                        .font(.subheadline)
                                        .foregroundColor(.alertYellow)
                                    
                                    Text(String(rating.ratingValue))
                                        .fontWeight(.heavy)
                                        .foregroundColor(.alertYellow)
                                    
                                    Text("(\(rating.ratingCount.letterFormat()) reviews)")
                                        .font(.caption)
                                        .fontWeight(.medium)
                                        .opacity(0.8)
                                }
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
                                Text(root.selectedContent.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                                
                                // MARK: Restriction of Content
                                if let restriction = root.selectedContent.contentRating {
                                    Text(restriction)
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
                            }
                            
                            // MARK: Genres of Content
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack {
                                    ForEach(root.selectedContent.genre, id: \.self) { genre in
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
                            InfoText(root.selectedContent.description)
                                
                            let directors = root.selectedContent.director.map { $0.name }.joined(separator: ", ")
                            InfoText("Director: \(directors)")
                            
                            let actors = root.selectedContent.actor.map { $0.name }.joined(separator: ", ")
                            InfoText("Actors: \(actors)")
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
                    .onTapGesture { root.dismissDetailsView() }
            }
        }
        .onAppear {
            viewModel.isFavorite = root.selectedContent.isFavorite
        }
  
        .toolbar(.hidden)
    }
    
    private func InfoText(_ text: String) -> some View {
        Text(text)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.primary.opacity(0.8))
            .padding(.horizontal)
    }

}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView()
            .preferredColorScheme(.dark)
            .environmentObject(RootViewModel())
    }
}
