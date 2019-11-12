// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

protocol SharePlotInteractorProtocol {
	
}

protocol SharePlotInteractorDelegate: AnyObject {
	
}

class SharePlotInteractor {
	// Injections
	let dataSource: ShareDataSourceProtocol
	weak var delegate: SharePlotInteractorDelegate?
	
	var shareID: String?
	
	init(dataSource: ShareDataSourceProtocol) {
		self.dataSource = dataSource
	}
}

extension SharePlotInteractor: SharePlotInteractorProtocol {
	
}
