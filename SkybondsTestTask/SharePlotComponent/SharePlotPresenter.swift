// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
import UIKit

protocol SharePlotPresenterProtocol {
	func viewDidLoad()
	func selectPeriod(at index: Int)
	func dataTypeTapped()
}

class SharePlotPresenter {
	weak var view: SharePlotViewProtocol?
	var interactor: SharePlotInteractorProtocol
	
	init(view: SharePlotViewProtocol, interactor: SharePlotInteractorProtocol) {
		self.view = view
		self.interactor = interactor
	}
}

extension SharePlotPresenter: SharePlotPresenterProtocol {
	func viewDidLoad() {
		view?.configurePeriodButtons(with: Period.allCases)
		view?.setSelectedPeriod(interactor.period)
		view?.setDataTypeTitle(interactor.dataType.rawValue)
		interactor.updateData()
	}
	
	func selectPeriod(at index: Int) {
		let period = Period.allCases[index]
		view?.setSelectedPeriod(period)
		interactor.period = period
	}
	
	func dataTypeTapped() {
		let actions = DataType.allCases.map { type in
			UIAlertAction(title: type.rawValue, style: .default) { [weak self] _ in
				guard let self = self else {
					return
				}
				self.view?.setDataTypeTitle(type.rawValue)
				self.interactor.dataType = type
			}
		}
		view?.showActionSheet(with: NSLocalizedString("Select data type", comment: "Select data type actio sheet"), actions: actions)
	}
}

extension SharePlotPresenter: SharePlotInteractorDelegate {
	func updateDataFinished(with result: Result<ShareDataView, Error>) {
		DispatchQueue.main.async { [weak self] in
			switch result {
			case let .success(data):
				self?.view?.plot(data: data)
			case let .failure(error):
				self?.view?.show(error: error)
			}
		}
	}
}
