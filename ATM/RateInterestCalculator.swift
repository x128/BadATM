//
//  RateInterestCalculator.swift
//  ATM
//
//  Created by Dmitry Isaev on 14/11/2022.
//

enum RateInterestCalculator {
	/**
	Вычисляет новое значение остатка на счету: берёт предыдущее значение и начисляет проценты
	на основе уровня ключевой ставки ЕЦБ на текущий день.
	 - Parameters:
	    - oldAmount: Предыдущий остаток
	    - rate: Текущий уровень ставки
	*/
	static func calcNewAmount(oldAmount: Float, rate: Float) -> Float {
		oldAmount * (1 + rate / 365 / 24)
	}
}
