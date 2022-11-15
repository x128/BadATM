//
//  ViewController.swift
//  ATM
//
//  Created by Dmitry Isaev on 14/11/2022.
//

import UIKit

final class ViewController: UIViewController {
	@IBOutlet weak var balanceLabel: UILabel!
	@IBOutlet weak var receiptLabel: UILabel!

	private let repository = Repository(amount: 10_000)

	override func viewDidLoad() {
		super.viewDidLoad()

		showBalance(repository.amount)
//		updateBalanceWithNewInterestRate()
	}

	@IBAction func withdraw(_ sender: UIControl) {
		let oldAmount = repository.amount
		let newAmount = oldAmount - 100
		repository.amount = newAmount

		showBalance(newAmount)
		showReceipt(oldBalance: oldAmount, newBalance: newAmount)
	}
}

private extension ViewController {
	func showBalance(_ balance: Float) {
		balanceLabel.text = "Ваш баланс: \(balance)"
	}

	func showReceipt(oldBalance: Float, newBalance: Float) {
		receiptLabel.text = """
	ЧЕК ПО ОПЕРАЦИИ
=======================
	Снятие наличных

Баланс до:    \(oldBalance)
Баланс после: \(newBalance)

=======================
		СПАСИБО!
"""
	}
}

private extension ViewController {
	func updateBalanceWithNewInterestRate() {
		let oldAmount = repository.amount

		NetService.getCurrentRate { [weak self] rate in
			guard let self = self else { return }

			if let rate = rate {
				let newAmount = RateInterestCalculator.calcNewAmount(oldAmount: oldAmount,
																	 rate: rate)
				self.repository.amount = newAmount
				self.showBalance(newAmount)
			}

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
				self.updateBalanceWithNewInterestRate()
			}
		}
	}
}
