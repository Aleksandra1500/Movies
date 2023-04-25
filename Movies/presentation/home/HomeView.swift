//
//  HomeView.swift
//  Movies
//
//  Created by Mateusz Filipek on 21/04/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            DashboardView()       
            .tabItem {
                Image(systemName: "film")
                Text("Movies")
            }
            SearchView()
            .tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
        }
    }
}
