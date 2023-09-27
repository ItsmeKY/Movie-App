//
//  RootViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/28/23.
//

import SwiftUI

final class RootViewModel: ObservableObject {
    @Published var presentTabBar: Bool = true
    
    func updateTabBarState() {
        withAnimation {
            presentTabBar.toggle()
        }
    }
}
