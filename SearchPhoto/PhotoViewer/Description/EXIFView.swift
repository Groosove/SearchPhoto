//
//  EXIFView.swift
//  SearchPhoto
//
//  Created by Артур Лутфуллин on 14.07.2021.
//

import UIKit

class EXIFView: UIView {
	let model: Exif?
	
	private lazy var makeLabel: UILabel = {
		let label = createMetaDataLabel(title: "Make\n", data: model?.make ?? "--")
		return label
	}()
	
	private lazy var modelLabel: UILabel = {
        let label = createMetaDataLabel(title: "Model\n", data: model?.model ?? "--")
		return label
	}()
	
	private lazy var shutterLabel: UILabel = {
		let label = createMetaDataLabel(title: "Shutter Speed\n", data: (model?.exposure_time ?? "--" + "s"))
		return label
	}()
	
	private lazy var focalLabel: UILabel = {
		let label = createMetaDataLabel(title: "Focal Length\n", data: model?.focal_length ?? "--")
		return label
	}()
	
	private lazy var isoLabel: UILabel = {
        let data = (model?.iso == nil) ? "--" : String(model!.iso)
        let label = createMetaDataLabel(title: "ISO\n", data: data)
		return label
	}()
	
	private lazy var apertureLabel: UILabel = {
		let label = createMetaDataLabel(title: "Apperture\n", data: model?.aperture ?? "--")
		return label
	}()
	
	init(model: Exif?) {
		self.model = model
		super.init(frame: UIScreen.main.bounds)
		addSubviews()
		makeConstraints()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	
	private func addSubviews() {
		addSubview(makeLabel)
		addSubview(modelLabel)
		addSubview(shutterLabel)
		addSubview(focalLabel)
		addSubview(isoLabel)
		addSubview(apertureLabel)
	}
	
	private func makeConstraints() {
		let makeLabelConstraints = [
			makeLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			makeLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
		]
		
		let modelLabelConstraints = [
			modelLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			modelLabel.topAnchor.constraint(equalTo: makeLabel.bottomAnchor, constant: 5),
		]
		
		let shutterLabelConstraints = [
			shutterLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
			shutterLabel.topAnchor.constraint(equalTo: modelLabel.bottomAnchor, constant: 5),
		]
		
		let apertureLabelConstraints = [
			apertureLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
			apertureLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
			apertureLabel.centerXAnchor.constraint(equalTo: focalLabel.centerXAnchor)
		]
		
		let focalLabelConstraints = [
			focalLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
			focalLabel.topAnchor.constraint(equalTo: apertureLabel.bottomAnchor, constant: 5),
		]
		
		let isoLabelConstraints = [
			isoLabel.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
			isoLabel.topAnchor.constraint(equalTo: focalLabel.bottomAnchor, constant: 5),
			isoLabel.centerXAnchor.constraint(equalTo: focalLabel.centerXAnchor)
		]
		
		NSLayoutConstraint.activate(makeLabelConstraints)
		NSLayoutConstraint.activate(modelLabelConstraints)
		NSLayoutConstraint.activate(shutterLabelConstraints)
		NSLayoutConstraint.activate(apertureLabelConstraints)
		NSLayoutConstraint.activate(focalLabelConstraints)
		NSLayoutConstraint.activate(isoLabelConstraints)
	}
	
	private func createMetaDataLabel(title: String, data: String) -> UILabel {
		let label = UILabel()
		let text = NSMutableAttributedString(string: title + data)
		label.lineBreakMode = .byWordWrapping
		label.numberOfLines = 2
		text.setColorForText(textForAttribute: title, withColor: .systemGray)
		text.setColorForText(textForAttribute: data, withColor: .white)
		label.attributedText = text
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}
}

extension NSMutableAttributedString {

	func setColorForText(textForAttribute: String, withColor color: UIColor) {
		let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
		self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
	}

}
