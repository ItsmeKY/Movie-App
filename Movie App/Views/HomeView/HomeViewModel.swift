//
//  HomeViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

enum ContentType: String {
    case movie = "Movie"
    case series = "TVSeries"
}

final class HomeViewModel: ObservableObject {
    
    // -- Stay
    @Published var contents: [ContentModel] = []
    
    // -- Stay
    @Published var selectedContentType: ContentType = .movie
    @Published var selectedGenre: String = "All"

    // -- Stay
    // Variables for pagination
    private var contentFromEndThreshold: Int = 5
    private var contentRequestedPerCall: Int = 5
    private var totalContentsAvailable: Int { return NetworkManager.shared.contentsID.count }
    private var contentLoadedCount: Int = 0
    
    // -- Stay
    let gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0)
    ]
    var dynamicGenre: Set<String> = Set(arrayLiteral: "All")
    
    init() {
        requestInitialContent()
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
    
    // -- Stay
    func requestInitialContent() {
        Task {
            let (contents, genre) = await NetworkManager.shared.loadContentConcurrent(start: contentLoadedCount, end: contentRequestedPerCall)
            
            DispatchQueue.main.async {
                self.dynamicGenre = genre
                self.contents = contents
            }
            print("data passed, content 1: \(contents[0])")
        }
    }
    
    // -- Stay
    // -- Assign [ContentModel] recieved from Singleton (using dispatch)
    // The genre set should be unioned with the existing set above
    // OR if pagination is removed, just turn into a sorted array and assign it
    func requestMoreContentIfNeeded(index: Int) {
        // checks if the user has reached to a point so we fetch more data,
        // and if the loaded data has not all be already loaded
        guard contentLoadedCount - index == contentFromEndThreshold &&
              contentLoadedCount < totalContentsAvailable else {
            print("dont call: \(index), loaded: \(contentLoadedCount)")
            return
        }
        
        print("call for more content")
        
        // prevents safety checking indexing
        let endIndex = min(contentLoadedCount + contentRequestedPerCall, totalContentsAvailable)
        Task {
            let (contents, genre) = await NetworkManager.shared.loadContentConcurrent(start: contentLoadedCount, end: endIndex)
            
            DispatchQueue.main.async {
                self.dynamicGenre = genre
                self.contents = contents
            }
        }
    }
}
