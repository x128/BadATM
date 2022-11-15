//
//  NetService.swift
//  ATM
//
//  Created by Dmitry Isaev on 14/11/2022.
//

import Foundation

enum ApiUrl: String {
	case rate = "https://x128.ru/rate.php"
}

enum NetService {
	static func getCurrentRate(completion: @escaping (Float?) -> Void) {
		guard let url = URL(string: ApiUrl.rate.rawValue) else {
			assertionFailure("Bad url")
			completion(nil)
			return
		}

		let task = URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data,
				  let result = String(data: data, encoding: .utf8),
				  let rate = Float(result) else {
				completion(nil)
				return
			}
			completion(rate)
		}
		task.resume()
	}
}
