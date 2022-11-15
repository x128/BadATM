//
//  RepositoryTests.swift
//  ATMTests
//
//  Created by Dmitry Isaev on 14/11/2022.
//

import XCTest
@testable import ATM

final class RepositoryTests: XCTestCase {
	func testAsyncIncrease() {
		// given
		let repeatCount = 100_000
		let repository = Repository(amount: 0)

		let expectation = expectation(description: "RepositoryUpdateExpectation")
		expectation.expectedFulfillmentCount = repeatCount

		// when
		for _ in 0 ..< repeatCount {
			DispatchQueue.global().async {
				repository.amount = repository.amount + 1
				expectation.fulfill()
			}
		}
		waitForExpectations(timeout: 1)

		// then
		XCTAssertEqual(repository.amount, Float(repeatCount))
	}
}
