//
//  PlayingCardView.swift
//  PlayingCard
//
//  Created by Elton Lin on 5/25/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

@IBDesignable
class PlayingCardView: UIView {
    
    var rank = 11 { didSet { setNeedsDisplay(); setNeedsLayout() }}
    var suit = "♥️" { didSet { setNeedsDisplay(); setNeedsLayout() }}
    var isFaceUp = true { didSet { setNeedsDisplay(); setNeedsLayout() }}
    
    private var corneredString: NSAttributedString {
        return centeredAttributedString(string: rankString + "\n" + suit, fontSize: cornerFontSize)
    }
    
    private lazy var topLeftCornerLabel = createCornerLabel()
    private lazy var botLeftCornerLabel = createCornerLabel()
    
    private func createCornerLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        // it's just a Swift structure for now that abstractly exists - add it to the view
        addSubview(label)
        return label
    }
    
    private func configureCornerLabel(_ label: UILabel) {
        label.attributedText = corneredString
        label.frame.size = CGSize.zero // a trick, without it sizeToFit() doesn't always work properly
        label.sizeToFit()
        label.isHidden = !isFaceUp
    }
    
    // if user changes font size from settings, the app detects the change immediately and redraws
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    // it is the equivalent of draw() for setNeedsLayout
    override func layoutSubviews() {
        super.layoutSubviews()
        configureCornerLabel(topLeftCornerLabel)
        configureCornerLabel(botLeftCornerLabel)
        
        topLeftCornerLabel.frame.origin = bounds.origin.offsetBy(dx: cornerOffset, dy: cornerOffset)
        
        botLeftCornerLabel.transform = CGAffineTransform.identity
            .translatedBy(x: botLeftCornerLabel.bounds.width, y: botLeftCornerLabel.bounds.height)
            .rotated(by: CGFloat.pi)
        
        botLeftCornerLabel.frame.origin = CGPoint(x: bounds.maxX, y: bounds.maxY)
            .offsetBy(dx: -cornerOffset, dy: -cornerOffset)
            .offsetBy(dx: -botLeftCornerLabel.bounds.width, dy: -botLeftCornerLabel.bounds.height)
    }
    
    private func centeredAttributedString(string: String, fontSize: CGFloat) -> NSAttributedString {
        var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
        font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        return NSAttributedString(string: string, attributes: [.paragraphStyle: paragraphStyle, .font: font])
    }
    
    override func draw(_ rect: CGRect) {
        let roundedRect = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        roundedRect.fill()
        
        if isFaceUp {
            if let facedImage = UIImage(named: rankString+suit, in: Bundle(for: self.classForCoder), compatibleWith: traitCollection) {
                facedImage.draw(in: bounds.zoom(by: SizeRatio.faceCardImageSizeToBoundsSize))
            }
        } else {
            if let cardBackImage = UIImage(named: "cardback") {
                cardBackImage.draw(in: bounds)
            }
        }
       
    }
}

// helpers
extension PlayingCardView {
    private struct SizeRatio {
        static let cornerFontSizeToBoundsHeight: CGFloat = 0.085
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let cornerOffsetToCornerRadius: CGFloat = 0.33
        static let faceCardImageSizeToBoundsSize: CGFloat = 0.75
    }
    
    // computed properties that are derived from the constants
    private var cornerRadius: CGFloat {
        return bounds.size.height * SizeRatio.cornerRadiusToBoundsHeight
    }
    
    private var cornerOffset: CGFloat {
        return cornerRadius * SizeRatio.cornerOffsetToCornerRadius
    }
    
    private var cornerFontSize: CGFloat {
        return bounds.size.height * SizeRatio.cornerFontSizeToBoundsHeight
    }
    
    private var rankString: String {
        switch rank {
        case 1: return "A"
        case 2...10: return String(rank)
        case 11: return "J"
        case 12: return "Q"
        case 13: return "K"
        default: return "?"
        }
    }
}

extension CGRect {
    var leftHalf: CGRect {
        return CGRect(x: minX, y: minY, width: width/2, height: height)
    }
    
    var rightHalf: CGRect {
        return CGRect(x: midX, y: minY, width: width/2, height: height)
    }
    
    func inset(by size: CGSize) -> CGRect {
        return insetBy(dx: size.width, dy: size.height)
    }
    
    func sized(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
    
    func zoom(by scale: CGFloat) -> CGRect {
        let newWidth = width * scale
        let newHeight = height * scale
        return insetBy(dx: (width - newWidth) / 2, dy: (height - newHeight) / 2)
    }
}

extension CGPoint {
    func offsetBy(dx: CGFloat, dy: CGFloat) -> CGPoint {
        return CGPoint(x: x+dx, y: y+dy)
    }
}
