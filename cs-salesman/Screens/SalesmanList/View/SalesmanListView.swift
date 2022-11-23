//
//  SalesmanListView.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

import SwiftUI

struct SalesmanListView: View {
    @StateObject
    private var viewModel: SalesmanListViewModel

    init(
        salesmanRepo: SalesmanRepository,
        salesmanMatcher: SalesmanMatcher
    ) {
        self._viewModel = StateObject(
            wrappedValue: SalesmanListViewModel(
                salesmanRepo: salesmanRepo,
                salesmanMatcher: salesmanMatcher
            )
        )
    }

    var body: some View {
        NavigationStack {
            List(viewModel.salesmen, id: \.name) { salesman in
                SalesmanListItemView(salesman: salesman)
                    .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
            }
            .searchable(text: $viewModel.salesmanQuery, prompt: "Suche")
            .listStyle(PlainListStyle())
            .buttonStyle(PlainButtonStyle())
            .navigationTitle("Adressen")
            .navigationBarTitleDisplayMode(.inline)
//            .toolbarBackground(Color("NavigationBarBackground"), for:
//            .navigationBar)
//            .toolbarBackground(.visible, for: .navigationBar)
        }
        .onAppear {
            Task { await viewModel.fetchSalesmen() }
        }
    }
}

struct SalesmanListView_Previews: PreviewProvider {
    static var previews: some View {
        SalesmanListView(
            salesmanRepo: CSSalesmanRepository(),
            salesmanMatcher: PostcodeSalesmanMatcher()
        )
    }
}
