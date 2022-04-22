//
//  Pinguin.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation

struct Pinguin: ActorsProtocol{
    var hp: Int = 0
    
    mutating func reverseHp() {}
    
    mutating func decreaseHp() {}
    mutating func resetSteps() {
        self.steps = 0
    }
    var x: Int
    
    var y: Int
    
    var steps: Int? = 0
    
    let name: Actors = .Pinguin
    
    mutating func addStep(num: Int) {
        self.steps! += num
    }
    
    mutating func setXandY(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

