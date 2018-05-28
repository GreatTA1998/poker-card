//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Elton Lin on 5/25/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        UIColor.white.setFill()
        roundedRect.fill()
    }
}
