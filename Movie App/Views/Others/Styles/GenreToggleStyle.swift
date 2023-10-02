//
//  GenreToggleStyle.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

struct GenreToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption2)
            .fontWeight(.medium)
            .frame(height: 25)
            .padding(.horizontal, 15)
            .foregroundColor(configuration.isOn ? .white : Color.primary.opacity(0.5))
        // TODO: make the other style work
            .build(configuration.isOn) { $0.background(Color.focus).cornerRadius(5) }
            .build(!configuration.isOn) {
                $0.background(RoundedRectangle(cornerRadius: 5)
                    .stroke(lineWidth: 1.5)
                    .foregroundColor(.replacement))
            }
            .onTapGesture {
                configuration.isOn.toggle()
            }
    }
}


struct GenreToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 100) {
            Toggle(isOn: .constant(true)) {
                Text("All")
            }
            .toggleStyle(GenreToggleStyle())
            
            Toggle(isOn: .constant(false)) {
                Text("Casual")
            }
            .toggleStyle(GenreToggleStyle())
        }
        .padding()
        .background(Color.background)
    }
}
