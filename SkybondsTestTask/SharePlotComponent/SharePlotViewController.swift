// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import UIKit
import Charts

protocol SharePlotViewProtocol: AnyObject {
	func configurePeriodButtons(with periods: [Period])
	
	func setSelectedPeriod(_ period: Period)
	// Можно передавать в роутер, здесь относится к отображению как View
	func showActionSheet(with title: String, actions: [UIAlertAction])
	func show(error: Error)
	func setDataTypeTitle(_ title: String)
	
	func plot(data: ShareDataView)
}

class SharePlotViewController: UIViewController {
	@IBOutlet private var chartView: LineChartView!
	@IBOutlet private var stackView: UIStackView!
	@IBOutlet private var dataTypeButton: UIButton!
	
	// Injections
	var presenter: SharePlotPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
		setupChartView()
		presenter.viewDidLoad()
    }
}

extension SharePlotViewController: SharePlotViewProtocol {
	func plot(data: ShareDataView) {
		let timeInterval = data.period.upperBound.timeIntervalSince(data.period.lowerBound) / TimeInterval(data.data.count)
		var iterator = data.period.lowerBound.timeIntervalSince1970
		
		let values: [ChartDataEntry] = data.data.map { value in
			defer { iterator += timeInterval }
			return ChartDataEntry(x: iterator, y: value)
		}
        
        let set1 = LineChartDataSet(entries: values, label: nil)
		set1.axisDependency = .left
		set1.drawCirclesEnabled = false
		set1.fillColor = .systemRed
		set1.highlightEnabled = false
		set1.lineWidth = 1.5
		set1.setColor(.systemRed)
		set1.drawValuesEnabled = true
		
		let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.black)
        data.setValueFont(.systemFont(ofSize: 11, weight: .bold))
		chartView.data = data
	}
	
	func setDataTypeTitle(_ title: String) {
		dataTypeButton.setTitle(title, for: .normal)
	}
	
	func setSelectedPeriod(_ period: Period) {
		for view in stackView.arrangedSubviews {
			guard let button = view as? UIButton else {
				continue
			}
			button.isSelected = button.tag == period.index
		}
	}
	
	func showActionSheet(with title: String, actions: [UIAlertAction]) {
		let actionSheet = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
		for action in actions {
			actionSheet.addAction(action)
		}
		present(actionSheet, animated: true, completion: nil)
	}
	
	func show(error: Error) {
		// Использую простой метод localizedDescription, но он не очень хорошо работает если нет localizedDescriptor-a(в таком случае лучше другая обработка)
		let alert = UIAlertController(title: NSLocalizedString("Error", comment: "Alert error title"), message: error.localizedDescription, preferredStyle: .alert)
		alert.addAction(.init(title: NSLocalizedString("OK", comment: "OK in alert controller"), style: .cancel, handler: nil))
		present(alert, animated: true, completion: nil)
	}
	
	func configurePeriodButtons(with periods: [Period]) {
		let views = stackView.arrangedSubviews
		for view in views {
			stackView.removeArrangedSubview(view)
		}
		for period in periods {
			let button = UIButton(type: .system)
			button.tag = period.index
			button.setTitle(period.rawValue, for: .normal)
			stackView.addArrangedSubview(button)
			button.addTarget(self, action: #selector(periodButtonTapped(_:)), for: .touchUpInside)
		}
	}
}

// Actions
extension SharePlotViewController {
	@objc func periodButtonTapped(_ sender: UIButton) {
		presenter.selectPeriod(at: sender.tag)
	}
	
	@IBAction func dataTypeTapped(_ sender: Any) {
		presenter.dataTypeTapped()
	}
	
	@IBAction func fullScreenTapped(_ sender: Any) {
		print("Say presenter that user want to show chart in fullscreen")
	}
}

private extension SharePlotViewController {
	func setupChartView() {
		chartView.legend.enabled = false
		chartView.isUserInteractionEnabled = false
		chartView.drawBordersEnabled = true
		chartView.borderColor = UIColor.lightGray.withAlphaComponent(0.2)
		
		chartView.xAxis.valueFormatter = DateValueFormatter(type: .day)
		chartView.xAxis.labelPosition = .bottomInside
		chartView.xAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
		
		chartView.rightAxis.enabled = false
		
		chartView.leftAxis.labelFont = .systemFont(ofSize: 12, weight: .bold)
		chartView.leftAxis.spaceTop = 0.6
		chartView.leftAxis.spaceBottom = 0.2
	}
}
