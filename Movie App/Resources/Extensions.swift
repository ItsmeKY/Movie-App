//
//  Extensions.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

extension Color {
    static let background = Color("Background")
    static let alertYellow = Color("Alert Yellow")
    static let alertYellowBorders = Color("Alert Yellow Borders")
    static let focus = Color("Focus")
    static let heartRed = Color("Heart Red")
    static let replacement = Color("Replacement")
    static let tabBar = Color("Tab Bar Color")
}

extension View {
    
    @ViewBuilder
    internal func build<Content: View>(_ condition: Bool, modifier: (Self) -> Content) -> some View {
        if condition {
            modifier(self)
        } else {
            self
        }
    }
    
}


extension Int {
    
    func letterFormat() -> String {
        let number = abs(self)
        
        if number > 1_000_000 {
            return String(format: "%.1fM", Double(number) / 1_000_000)
        } else if number > 1_000 {
            return String(format: "%.1fk", Double(number) / 1_000)
        } else {
            return String(number)
        }
    }
    
}
