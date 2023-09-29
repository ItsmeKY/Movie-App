//
//  FavoritesView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/28/23.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject private var root: RootViewModel
    private var gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20),
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20)
    ]

    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            VStack {
                
                Text("Favorites")
                    .font(.title2)
                    .fontWeight(.bold)
                
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: gridColumn, spacing: 20) {
                        ForEach(root.favoriteContents.indices, id: \.self) { index in
                            PosterView(poster: root.favoriteContents[index].poster,
                                       width: 167, height: 245, cornerRadius: 10)
                                .onTapGesture { root.accessDetailsView(for: index) }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .overlay {
                if root.favoriteContents.isEmpty {
                    Button {
                        root.selectedTab = 0
                    } label: {
                        Text("Empty")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(RootViewModel())
            .preferredColorScheme(.dark)
    }
}
