//
//  RootViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/28/23.
//

import SwiftUI

final class RootViewModel: ObservableObject {
    
    @Published var selectedTab: Int = 0
    @Published var presentTabBar: Bool = true
    
    // -- Move to Root
    // -- Remove selectedIndex
    var selectedContent: ContentModel = .example
    @Published var presentDetailsView: Bool = false
    
    // TODO: in the future you can make this persistant
    var favoriteContents: [ContentModel] = []
        
    // -- Move to Root
    // -- Remove Index, just pass type ContentModel
    // -- Compare to the [favorite content] if in it, send that, else the non fav form
    // -- Asign it and switch the bool
    func accessDetailsView(_ content: ContentModel) {
        
        self.selectedContent = content

        // Check if content tapped exists in the favorite content list
        // yes: update the item to is favorite
        // no: do not update it
        for favoriteContent in favoriteContents {
            if favoriteContent.imdbID == content.imdbID {
                self.selectedContent.isFavorite = true
            }
        }
        
        withAnimation {
            self.presentTabBar = false
            self.presentDetailsView = true
        }
    }
    
    func accessDetailsView(for index: Int) {
        self.selectedContent = favoriteContents[index]
        
        withAnimation {
            self.presentTabBar = false
            self.presentDetailsView = true
        }
    }
    
    // -- Move to Root
    // -- See if favorite state is changed
    // -- Accordingly change [favorite content]
    func dismissDetailsView(isChanged: Bool, isFavorite: Bool) {
        
        if isChanged {
            if isFavorite {
                // Add to list
                self.selectedContent.isFavorite = true
                self.favoriteContents.append(selectedContent)
            } else {
                // Remove from list
                self.favoriteContents.removeAll { $0.imdbID == selectedContent.imdbID }
            }
        }
        
        withAnimation {
            self.presentTabBar = true
            self.presentDetailsView = false
        }
    }
}
