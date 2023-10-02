//
//  HomeViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    // -- Stay
    @Published var contents: [ContentModel] = []
    
    // -- Stay
    @Published var selectedContentType: ContentType = .movie
    @Published var selectedGenre: String = "All"
    
    // -- Stay
    let gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0)
    ]
    
    var currentGenres: [String] = []
    /// These are either movie or series genres, depending on which the user is currently trying to look at, the one not shown is called seated
    var seatedGenres: [String] = []
    
    init() {
        // TODO: how about initializing all those variables above and for all other class in inits, is it not cleaner?
        loadContent()
    }
    
    func loadContent() {
        Task {
            let (contents, movieGenres, seriesGenres) = await NetworkManager.shared.loadContentConcurrent(NetworkManager.shared.contentsID, withGenre: true)
            
            DispatchQueue.main.async { [weak self] in
                self?.contents = contents
                
                // TODO: is this even worth doing as the operation is too quick for the user to try change type before this data arrives?
                if self?.selectedContentType == .movie {
                    self?.currentGenres = movieGenres
                    self?.seatedGenres = seriesGenres
                } else {
                    self?.currentGenres = seriesGenres
                    self?.seatedGenres = movieGenres
                }
                
            }
        }
    }
    
    func changeContentType(to type: ContentType) {
        
        self.selectedContentType = type
        // Swap to genres
        let tempCurrentGenres = self.currentGenres
        self.currentGenres = self.seatedGenres
        self.seatedGenres = tempCurrentGenres
        
    }
    
    // -- Stay
    func isGenreSelected(_ genre: String) -> Binding<Bool> {
        Binding<Bool> {
            self.selectedGenre == genre
        } set: { isSelected in
            if isSelected { self.selectedGenre = genre }
        }
    }
    
    // -- Stay
    /// Checks if the content at the given index should be shown after user custom filtering
    /// Filtering of Type (Movie or Series) and Genre (Action, Horror ...)
    func contentInFilter(_ index: Int, genreSpecific: Bool) -> Bool {
        let isSameType = contents[index].type == selectedContentType.rawValue
        if genreSpecific { return (selectedGenre == "All" || contents[index].genre.contains(selectedGenre)) && isSameType }
        return isSameType
    }
 
/*
// -- Stay
//    func requestInitialContent() {
//        Task {
//            let (contents, genre) = await NetworkManager.shared.loadContentConcurrent(start: contentLoadedCount, end: contentRequestedPerCall)
//
//            DispatchQueue.main.async {
//                self.dynamicGenre = genre
//                self.contents = contents
//            }
//            print("data passed, content 1: \(contents[0])")
//        }
//    }
// -- Stay
// -- Assign [ContentModel] recieved from Singleton (using dispatch)
// The genre set should be unioned with the existing set above
// OR if pagination is removed, just turn into a sorted array and assign it
//    func requestMoreContentIfNeeded(index: Int) {
//        // checks if the user has reached to a point so we fetch more data,
//        // and if the loaded data has not all be already loaded
//        guard contentLoadedCount - index == contentFromEndThreshold &&
//              contentLoadedCount < totalContentsAvailable else {
//            print("dont call: \(index), loaded: \(contentLoadedCount)")
//            return
//        }
//
//        print("call for more content")
//
//        // prevents safety checking indexing
//        let endIndex = min(contentLoadedCount + contentRequestedPerCall, totalContentsAvailable)
//        Task {
//            let (contents, genre) = await NetworkManager.shared.loadContentConcurrent(start: contentLoadedCount, end: endIndex)
//
//            DispatchQueue.main.async {
//                self.dynamicGenre = genre
//                self.contents = contents
//            }
//        }
//    }
*/
}

enum ContentType: String {
    case movie = "Movie"
    case series = "TVSeries"
}
