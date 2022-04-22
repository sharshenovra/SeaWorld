//
//  ActorsProtocol.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation

protocol ActorsProtocol{
    var steps: Int? { get }
    var x: Int { get }
    var y: Int { get }
    var hp: Int { get }
    mutating func addStep(num: Int) -> Void
    mutating func setXandY(x: Int, y: Int) -> Void
    mutating func decreaseHp() -> Void
    mutating func reverseHp() -> Void
    mutating func resetSteps() -> Void
}
