//
//  SalesmanRepository.swift
//  cs-salesman
//
//  Created by Canalien on 23.11.22.
//

protocol SalesmanRepository {
    func getSalesmen() async -> [Salesman]
}

final class CSSalesmanRepository: SalesmanRepository {
    private let salesmen = [
        Salesman(name: "Artem Titarenko", areas: ["76133","76133","76133","76133","76133","76133","76133","76133","76133","76133","76133"]),
        Salesman(name: "Bernd Schmitt", areas: ["7619*"]),
        Salesman(name: "Chris Krapp", areas: ["762*"]),
        Salesman(name: "Alex Uber", areas: ["86*"]),
    ]

    func getSalesmen() async -> [Salesman] {
        salesmen
    }
}
