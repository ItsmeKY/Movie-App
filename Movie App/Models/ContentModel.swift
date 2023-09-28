//
//  ContentModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/25/23.
//

import SwiftUI

struct Short: Decodable {
    let short: ContentModel
}

struct ContentModel: Decodable {
    let url: URL
    let title: String
    let type: String
    let posterUrl: URL
    let description: String
    let aggregateRating: AggregateRating?
    let contentRating: String?
    let genre: [String]
    let trailer: Trailer?
    let actor: [Individual]
    let director: [Individual]
    
    var id: Int = -1
    var imdbID: String = ""
    var poster: Image? = nil
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case url
        case title = "name"
        case type = "@type"
        case posterUrl = "image"
        case description
        case aggregateRating
        case contentRating
        case genre
        case trailer
        case actor
        case director
    }
    
    
    // TODO: url generated are optional, however when data is decoded url expect non-optional, this leaves room for hidden crashes possibly, maybe make them type safe
    static let example = ContentModel(url: URL(string: "https://www.imdb.com/title/tt4154796/")!,
                                      title: "Avengers Endgame",
                                      type: "Movie",
                                      posterUrl: URL(string: "https://m.media-amazon.com/images/M/MV5BMTc5MDE2ODcwNV5BMl5BanBnXkFtZTgwMzI2NzQ2NzM@._V1_.jpg")!,
                                      description: "After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos&apos; actions and restore balance to the universe.",
                                      aggregateRating: .init(ratingCount: 2_500_000, ratingValue: 8.2),
                                      contentRating: "PG-13",
                                      genre: ["Action", "Super-Hero", "Adventure", "Sci-fi"],
                                      trailer: .init(url: URL(string: "https://www.imdb.com/video/vi2163260441/")!),
                                      actor: [.init(name: "Robert Downey Jr."), .init(name: "Chris Evans"), .init(name: "Mark Ruffalo")],
                                      director: [.init(name: "Anthony Russo"), .init(name: "Joe Russo")],
                                      poster: Image("Avengers Poster"))
}

struct AggregateRating: Decodable {
    let ratingCount: Int
    let ratingValue: Float
}

struct Trailer: Decodable {
    let url: URL
}

struct Individual: Decodable {
    let name: String
}
