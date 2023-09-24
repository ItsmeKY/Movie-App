//
//  CategoryToggleStyle.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

struct CategoryToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption2)
            .fontWeight(.medium)
            .frame(height: 25)
            .padding(.horizontal, 15)
            .foregroundColor(configuration.isOn ? .white : Color.white.opacity(0.7))
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


struct CategoryToggleStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 100) {
            Toggle(isOn: .constant(true)) {
                Text("All")
            }
            .toggleStyle(CategoryToggleStyle())
            
            Toggle(isOn: .constant(false)) {
                Text("Casual")
            }
            .toggleStyle(CategoryToggleStyle())
        }
        .padding()
        .background(.black)
    }
}
