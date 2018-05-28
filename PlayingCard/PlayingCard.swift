//
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Elton Lin on 5/24/18.
//  Copyright © 2018 MIT. All rights reserved.
//

import Foundation

struct PlayingCard: CustomStringConvertible {
    
    var description: String {
        return "\(suit)\(rank)"
    }
    
    var suit: Suit
    var rank: Rank
    
    enum Suit: String, CustomStringConvertible {
        
        var description: String {
            return rawValue
        }
        
        case spades = "♠️"
        case diamond = "♦️"
        case club = "♣️"
        case heart = "♥️"
        
        static var all = [Suit.spades, .diamond, .club, .heart]
    }
    
    enum Rank: CustomStringConvertible {
        
        var description: String {
            switch self {
            case .ace: return "Ace"
            case .numeric(let pip): return String(pip)
            case .face(let type): return type
            }
        }
        
        case ace
        case face(String)
        case numeric(Int)
        
        var order: Int {
            switch self {
                case .ace: return 1
                case .numeric(let pip): return pip
                case .face(let kind) where kind == "J": return 11
                case .face(let kind) where kind == "Q": return 12
                case .face(let kind) where kind == "K": return 13
                default: return 0
            }
        }
        
        static var all: [Rank] {
            var allRanks = [Rank.ace]
            for pips in 2...10 {
                allRanks.append(Rank.numeric(pips))
            }
        allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            return allRanks
        }
    }
    
}
