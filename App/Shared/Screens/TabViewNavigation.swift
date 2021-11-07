//
//  TabView.swift
//  InsightOut
//
//  Created by Marc Gidaszewski on 06.11.21.
//

import SwiftUI

struct TabViewNavigation: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            OverviewView()
                .tabItem {
                    Label("Overview", systemImage: "calendar")
                }
        }
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewNavigation()
    }
}
