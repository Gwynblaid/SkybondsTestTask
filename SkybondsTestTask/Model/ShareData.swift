// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

enum Period: String, CaseIterable {
	case week = "1W"
	case month = "1M"
	case month3 = "3M"
	case halfYear = "6M"
	case year = "1Y"
	case year2 = "2Y"
}

enum Interval {
	case day
	case month
}

extension TimeInterval {
	static var hour: TimeInterval = 3600
	static var day: TimeInterval = .hour * 24
	static var week: TimeInterval = .day * 7
}

protocol ShareDataSourceProtocol {
	/// Get share prices in time period before current Date
	/// - Parameter period: time period
	/// - Parameter isin: share ISIN
	/// - Parameter interval: interval for prices
	/// - Parameter completion: completion closure from data source(api, local data, etc..)
	func getShareDataPrice(for isin: String, in period: Period, with interval: Interval, completion: (Result<Double, Error>) -> Void)
	/// Get share yeild in time period before current Date
	/// - Parameter period: time period
	/// - Parameter isin: share ISIN
	/// - Parameter interval: interval for yeilds
	/// - Parameter completion: completion closure from data source(api, local data, etc..)
	func getShareDataYeild(for isin: String, in period: Period, with interval: Interval, completion: (Result<Double, Error>) -> Void)
}

class RandomShareDataSource: ShareDataSourceProtocol {
	func getShareDataYeild(for isin: String, in period: Period, with interval: Interval, completion: (Result<Double, Error>) -> Void) {
		
	}
	
	func getShareDataPrice(for isin: String, in period: Period, with interval: Interval, completion: (Result<Double, Error>) -> Void) {
		
	}
}



struct ShareDataView {
	enum DataType {
		case price
		case yeild
	}
	
	let dataType: DataType
	let data: [Double]
	let endDate: Date
	let interval: Interval
	let period: Period
}
