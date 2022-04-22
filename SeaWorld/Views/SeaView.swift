//
//  SeaView.swift
//  SeaWorld
//
//  Created by Ruslan Sharshenov on 8/4/22.
//

import UIKit

class SeaView: UIViewController{
    
    
    var table = UIView()
    
    private var restartButton: UIButton = {
        let view = UIButton()
        view.setTitle("CYCLE", for: .normal)
        view.setTitleColor(.red, for: .normal)
        view.addTarget(nil, action: #selector(restart(sender:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var viewModel: SeaViewModel = {
        return SeaViewModel(delegate: self)
    }()
    
    override func viewDidLoad(){
        setupFirstLoad()
        setupGesture()
    }
    
    @objc func tap(){
        table.removeFromSuperview()
        table = viewModel.getSea()
        viewModel.reloadSea()
        view.addSubview(table)
        viewModel.setupSea(self)
        setupGesture()
    }
    
    @objc func restart(sender: UIButton){
        setupFirstLoad()
        setupGesture()
    }
    
    func setupGesture(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(tap))
        let gestureView: UIView = {
           let view = UIView()
            view.addGestureRecognizer(tap)
            return view
        }()
        table.addSubview(gestureView)
        gestureView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: gestureView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: table, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: gestureView, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: table, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: gestureView, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: table, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: gestureView, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: table, attribute: NSLayoutConstraint.Attribute.left, multiplier: 0.9, constant: 0).isActive = true
        NSLayoutConstraint(item: gestureView, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: table, attribute: NSLayoutConstraint.Attribute.right, multiplier: 0.9, constant: 0).isActive = true
    }
    
    
    func setupFirstLoad(){
        table.removeFromSuperview()
        table = viewModel.getFirstSea()
        view.addSubview(table)
        viewModel.setupSea(self)
        
        view.addSubview(restartButton)
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: restartButton, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: restartButton, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: restartButton, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.height, multiplier: 0.1, constant: 0).isActive = true
        
        setupGesture()
        
    }
}

extension SeaView: MainDelegate{
    func getTable() {
        table.removeFromSuperview()
        table = viewModel.getSea()
        view.addSubview(table)
    }
}
