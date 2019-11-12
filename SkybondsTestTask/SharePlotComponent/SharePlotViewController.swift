// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import UIKit
import Charts

protocol SharePlotViewProtocol: AnyObject {
	
}

class SharePlotViewController: UIViewController {
	@IBOutlet private var chartView: LineChartView!
	
	// Injections
	var presenter: SharePlotPresenterProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
		setupChartView()
		
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SharePlotViewController: SharePlotViewProtocol {
	
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
		
		
		let now = Date()
		let from: TimeInterval = now.timeIntervalSince1970 - 5 * .day
		let to: TimeInterval = Date().timeIntervalSince1970
        
		let values = stride(from: from, to: to, by: .day).map { (x) -> ChartDataEntry in
			let y = 300 + Int.random(in: 0...10)
            return ChartDataEntry(x: x, y: Double(y))
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
}
