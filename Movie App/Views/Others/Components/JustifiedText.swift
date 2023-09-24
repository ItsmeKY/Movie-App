//
//  JustifiedText.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

struct JustifiedText: UIViewRepresentable {
    
    private let text: String
    private let font: UIFont
    private let weight: UIFont.Weight
    
    init(_ text: String, font: UIFont = .systemFont(ofSize: 18), weight: UIFont.Weight = .regular) {
        self.text = text
        self.font = font
        self.weight = weight
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: font.pointSize, weight: weight)
        textView.textAlignment = .justified
        textView.textColor = .
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }
}

struct JustifiedText_Previews: PreviewProvider {
    static var previews: some View {
        JustifiedText("After the devastating events of Avengers: Infinity War (2018), the universe is in ruins. With the help of remaining allies, the Avengers assemble once more in order to reverse Thanos&apos; actions and restore balance to the universe.", font: .systemFont(ofSize: 12), weight: .medium)
    }
}
