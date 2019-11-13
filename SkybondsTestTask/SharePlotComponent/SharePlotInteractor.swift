// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

protocol SharePlotInteractorProtocol {
	func updateData()
	
	var isin: String {get set}
	var period: Period {get set}
	var dataType: DataType {get set}
}

protocol SharePlotInteractorDelegate: AnyObject {
	func updateDataFinished(with result: Result<ShareDataView, Error>)
}


class SharePlotInteractor {
	// Injections
	let dataSource: ShareDataSourceProtocol
	weak var delegate: SharePlotInteractorDelegate?
	
	var isin: String {
		didSet {
			requestShareData()
		}
	}
	var period: Period = .week {
		didSet {
			requestShareData()
		}
	}
	var dataType: DataType = .price {
		didSet {
			requestShareData()
		}
	}
	
	init(dataSource: ShareDataSourceProtocol, isin: String) {
		self.dataSource = dataSource
		self.isin = isin
	}
}

private extension SharePlotInteractor {
	// Так же можно организовать кэширование результатов, но для простоты этого делать не будем
	func requestShareData() {
		let completion: (Result<[Double], Error>) -> Void = { [weak self] result in
			guard let self = self else { return }
			switch result {
			case let .success(values):
				let date = Date()
				let timeInterval = self.period.timeInterval(to: date)
				let period = (date - timeInterval)...date
				self.delegate?.updateDataFinished(with: .success(ShareDataView(data: values, period: period)))
			case let .failure(error):
				self.delegate?.updateDataFinished(with: .failure(error))
			}
		}
		switch dataType {
		case .price:
			dataSource.getShareDataPrice(for: isin, in: period, completion: completion)
		case .yeild:
			dataSource.getShareDataYeild(for: isin, in: period, completion: completion)
		}
	}
}

extension SharePlotInteractor: SharePlotInteractorProtocol {
	func updateData() {
		requestShareData()
	}
}
