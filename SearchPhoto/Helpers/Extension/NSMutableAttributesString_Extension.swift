//
//  NSMutableAttributesString_Extension.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 7/28/21.
//

import UIKit

extension NSMutableAttributedString {
	func setColorForText(textForAttribute: String, withColor color: UIColor) {
		let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
		self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
	}
}
