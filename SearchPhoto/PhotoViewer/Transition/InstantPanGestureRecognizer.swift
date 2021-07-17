//
//  InstantPanGestureRecognizer.swift
//  SearchPhoto
//
//  Created by Artur Lutfullin on 14.07.2021.
//

import UIKit

class InstantPanGestureRecognizer: UIPanGestureRecognizer {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == .began) { return }
        super.touchesBegan(touches, with: event)
        self.state = .began
    }
}
