// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

class RandomShareDataSource: ShareDataSourceProtocol {
	private var yearDividend = 0.0
	private var rates: [Double] = []
	private var isin: String?
	private var currenPeriod: Period = .week
	
	func getShareDataYeild(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void) {
		if self.isin != isin || period != currenPeriod {
			getShareDataPrice(for: isin, in: period) {_ in }
		}
		let devidend = yearDividend
		completion(.success(rates.map { devidend / $0 * 100 }))
	}
	
	func getShareDataPrice(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void) {
		if self.isin == isin && period == currenPeriod {
			completion(.success(rates))
			return
		}
		let lowerRate = Double.random(in: 6...20)
		let hightRate = Double.random(in: 21...60)
		let count = Int(period.timeInterval(to: Date()) / TimeInterval.day)
		rates = .init(repeating: 0, count: count)
		rates = rates.map {_ in 
			Double.random(in: lowerRate...hightRate)
		}
		yearDividend = .random(in: 0.2...3)
		currenPeriod = period
		self.isin = isin
		completion(.success(rates))
	}
}
