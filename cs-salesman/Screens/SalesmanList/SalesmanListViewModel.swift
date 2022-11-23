//
//  SalesmanListViewModel.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

import Combine
import Foundation

@MainActor
final class SalesmanListViewModel: ObservableObject {
    @Published
    var salesmen: [Salesman] = []
    @Published
    var salesmanQuery: String = ""

    private let salesmanRepo: SalesmanRepository
    private let salesmanMatcher: SalesmanMatcher
    private var allSalesmen: [Salesman] = []

    private var cancellables = Set<AnyCancellable>()

    init(salesmanRepo: SalesmanRepository, salesmanMatcher: SalesmanMatcher) {
        self.salesmanRepo = salesmanRepo
        self.salesmanMatcher = salesmanMatcher

        $salesmanQuery
            .removeDuplicates()
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { query in
                Task {
                    await self.updateSalesmen(matching: query)
                }
            }
            .store(in: &cancellables)
    }

    func fetchSalesmen() async {
        allSalesmen = await salesmanRepo.getSalesmen()
        await updateSalesmen(matching: "")
    }

    private func updateSalesmen(matching query: String) async {
        salesmen = await salesmanMatcher.match(
            query: query,
            salesmen: allSalesmen
        )
    }
}
