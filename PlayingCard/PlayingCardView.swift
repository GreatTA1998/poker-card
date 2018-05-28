//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Elton Lin on 5/25/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class PlayingCardView: UIView {
    
    var rank = 9 { didSet { setNeedsDisplay() }}
    var suit = "♥︎" { didSet { setNeedsDisplay() }}
    var isFaceUp = true { didSet { setNeedsDisplay() }}
    
    private var corneredString: NSAttributedString {
        return centeredAttributedString(string: "9" + "\n" + "♥︎", fontSize: 16.0)
    }
    
    private func centeredAttributedString(string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: 16.0)
        UIColor.white.setFill()
        roundedRect.fill()
    }
}
