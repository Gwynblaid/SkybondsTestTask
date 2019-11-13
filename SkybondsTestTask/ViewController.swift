// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import UIKit

/*
	Данный класс не буду реализовывать как модуль VIPER, чтобы не усложнять код, использую MVC.
	Этот класс простая точка входа, для демострации как работать с SharePlot
*/

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		presentSharePlot()
	}
	
	private func presentSharePlot() {
		let factory = SharePlotFactory(shareDataSource: RandomShareDataSource(), storyboard: storyboard)
		let viewController = factory.sharePlotViewController(with: "My id")
		addChild(viewController)
		viewController.view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(viewController.view)
		view.leftAnchor.constraint(equalTo: viewController.view.leftAnchor).isActive = true
		view.rightAnchor.constraint(equalTo: viewController.view.rightAnchor).isActive = true
		view.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor).isActive = true
		viewController.view.addConstraint(.init(item: viewController.view!, attribute: .height, relatedBy: .equal, toItem: viewController.view, attribute: .width, multiplier: 1, constant: 0))
	}
}

