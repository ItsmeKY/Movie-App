//
//  RootViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/28/23.
//

import SwiftUI

final class RootViewModel: ObservableObject {
    @Published var presentTabBar: Bool = true
    
    // -- Move to Root
    // -- Remove selectedIndex
    var selectedContent: ContentModel = .example
    @Published var presentDetailsView: Bool = false
    
        
    // -- Move to Root
    // -- Remove Index, just pass type ContentModel
    // Compare to the [favorite content] if in it, send that, else the non fav form
    // Asign it and switch the bool
    func accessDetailsView(_ content: ContentModel) {
        self.selectedContent = content
        
        withAnimation {
            self.presentTabBar = false
            self.presentDetailsView = true
        }
    }
    
    // -- Move to Root
    // See if favorite state is changed
    // Accordingly change [favorite content]
    func dismissDetailsView() {
        withAnimation {
            self.presentTabBar = true
            self.presentDetailsView = false
        }
    }
}
