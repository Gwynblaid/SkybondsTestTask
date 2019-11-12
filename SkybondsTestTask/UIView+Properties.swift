// Copyright (C) Sergey Kharchenko, 2019 . All rights reserved.
// Автор: Sergey Kharchenko
// Описание: @warning добавить описание

import Foundation
import UIKit

extension UIView {
	@IBInspectable var cornerRadius: CGFloat {
		set {
			layer.cornerRadius = newValue
		}
		get {
			layer.cornerRadius
		}
	}
	
	@IBInspectable var shadowRadius: CGFloat {
		set {
			layer.shadowRadius = newValue
		}
		get {
			layer.shadowRadius
		}
	}
	
	@IBInspectable var shadowColor: UIColor? {
		set {
			layer.shadowColor = newValue?.cgColor
		}
		get {
			if let color = layer.shadowColor {
				return UIColor(cgColor: color)
			}
			return nil
		}
	}
	@IBInspectable var shadowOpacity: Float {
		set {
			layer.shadowOpacity = newValue
		}
		get {
			layer.shadowOpacity
		}
	}
	
	@IBInspectable var shadowOffset: CGSize {
		set {
			layer.shadowOffset = newValue
		}
		get {
			layer.shadowOffset
		}
	}
}
