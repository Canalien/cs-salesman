//
//  cs_salesmanTests.swift
//  cs-salesmanTests
//
//  Created by Canalien on 23.11.22.
//

@testable import cs_salesman
import XCTest

final class cs_salesmanTests: XCTestCase {
    let salesman1 = Salesman(name: "Test", areas: ["12345"])
    let salesman2 = Salesman(name: "Test", areas: ["1234*"])
    let salesman3 = Salesman(name: "Test", areas: ["123*"])
    let salesman4 = Salesman(name: "Test", areas: ["12345", "12355"])

    var allSalesmen: [Salesman] {
        [
            salesman1,
            salesman2,
            salesman3,
            salesman4,
        ]
    }

    let matcher = PostcodeSalesmanMatcher()

    func testPostcodeSalesmanMatcher1() async throws {
        let results = await matcher.match(query: "12345", salesmen: allSalesmen)
        XCTAssertEqual(results, [salesman1, salesman4])
    }

    func testPostcodeSalesmanMatcher2() async throws {
        let results = await matcher.match(query: "1234*", salesmen: allSalesmen)
        XCTAssertEqual(results, [salesman1, salesman2, salesman4])
    }

    func testPostcodeSalesmanMatcher3() async throws {
        let results = await matcher.match(query: "123*", salesmen: allSalesmen)
        XCTAssertEqual(results, [salesman1, salesman2, salesman3, salesman4])
    }

    func testPostcodeSalesmanMatcher4() async throws {
        let results = await matcher.match(query: "123*", salesmen: allSalesmen)
        XCTAssertEqual(results, [salesman1, salesman2, salesman3, salesman4])
    }

    func testPostcodeSalesmanMatcher5() async throws {
        let results = await matcher.match(query: "123*1", salesmen: allSalesmen)
        XCTAssertEqual(results, [])
    }

    func testPostcodeSalesmanMatcher6() async throws {
        let results = await matcher.match(query: "12a", salesmen: allSalesmen)
        XCTAssertEqual(results, [])
    }

    func testPostcodeSalesmanMatcher7() async throws {
        let results = await matcher.match(query: "1234", salesmen: allSalesmen)
        XCTAssertEqual(results, [])
    }

    func testPostcodeSalesmanMatcher8() async throws {
        let results = await matcher.match(query: "", salesmen: allSalesmen)
        XCTAssertEqual(results, allSalesmen)
    }
    
    func testPostcodeSalesmanMatcher9() async throws {
        let results = await matcher.match(query: "*", salesmen: allSalesmen)
        XCTAssertEqual(results, [])
    }
}
