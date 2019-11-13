// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
import Charts

class DateValueFormatter: IAxisValueFormatter {
	enum FormatType {
		case day
		case month
	}
	
	private let dateFormatter: DateFormatter
    
	init(type: FormatType) {
		dateFormatter = DateFormatter()
		switch type {
		case .day:
			dateFormatter.dateFormat = "dd.MM"
		case .month:
			dateFormatter.dateFormat = "MM.yy"
		}
	}
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}
