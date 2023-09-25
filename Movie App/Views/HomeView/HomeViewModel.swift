//
//  HomeViewModel.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/23/23.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    // Write code
    @Published var selectedType: Int = 0
    @Published var categorySelected: String = "All"
    
    @Published var presentDetailsView: Bool = false
    
    let gridColumn: [GridItem] = [
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0),
        GridItem(.flexible(minimum: 90, maximum: 140), spacing: 0)
    ]
    let categories: [String] = ["All", "Action", "Thriller", "Romantic", "Adventure"]
    
    static let movieIDs: [String] = ["tt1517268", "tt5971474", "tt10160976", "tt22687790", "tt10638522",
                                     "tt15398776", "tt9663764", "tt15354916", "tt15789038", "tt5537002",
                                     "tt17024450", "tt21276878", "tt14230458", "tt21454134", "tt15671028",
                                     "tt5814060", "tt1462764", "tt8589698", "tt15153532", "tt21103300",
                                     "tt9362722", "tt0439572", "tt3291150", "tt17527468", "tt7599146",
                                     "tt11858890", "tt1001520", "tt10731256", "tt21940010", "tt13238346",
                                     "tt6791350", "tt21232992", "tt13560574", "tt13444014", "tt9362930",
                                     "tt2906216", "tt4495098", "tt4589218", "tt9224104", "tt15334488",
                                     "tt13957560", "tt11663228", "tt15428940", "tt6906292", "tt14230388",
                                     "tt0455944", "tt21807222", "tt10016180", "tt9603212", "tt10172266",
                                     "tt1877830", "tt10366206", "tt1136617", "tt0816692", "tt8452344",
                                     "tt5433140", "tt10640346", "tt12921446", "tt17663992", "tt3427252",
                                     "tt6718170", "tt13603966", "tt0068646", "tt0111161", "tt0468569",
                                     "tt7657566", "tt0070047", "tt5112584", "tt9100018", "tt0259446",
                                     "tt0993846", "tt0083929", "tt4873118", "tt3402236", "tt8080204",
                                     "tt10545296", "tt9764362", "tt1630029", "tt13375076", "tt0241527",
                                     "tt13345606", "tt3766354", "tt0092005", "tt12261776", "tt1343727",
                                     "tt5090568", "tt1160419", "tt6587046", "tt1375666", "tt7405458",
                                     "tt16968450", "tt6710474", "tt15257160", "tt0361748", "tt7645334",
                                     "tt9639470", "tt13833688", "tt14362112", "tt1457767", "tt0082971"]
    
    func isCategorySelected(_ category: String) -> Binding<Bool> {
        Binding<Bool> {
            self.categorySelected == category
        } set: { isSelected in
            if isSelected { self.categorySelected = category }
        }
    }
    
    // TODO: param will take model info
    func accessPosterView() {
        withAnimation {
            self.presentDetailsView = true
        }
    }
    
}


