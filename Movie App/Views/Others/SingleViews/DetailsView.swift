//
//  DetailsView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI
import AVKit

struct DetailsView: View {
    
    // Learned: Environment Object cannot be nested in a class, only views (ie structs)
    @EnvironmentObject private var root: RootViewModel
    @State private var isFavorite: Bool = false
    @State private var presentTrailerPlayer: Bool = false
//    private var content: ContentModel
    
//    init() {
//        isFavorite = root.selectedContent.isFavorite
//    }
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                Color.background
                    .ignoresSafeArea()
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: Poster

                        PosterView(posterURL: root.selectedContent.posterUrl)
                            .padding(.top, -97)

                        
                        HStack(spacing: 8) {
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
                            HStack(spacing: 3) {
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
                                        .padding(.leading, 5)
                                }
                            }
                            
                            Spacer()
                            
                            ShareLink(item: root.selectedContent.url,
                                      subject: Text(root.selectedContent.title),
                                      message: Text(root.selectedContent.description),
                                      preview: SharePreview(root.selectedContent.title)) {
                                Image("Share")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundStyle(Color.primary)
                                    .frame(width: 21, height: 18, alignment: .center)
                            }
                                      .padding(.trailing, 3)
                            
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 18, height: 17, alignment: .center)
                                .foregroundColor(isFavorite ? .heartRed : .secondary)
                                .onTapGesture { isFavorite.toggle() }
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 15) {
                            HStack(spacing: -5) {
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
                                
                            if let directors = root.selectedContent.director?.map({ $0.name }).joined(separator: ", ") {
                                InfoText("Director: \(directors)")
                            }
                            
                            let actors = root.selectedContent.actor.map { $0.name }.joined(separator: ", ")
                            InfoText("Actors: \(actors)")
                                .padding(.top, -8)
                        }
                        
                        Button(action: {
                            withAnimation {
                                presentTrailerPlayer = true
                            }
                        }) {
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
                
                if presentTrailerPlayer {
                    
                    VideoPlayer(player: AVPlayer(url: root.selectedContent.trailer!.url))
                        .background(Color.black.ignoresSafeArea())
                  

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
                    .onTapGesture { root.dismissDetailsView(isChanged: isFavorite != root.selectedContent.isFavorite,
                                                            isFavorite: isFavorite) }
            }
        }
        .onAppear {
            isFavorite = root.selectedContent.isFavorite
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
//            .preferredColorScheme(.dark)
            .environmentObject(RootViewModel())
    }
}
