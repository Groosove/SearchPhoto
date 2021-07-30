//
//  IndicatorView.swift
//  SearchPhoto
//
//  Created by Fenix Lavon on 7/29/21.
//

import UIKit

final class IndicatorView: UIView {
	private lazy var indicatorView: UIActivityIndicatorView = {
		let indicator = UIActivityIndicatorView(style: .large)
		indicator.color = .white
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
			self.addSubview(indicatorView)
			indicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
			indicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			indicatorView.startAnimating()
        } else {
			indicatorView.removeFromSuperview()
            indicatorView.stopAnimating()
        }
    }
}
