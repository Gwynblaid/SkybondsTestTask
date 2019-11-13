// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
@testable import SkybondsTestTask

class SharePlotInteractorDelegateMock: SharePlotInteractorDelegate {
	var error: Error?
	var dataView: ShareDataView?
	
	func updateDataFinished(with result: Result<ShareDataView, Error>) {
		self.dataView = nil
		self.error = nil
		switch result {
		case let .success(dataView):
			self.dataView = dataView
		case let .failure(error):
			self.error = error
		}
	}
}
