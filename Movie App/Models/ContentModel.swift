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

struct ContentModel: Decodable, Identifiable {
    let id = UUID()
    
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
    
    var poster: Image?
}

struct AggregateRating: Decodable {
    let ratingCount: Int
}

struct Trailer: Decodable {
    let url: URL
}

struct Individual: Decodable {
    let name: String
}