//
//  Actors.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation

class Model{
    
    var sea: [[ActorsProtocol]] = [[]]
    let height = 15
    let width = 10
    
    static let shared = Model()
    
    private init(){
        generateSea()
    }
    
    private func generateSea(){
        sea.remove(at: 0)
        for row in 0..<height{
            var array: [ActorsProtocol] = []
            for column in 0..<width{
                array.append(Water(x: column, y: row, steps: nil))
            }
            sea.append(array)
        }
        
        print("Создаётся мир")
        
        for _ in 0...((width * height) / 2){
            let randomHeight = Int.random(in: 0..<height)
            let randomWidth = Int.random(in: 0..<width)
            
            let ping = Pinguin(x: randomWidth,y: randomHeight,steps: 0)
            
            sea[randomHeight][randomWidth] = ping
        }
        
        print("Добавляются пингвины")
        
        var kwCount = 0
        
        while kwCount != ((height * width) / 20){
            let randomHeight = Int.random(in: 0..<height)
            let randomWidth = Int.random(in: 0..<width)
            let random = sea[randomHeight][randomWidth]
            if random is Water{
                sea[randomHeight][randomWidth] = KillerWhale(x: randomWidth,y: randomHeight,steps: 0)
                kwCount += 1
            }
        }
        
        print("Добавляются касатки")
    }
    
    func getSea() -> [[ActorsProtocol]]{
        return sea
    }
    
    func getNewSea() -> [[ActorsProtocol]]{
        sea = [[]]
        generateSea()
        return sea
    }
    
    private func regenerate(item: ActorsProtocol,x: Int, y: Int, dir: Direction){
        if item is Pinguin{
            if item.steps == 3{
                birth(item: item, x: x, y: y)
                sea[y][x].resetSteps()
                simpleMove(item: item, x: x, y: y, dir: dir)
            }else{
                simpleMove(item: item, x: x, y: y, dir: dir)
            }
        }else if item is KillerWhale{
            if item.hp > 0{
                if item.steps == 8{
                    birth(item: item, x: x, y: y)
                    sea[y][x].resetSteps()
                    killerWhaleMove(item: item, x: x, y: y, dir: dir)
                }else{
                    killerWhaleMove(item: item, x: x, y: y, dir: dir)
                }
            }else{
                sea[y][x] = Water(x: x, y: y)
            }
        }
    }
    
    func killerWhaleMove(item: ActorsProtocol,x: Int, y: Int, dir: Direction){
        if x != sea[y].endIndex - 1 && sea[y][x + 1] is Pinguin{
            sea[y][x].reverseHp()
            moveActor(item: item, x: x, y: y, toX: x + 1, toY: y)
            print("Касатка двинулась вправо и съела пингвина")
        }else if x != 0 && sea[y][x - 1] is Pinguin{
            sea[y][x].reverseHp()
            moveActor(item: item, x: x, y: y, toX: x - 1, toY: y)
            print("Касатка двинулась влево и съела пингвина")
        }else if y != sea.endIndex - 1 && sea[y + 1][x] is Pinguin{
            sea[y][x].reverseHp()
            moveActor(item: item, x: x, y: y, toX: x, toY: y + 1)
            print("Касатка двинулась вниз и съела пингвина")
        }else if y != 0 && sea[y - 1][x] is Pinguin{
            sea[y][x].reverseHp()
            moveActor(item: item, x: x, y: y, toX: x, toY: y - 1)
            print("Касатка двинулась вверх и съела пингвина")
        }else{
            sea[y][x].decreaseHp()
            simpleMove(item: item, x: x, y: y, dir: dir)
        }
    }
    
    func simpleMove(item: ActorsProtocol,x: Int, y: Int, dir: Direction){
        switch dir{
        case .Down :
            if y != sea.endIndex - 1 && sea[y + 1][x] is Water{
                moveActor(item: item, x: x, y: y, toX: x, toY: y + 1)
            }
        case .Up :
            if y != 0 && sea[y - 1][x] is Water{
                moveActor(item: item, x: x, y: y, toX: x, toY: y - 1)
            }
        case .Left :
            if x != 0 && sea[y][x - 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x - 1, toY: y)
            }
        case .Right :
            if x != sea[y].endIndex - 1 && sea[y][x + 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x + 1, toY: y)
            }
        case .RightUp:
            if x != sea[y].endIndex - 1 && y != 0 && sea[y - 1][x + 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x + 1, toY: y - 1)
            }
        case .LeftUp:
            if x != 0 && y != 0 && sea[y - 1][x - 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x - 1, toY: y - 1)
            }
        case .RightDown:
            if x != sea[y].endIndex - 1 && y != sea.endIndex - 1 && sea[y + 1][x + 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x + 1, toY: y + 1)
            }
        case .LeftDown:
            if x != 0 && y != sea.endIndex - 1 && sea[y + 1][x - 1] is Water{
                moveActor(item: item, x: x, y: y, toX: x - 1, toY: y + 1)
            }
        }
    }
    
    func moveActor(item: ActorsProtocol, x: Int, y: Int, toX: Int, toY: Int){
        if (item is Pinguin && sea[y][x] is Pinguin) || (item is KillerWhale && sea[y][x] is KillerWhale){
            sea[toY][toX] = item
            sea[y][x] = Water(x: x, y: y)
            sea[toY][toX].setXandY(x: toX, y: toY)
            sea[toY][toX].addStep(num: 1)
        }
    }
    
    func birth(item: ActorsProtocol, x: Int, y: Int){
        if y != sea.endIndex - 1 && sea[y + 1][x] is Water{
            sea[y + 1][x] = item
        }else if y != 0 && sea[y - 1][x] is Water{
            sea[y - 1][x] = item
        }else if x != 0 && sea[y][x - 1] is Water{
            sea[y][x - 1] = item
        }else if x != sea[y].endIndex - 1 && sea[y][x + 1] is Water{
            sea[y][x + 1] = item
        }else if x != sea[y].endIndex - 1 && y != 0 && sea[y - 1][x + 1] is Water{
            sea[y - 1][x + 1] = item
        }else if x != 0 && y != 0 && sea[y - 1][x - 1] is Water{
            sea[y - 1][x - 1] = item
        }else if x != sea[y].endIndex - 1 && y != sea.endIndex - 1 && sea[y + 1][x + 1] is Water{
            sea[y + 1][x + 1] = item
        }else if x != 0 && y != sea.endIndex - 1 && sea[y + 1][x - 1] is Water{
            sea[y + 1][x - 1] = item
        }
    }
    
    func lifeCycle(){
        for row in sea{
            for column in row{
                if column is Pinguin || column is KillerWhale{
                    regenerate(item: column, x: column.x, y: column.y, dir: getRandomDir())
                }
            }
        }
    }
    
    func checkActors(){
        var p = 0
        var k = 0
        var w = 0
        for row in sea{
            for column in row{
                if column is Pinguin{
                    p += 1
                }else if column is KillerWhale{
                    k += 1
                }else{
                    w += 1
                }
            }
        }
        print("p -\(p), k - \(k), w - \(w)")
    }
    
    private func getRandomDir() -> Direction{
        let randomInt = Int.random(in: 0...7)
        
        switch randomInt{
        case 0: return .Up
        case 1: return .Down
        case 2: return .Left
        case 3: return .Right
        case 4: return .RightUp
        case 5: return .RightDown
        case 6: return .LeftUp
        case 7: return .LeftDown
        default: return .Up
        }
    }
    
}




enum Actors {
    case Empty
    case Pinguin
    case KillerWhale
}

enum Direction{
    case Down
    case Up
    case Left
    case Right
    case RightUp
    case LeftUp
    case RightDown
    case LeftDown
}
