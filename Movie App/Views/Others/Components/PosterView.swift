//
//  PosterView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

struct PosterView: View {
    
    private var poster: Image?
    private var width: CGFloat?
    private var height: CGFloat?
    private var cornerRadius: CGFloat
    
    
    var body: some View {
        if poster != nil {
            poster?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: width, height: height, alignment: .center)
                .cornerRadius(cornerRadius)
        } else {
            Color.replacement
                .frame(width: width, height: height, alignment: .center)
                .cornerRadius(cornerRadius)
        }
//        let url = URL(string: "https://m.media-amazon.com/images/M/MV5BYmQ4YWMxYjUtNjZmYi00MDQ1LWFjMjMtNjA5ZDdiYjdiODU5XkEyXkFqcGdeQXVyMTMzNDExODE5._V1_.jpg")
//        AsyncImage(url: url) { Image in
//            Image
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//        } placeholder: {
//            Color.replacement
//        }
//        .frame(width: width, height: height, alignment: .center)
//        .cornerRadius(cornerRadius)

    }
    
    init(poster: Image? = nil, width: CGFloat? = nil, height: CGFloat? = nil, cornerRadius: CGFloat = 0) {
        self.poster = poster
        self.width = width
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    init(poster: Image? = nil, width: CGFloat, cornerRadius: CGFloat = 0) {
        self.poster = poster
        self.width = width
        self.height = width * 1.47
        self.cornerRadius = cornerRadius
    }
}

struct PosterView_Previews: PreviewProvider {
    static var previews: some View {
       PosterView(poster: Image("Avengers Poster"), width: 170, height: 250, cornerRadius: 10)
    }
}
