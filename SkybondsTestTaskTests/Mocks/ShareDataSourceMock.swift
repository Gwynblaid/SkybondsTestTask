// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
@testable import SkybondsTestTask

class ShareDataSourceMock: ShareDataSourceProtocol {
	var shouldReturnError = false
	var requestCalled = false
	
	var data: [Double] = [2, 3]
	var error = NSError(domain: "test", code: 1, userInfo: nil)
	
	func getShareDataPrice(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void) {
		requestCalled = true
		if shouldReturnError {
			completion(.failure(self.error))
		} else {
			completion(.success(self.data))
		}
	}
	
	func getShareDataYeild(for isin: String, in period: Period, completion: (Result<[Double], Error>) -> Void) {
		requestCalled = true
		if shouldReturnError {
			completion(.failure(self.error))
		} else {
			completion(.success(self.data))
		}
	}
}
