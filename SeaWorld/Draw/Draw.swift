//
//  Draw.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import Foundation
import UIKit

class Draw{
    
    var seaTable = UIView()
    
    static let shared = Draw()
    
    private init(){
    }
        
    private func generateStack(axis: NSLayoutConstraint.Axis) -> UIStackView {
            let view = UIStackView()
            view.axis = axis
            view.distribution = .fillEqually
            return view
    }
    
    var filledVerticalStack = UIStackView()
    
    private func generateTable(array: [[ActorsProtocol]]){
        filledVerticalStack = generateStack(axis: .vertical)
        for row in array{
            let horizontal = generateStack(axis: .horizontal)
            for column in row{
                switch column{
                case is Pinguin :
                    horizontal.addArrangedSubview(generateLabel(label: "P"))
                case is KillerWhale :
                    horizontal.addArrangedSubview(generateLabel(label: "K"))
                case is Water :
                    horizontal.addArrangedSubview(generateLabel(label: ""))
                default:
                    return
                }
            }
            filledVerticalStack.addArrangedSubview(horizontal)
        }
        setupConstraint(stack: filledVerticalStack)
    }
    
    func setupConstraint(stack: UIStackView){
            seaTable = UIView()
            seaTable.addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint(item: stack, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: seaTable, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: stack, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: seaTable, attribute: NSLayoutConstraint.Attribute.topMargin, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: stack, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: seaTable, attribute: NSLayoutConstraint.Attribute.bottomMargin, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: stack, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: seaTable, attribute: NSLayoutConstraint.Attribute.leftMargin, multiplier: 1, constant: 0).isActive = true
            NSLayoutConstraint(item: stack, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: seaTable, attribute: NSLayoutConstraint.Attribute.rightMargin, multiplier: 1, constant: 0).isActive = true
    }
    
    private func generateLabel(label: String) -> UILabel{
        let entityChar: UILabel = {
            let view = UILabel()
            view.textColor = .red
            view.text = label
            view.adjustsFontSizeToFitWidth = true
            view.font = .systemFont(ofSize: 15, weight: .bold)
            view.layer.borderColor = UIColor.black.cgColor
            view.layer.borderWidth = 1
            view.textAlignment = .center
            return view
        }()
        return entityChar
    }
    
    func getTable() -> UIView{
        generateTable(array: Model.shared.getSea())
        return seaTable
    }
    
    func getFirstTable() -> UIView{
        generateTable(array: Model.shared.getNewSea())
        return seaTable
    }
    
    func setupTable(to: UIViewController){
        seaTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: seaTable, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: to.view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: seaTable, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: to.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: seaTable, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: to.view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: seaTable, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: to.view, attribute: NSLayoutConstraint.Attribute.left, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: seaTable, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: to.view, attribute: NSLayoutConstraint.Attribute.right, multiplier: 0.9, constant: 0).isActive = true
    }
    
    @objc func tap(){
        Model.shared.lifeCycle()
    }
}
