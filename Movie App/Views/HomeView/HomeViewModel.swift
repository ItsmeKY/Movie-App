//
//  HomeViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    
    @Published var contents: [ContentModel] = []
    
    @Published var selectedContentType: ContentType = .movie
    @Published var selectedGenre: String = "All"
    
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
        Task { [weak self] in
            let (contents, movieGenres, seriesGenres) = await NetworkManager.shared.loadContentConcurrent(NetworkManager.shared.contentsID, withGenre: true)
            
            // TODO: is this even worth doing as the operation is too quick for the user to try change type before this data arrives?
            if self?.selectedContentType == .movie {
                self?.currentGenres = movieGenres
                self?.seatedGenres = seriesGenres
                print("its movie type")
            } else {
                self?.currentGenres = seriesGenres
                self?.seatedGenres = movieGenres
                print("its series type")
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.contents = contents
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
    
    func isGenreSelected(_ genre: String) -> Binding<Bool> {
        Binding<Bool> {
            self.selectedGenre == genre
        } set: { isSelected in
            if isSelected { self.selectedGenre = genre }
        }
    }
    
    func contentInFilter(_ index: Int, genreSpecific: Bool) -> Bool {
        let isSameType = contents[index].type == selectedContentType.rawValue
//        print(contents[index].type, selectedContentType.rawValue, isSameType, contents[index].title)
        print(isSameType, contents[index].title)
        if !genreSpecific { return isSameType }
        print((selectedGenre == "All" || contents[index].genre.contains(selectedGenre)) && isSameType, contents[index].title)
        return (selectedGenre == "All" || contents[index].genre.contains(selectedGenre)) && isSameType
    }

}

enum ContentType: String {
    case movie = "Movie"
    case series = "TVSeries"
}
