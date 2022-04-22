//
//  KillerWhale.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation

struct KillerWhale: ActorsProtocol{
    mutating func resetSteps() {
        self.steps = 0
    }
    
    mutating func reverseHp() {
        self.hp = 3
    }
    
    
    var x: Int
    
    var y: Int
    
    var steps: Int? = 0
    
    var hp = 3
    
    let name: Actors = .KillerWhale
    
    mutating func addStep(num: Int) {
        self.steps! += num
    }
    
    mutating func setXandY(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    mutating func decreaseHp(){
        self.hp -= 1
    }
}
