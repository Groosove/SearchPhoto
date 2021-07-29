//
//  IndicatorView.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/29/21.
//

import UIKit

final class IndicatorView: UIView {
	private lazy var indicator : UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .large)
		indicator.translatesAutoresizingMaskIntoConstraints = false
		return indicator
	}()
	
	var isLoading = false {
        didSet {
            guard oldValue != isLoading else { return }
            showSpinner(isShown: isLoading)
        }
    }

    private func showSpinner(isShown: Bool) {
        if isShown {
			self.addSubview(indicator)
			indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
			indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			indicator.startAnimating()
        } else {
			indicator.removeFromSuperview()
            indicator.stopAnimating()
        }
    }
}
