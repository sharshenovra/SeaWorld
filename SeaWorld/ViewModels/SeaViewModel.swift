//
//  SeaViewModel.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation
import UIKit

protocol MainDelegate: AnyObject{
    func getTable()
}

class SeaViewModel{
    
    private weak var delegate: MainDelegate? = nil
    
    init(delegate: MainDelegate) {
        self.delegate = delegate
    }
    
    func setupSea(_ vc: UIViewController){
        Draw.shared.setupTable(to: vc)
    }
    
    func getSea() -> UIView{
        return Draw.shared.getTable()
    }
    
    func getFirstSea() -> UIView{
        return Draw.shared.getFirstTable()
    }
    
    func reloadSea(){
        Model.shared.lifeCycle()
        delegate?.getTable()
    }
    
}
