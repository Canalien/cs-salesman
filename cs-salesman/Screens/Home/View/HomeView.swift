//
//  HomeView.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(
                destination: SalesmanListView(
                    salesmanRepo: CSSalesmanRepository(),
                    salesmanMatcher: PostcodeSalesmanMatcher()
                )
            ) {
                Text("weiter")
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(
                Color("NavigationBarBackground"),
                for: .navigationBar
            )
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
