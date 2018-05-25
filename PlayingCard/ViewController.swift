//
//  ViewController.swift
//  PlayingCard
//
//  Created by Elton Lin on 5/24/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var deck = PlayingCardDeck()
        for _ in 1...10 {
            if let card = deck.draw() {
                print("\(card)")
            }
        }
    }

 
}

