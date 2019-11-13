// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation

struct ShareDataView {
	let data: [Double]
	let period: ClosedRange<Date>
}

enum DataType: String, CaseIterable {
	case price = "PRICE"
	case yeild = "YEILD"
}
