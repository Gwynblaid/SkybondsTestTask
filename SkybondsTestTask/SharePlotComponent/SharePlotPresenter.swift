// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

protocol SharePlotPresenterProtocol {
	
}

class SharePlotPresenter {
	weak var view: SharePlotViewProtocol?
	let interactor: SharePlotInteractorProtocol
	
	init(view: SharePlotViewProtocol, interactor: SharePlotInteractorProtocol) {
		self.view = view
		self.interactor = interactor
	}
}

extension SharePlotPresenter: SharePlotPresenterProtocol {
	
}

extension SharePlotPresenter: SharePlotInteractorDelegate {
	
}
