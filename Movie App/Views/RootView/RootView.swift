//
//  RootView.swift
//  Movie App
//
//  Created by ItsmeKY3 on 9/24/23.
//

import SwiftUI

    final class TabBarPresenter: ObservableObject {
        @Published var isPresent: Bool = true
        
        func updatePresentState() {
            withAnimation {
                isPresent.toggle()
            }
        }
    }

struct RootView: View {
    
    @State var selectedTab: Int = 0
    @StateObject var tabBarPresenter = TabBarPresenter()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)
                
                SearchView()
                    .tag(1)
                
                EmptyView()
                    .tag(2)
            }

            ZStack {
                Color.tabBar
 
                HStack {
                    Spacer()
                    TabItem("house", tag: 0)
                    Spacer()
                    TabItem("magnifyingglass", tag: 1)
                    Spacer()
                    TabItem("heart", tag: 2)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(height: 40)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .offset(y: tabBarPresenter.isPresent ? 0 : 100)
        }
        .environmentObject(tabBarPresenter)
    }
}

extension RootView {
    private func TabItem(_ systemName: String, tag: Int) -> some View {
        let isActive = selectedTab == tag
        
        return RoundedRectangle(cornerRadius: 8)
            .fill(isActive ? Color.focus : .clear)
            .frame(width: 40, height: 40, alignment: .center)
            .overlay {
                Image(systemName: systemName)
                    .font(.system(size: 24))
                    .opacity(isActive ? 1 : 0.5)
            }
            .onTapGesture {
                self.selectedTab = tag
            }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .preferredColorScheme(.dark)
    }
}
