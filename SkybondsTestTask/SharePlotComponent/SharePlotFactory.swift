// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
import UIKit

protocol SharePlotFactoryProtocol {
	func sharePlotViewController(with ISIN: String) -> SharePlotViewController
}

class SharePlotFactory: SharePlotFactoryProtocol {
	let shareDataSource: ShareDataSourceProtocol
	let storyboard: UIStoryboard?
	
	init(shareDataSource: ShareDataSourceProtocol, storyboard: UIStoryboard?) {
		self.shareDataSource = shareDataSource
		self.storyboard = storyboard
	}
	
	func sharePlotViewController(with ISIN: String) -> SharePlotViewController {
		guard let viewController = storyboard?.instantiateViewController(withIdentifier: "SharePlotViewController") as? SharePlotViewController else {
			fatalError("Can't instanciate SharePlotViewController from:\(String(describing: storyboard)) with identifier: SharePlotViewController")
		}
		let interactor = SharePlotInteractor(dataSource: shareDataSource)
		interactor.shareID = ISIN
		let presenter = SharePlotPresenter(view: viewController, interactor: interactor)
		viewController.presenter = presenter
		interactor.delegate = presenter
		return viewController
	}
}
