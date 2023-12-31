//
//  NetworkManager.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/28/23.
//

import SwiftUI

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    // Move to Singleton
    let contentsID: [String] = [
        "tt1517268", "tt5971474", "tt10160976", 
        "tt22687790", "tt10638522",
                                        "tt15398776", "tt9663764", "tt15354916", "tt15789038", "tt5537002",
                                        "tt17024450", "tt21276878", "tt14230458", "tt21454134", "tt15671028",
                                     "tt5814060", "tt1462764", "tt8589698", "tt15153532", "tt21103300",
                                     "tt9362722", "tt0439572", "tt3291150", "tt17527468", "tt7599146",
                                     "tt11858890", "tt1001520", "tt10731256", "tt21940010", "tt13238346",
                                     "tt6791350", "tt21232992", "tt13560574", "tt13444014", "tt9362930",
                                     "tt2906216", "tt4495098", "tt4589218", "tt9224104", "tt15334488",
//                                     "tt13957560", "tt11663228", "tt15428940", "tt6906292", "tt14230388",
//                                     "tt0455944", "tt21807222", "tt10016180", "tt9603212", "tt10172266",
//                                     "tt1877830", "tt10366206", "tt1136617", "tt0816692", "tt8452344",
//                                     "tt5433140", "tt10640346", "tt12921446", "tt17663992", "tt3427252",
//                                     "tt6718170", "tt13603966", "tt0068646", "tt0111161", "tt0468569",
//                                     "tt7657566", "tt0070047", "tt5112584", "tt9100018", "tt0259446",
//                                     "tt0993846", "tt0083929", "tt4873118", "tt3402236", "tt8080204",
//                                     "tt10545296", "tt9764362", "tt1630029", "tt13375076", "tt0241527",
//                                     "tt13345606", "tt3766354", "tt0092005", "tt12261776", "tt1343727",
//                                     "tt5090568", "tt1160419", "tt6587046", "tt1375666", "tt7405458",
//                                     "tt16968450", "tt6710474", "tt15257160", "tt0361748", "tt7645334",
//                                     "tt9639470", "tt13833688", "tt14362112", "tt1457767", "tt0082971"
// series
                                "tt0944947", "tt0903747", "tt4574334", "tt0108778", "tt1475582", "tt7366338",
                                "tt0773262", "tt0386676", "tt2085059", "tt2356777", "tt2442560", "tt3032476",
                                "tt1190634", "tt2861424", "tt8111088", "tt0475784", "tt1856010", "tt10048342",
                                "tt0185906", "tt0412142", "tt3322312", "tt3581920", "tt2707408", "tt2560140",
                                "tt0141842", "tt0096697", "tt5753856"
]
    private let jsonDecoder = JSONDecoder()
    
    typealias MovieGenre = String
    typealias SeriesGenre = String
    
    // -- Move to Singleton
    // -- Make it return [ContentModel] and [Set of genre]
    // -- (do on commit 2) Remove pagination of content info
    // You may keep it for loading images however
    /// Loads all the contents for all the existing content IDs cuncurrently, and also returns a list of unique genres found in the contents
    func loadContentConcurrent(_ contentIDs: [String], withGenre: Bool) async -> ([ContentModel], [MovieGenre], [SeriesGenre]) {
        var all: [ContentModel] = []
        var movieGenres: Set<MovieGenre> = Set()
        var seriesGenres: Set<SeriesGenre> = Set()
        var idTracker: Int = 0
        
        try? await withThrowingTaskGroup(of: ContentModel?.self) { group in
            for contentID in contentIDs {
                group.addTask {
                    // TODO: creates memory leak; work on this
                    return try? await self.parseContentJSON(contentID: contentID)
                }
            }
            
            for try await contentFound in group {
                if var safeContent = contentFound {
                    // Setting Ids (so i dont use UUID and stop indexing) and imdb ID
                    safeContent.id = idTracker
                    idTracker += 1
                    
                    all.append(safeContent)
                    
                    if withGenre {
                        // Finding Unique Genres
                        for i in safeContent.genre {
                            if safeContent.type == ContentType.movie.rawValue { movieGenres.insert(i) }
                            else { seriesGenres.insert(i) }
                        }
                    }
                    
                    print("data appended: \(all.count)")
                }
            }
            return
        }
        
        var sortedMovieGenres = Array(movieGenres).sorted()
        sortedMovieGenres.insert("All", at: 0)
        
        var sortedSeriesGenres = Array(seriesGenres).sorted()
        sortedSeriesGenres.insert("All", at: 0)
        
// TODO: to sort content, the indexing method you used to manually create remove it, use UUID(), also remove poster and only keep posterURL
//        let sortedContent = all.sorted { first, second in
//            // New unrated movies come first, and then highest ranking to lowest ranking
//            guard let first = first.aggregateRating?.ratingCount else { return true }
//            guard let second = second.aggregateRating?.ratingCount else { return false }
//            return first > second
//        }
        
        return (all, sortedMovieGenres, sortedSeriesGenres)
    }
    
    // -- Move to Singleton
    // Make another version that takes (name:) -> [ContentModel]
    /// Fetches the end point based on the movieID, decodes json as the Content Model
    private func parseContentJSON(contentID: String) async throws -> ContentModel {
        
        guard let url = URL(string: "https://search.imdbot.workers.dev/?tt=\(contentID)") else {
            throw ParseError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ParseError.invalidResponse
        }
        
        do {
            var content = try jsonDecoder.decode(Short.self, from: data).short
//            content.poster = await downloadImage(from: content.posterUrl)
            content.imdbID = contentID
            print(content.type)
            return content
        } catch {
            throw ParseError.invalidData
        }
    }
    
    // This parse method works slightly differently than the other one, this calls a search api the calls loadDataConcurrrent
    func parseContentJSON(keyword: String) async throws -> [ContentModel] {
        print("in parse function pre url")
        guard let url = URL(string: "https://search.imdbot.workers.dev/?q=\(keyword)") else {
            throw ParseError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ParseError.invalidResponse
        }
            
        print("in parse function pre data")
        do {
            let searchResult = try jsonDecoder.decode(SearchModel.self, from: data)
            let contentIDs = searchResult.contentIDs.map { $0.imdbID }
            let (contents, _, _) = await self.loadContentConcurrent(contentIDs, withGenre: false)
            print(contents.count)
            return contents
        } catch {
            throw ParseError.invalidData
        }
        
    }
    
    // -- Move to Singleton
    /// Downloads data from URL and returns an Image utilized from the data
    private func downloadImage(from url: URL) async -> Image? {
        guard let (data, _) = try? await URLSession.shared.data(from: url),
              let uiImage = UIImage(data: data) else {
            print("nil image")
            return nil
        }
        return Image(uiImage: uiImage)
        
    }
    
    // -- Move to Singleton
    private enum ParseError: Error {
        case invalidURL
        case invalidResponse
        case invalidData
    }
}
