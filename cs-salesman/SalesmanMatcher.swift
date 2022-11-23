//
//  SalesmanMatcher.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

protocol SalesmanMatcher {
    func match(query: String, salesmen: [Salesman]) async -> [Salesman]
}

struct PostcodeSalesmanMatcher: SalesmanMatcher {
    private static let wildcard: Character = "*"
    
    func match(query: String, salesmen: [Salesman]) async -> [Salesman] {
        guard !query.isEmpty else { return salesmen }
        
        let cleanedQuery = String(query.prefix { $0 != Self.wildcard })
        
        guard cleanedQuery.isNumber else { return [] }
        guard cleanedQuery.count == 5 || (cleanedQuery.count < 5 && query.last == Self.wildcard) else { return [] }

        return salesmen.filter { salesman in
            salesman.areas.contains { postcode in
                let cleanedPostcode = postcode.prefix { $0 != Self.wildcard }
                return cleanedPostcode.starts(with: cleanedQuery)
            }
        }
    }
}

private extension String {
     var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: .decimalDigits.inverted) == nil
    }
}
