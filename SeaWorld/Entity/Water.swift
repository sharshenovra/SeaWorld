//
//  Water.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation

struct Water: ActorsProtocol{
    var hp: Int = 0
    
    mutating func reverseHp() {
    }
    
    mutating func decreaseHp() {
    }
    mutating func resetSteps() {
    }
    var x: Int
    
    var y: Int
    
    var steps: Int? = nil
    let name: Actors = .Empty
    
    
    mutating func addStep(num: Int) {
    }

    mutating func setXandY(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}
