// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

enum Period: String, CaseIterable {
	case week = "1W"
	case month = "1M"
	case month3 = "3M"
	case halfYear = "6M"
	case year = "1Y"
	case year2 = "2Y"
}

extension Period: Comparable {
	static func < (lhs: Period, rhs: Period) -> Bool {
		guard let lhsIndex = Period.allCases.firstIndex(of: lhs), let rhsIndex = Period.allCases.firstIndex(of: rhs) else {
			fatalError("Lhs and rhs should be in Period.allCases array")
		}
		return lhsIndex < rhsIndex
	}
}

extension Period {
	var index: Int {
		guard let index = Period.allCases.firstIndex(of: self) else {
			fatalError("allCases should contains \(self)")
		}
		return index
	}
	
	func timeInterval(to date: Date) -> TimeInterval {
		
		switch self {
		case .week:
			return .week
		default:
			let componentValue = dateComponentValue
			guard let previousDate = Calendar.current.date(byAdding: componentValue.0, value: componentValue.1, to: date) else {
				fatalError("Can't get previous date")
			}
			return date.timeIntervalSince(previousDate)
		}
	}
	
	private var dateComponentValue: (Calendar.Component, Int) {
		var component: Calendar.Component
		switch self {
		case .week:
			component = .weekOfYear
		case .month, .month3, .halfYear:
			component = .month
		case .year, .year2:
			component = .year
		}
		switch self {
		case .week, .month, .year:
			return (component, -1)
		case .month3:
			return (component, -3)
		case .halfYear:
			return (component, -6)
		case .year2:
			return (component, -2)
		}
	}
}
