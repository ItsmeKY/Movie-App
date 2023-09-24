//
//  PosterScrollView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

struct PosterScrollView: View {
    
    private var gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20),
        GridItem(.flexible(minimum: 125, maximum: 180), spacing: 20)
    ]
    private var accessPosterView: () -> Void
    
    var body: some View {
        // MARK: Posters ScrollView
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: gridColumn, spacing: 20) {
                ForEach(0...10, id: \.self) { index in
                    PosterView(poster: index % 2 == 0 ? Image("Avengers Poster") : Image("Elemental Poster"))
                        .onTapGesture { accessPosterView() }
                }
            }
            .padding(.horizontal)
        }
        
        Spacer()
    }
    
    init(accessPosterView: @escaping () -> Void) {
        self.accessPosterView = accessPosterView
    }
}

struct PosterScrollView_Previews: PreviewProvider {
    static var previews: some View {
        PosterScrollView(accessPosterView: {})
    }
}
