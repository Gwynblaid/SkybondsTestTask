// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

// В данном протоколе я закладываю то что условное API просто возвращает значения с периодом в 1 день до даты запроса(эти два параметра можно передать и сделать более гибким)
protocol ShareDataSourceProtocol {
	/// Get share prices in time period before current Date
	/// - Parameter period: time period
	/// - Parameter isin: share ISIN
	/// - Parameter completion: completion closure from data source(api, local data, etc..)
	func getShareDataPrice(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void)
	/// Get share yeild in time period before current Date
	/// - Parameter period: time period
	/// - Parameter isin: share ISIN
	/// - Parameter completion: completion closure from data source(api, local data, etc..)
	func getShareDataYeild(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void)
}
