//
//  BaseController.swift
//  BankAPP
//
//  Created by Javidan on 14.11.24.
//

import UIKit

class BaseViewController: UIViewController {
   
    private lazy var bubbleBG: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "bubbleBackground")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureConstraint()
    }
    
    open func configureView(){
        view.addSubview(bubbleBG)

        
    }
    open func configureConstraint(){
        NSLayoutConstraint.activate([
            bubbleBG.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bubbleBG.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bubbleBG.topAnchor.constraint(equalTo: view.topAnchor),
            bubbleBG.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
}
