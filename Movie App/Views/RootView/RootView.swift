//
//  RootView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI


struct RootView: View {
    
    @StateObject var root = RootViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView(selection: $root.selectedTab) {
                    HomeView()
                        .tag(0)
                    
                    SearchView()
                        .tag(1)
                    
                    FavoritesView()
                        .tag(2)
                }


                HStack {
                    Spacer()
                    TabItem("house", tag: 0)
                    Spacer()
                    TabItem("magnifyingglass", tag: 1)
                    Spacer()
                    TabItem("heart", tag: 2)
                    Spacer()
                }
                .frame(height: 40)
                .background(Color.tabBar.ignoresSafeArea().padding(.top, -15))
                .offset(y: root.presentTabBar ? 0 : 100)
            }
            
            
            if root.presentDetailsView {
                DetailsView()
                    .zIndex(1)
                    .transition(.offset(y: UIScreen.main.bounds.height))
            }
        }
        .environmentObject(root)
    }
}

extension RootView {
    private func TabItem(_ systemName: String, tag: Int) -> some View {
        let isActive = self.root.selectedTab == tag
        
        return RoundedRectangle(cornerRadius: 8)
            .fill(isActive ? Color.focus : .clear)
            .frame(width: 40, height: 40, alignment: .center)
            .overlay {
                Image(systemName: systemName)
                    .font(.system(size: 24))
                    .foregroundStyle(Color.opposite)
                    .opacity(isActive ? 1 : 0.5)
            }
            .onTapGesture {
                self.root.selectedTab = tag
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.light)
    }
}
