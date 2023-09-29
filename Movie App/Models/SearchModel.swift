//
//  SearchModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/30/23.
//

import Foundation

struct SearchModel: Decodable {
    let contentIDs: [ContentID]
    
    enum CodingKeys: String, CodingKey {
        case contentIDs = "description"
    }
}

struct ContentID: Decodable {
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        case imdbID = "#IMDB_ID"
    }
}
//description[0].#IMDB_ID
