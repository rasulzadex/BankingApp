//
//  GetStartVC.swift
//  BankAPP
//
//  Created by Javidan on 05.11.24.
//

import UIKit

class GetStartVC: UIViewController {

    
    private lazy var scrollView: UIScrollView = {
           let sv = UIScrollView()
           sv.translatesAutoresizingMaskIntoConstraints = false
           return sv
       }()
       
       private lazy var containerView: UIView = {
           let vw = UIView()
           vw.translatesAutoresizingMaskIntoConstraints = false
           return vw
       }()
    
    
    
    
    private lazy var startButton: UIButton = {
        let b = UIButton()
        b.setTitle("Get Started", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .appYellow
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.appYellow.cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.addTarget(self, action: #selector(getStarted), for: .touchUpInside)
        
        return b
    }()
    
    private lazy var welcomeLabel: UILabel = {
    
        let l = UILabel()
        l.text = "Welcome to ManatBank"
        l.textAlignment = .left
        l.numberOfLines = 0
        l.font = UIFont(name: "Revue", size: 40)

//        l.font = UIFont.systemFont(ofSize: 36, weight: .heavy)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    
    private lazy var secondLabel: UILabel = {
    
        let l = UILabel()
        l.text = "Manatbank makes banking hassle-free and easier for you."
        l.textAlignment = .center
        l.numberOfLines = 2
//        l.font = UIFont(name: "", size: 15)
        

        l.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        l.textColor = .white
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bubbleBackground")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()

    private lazy var logoWhite: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logoWhite")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    
    
    private lazy var addView: UIView = {
       let v = UIView()
        
        v.backgroundColor = .appGreen.withAlphaComponent(0.7)
        v.translatesAutoresizingMaskIntoConstraints = false
        
        return v
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .darkGreen.withAlphaComponent()
        addAllSubviews()
        configureConstraints()

        // Do any additional setup after loading the view.
    }
    
    @objc
        func getStarted() {
           let navController = LoginVC()
            navigationController?.pushViewController(navController, animated: true)
//            navigationController?.navigationBar.isHidden = true
        }
    
    fileprivate func addAllSubviews(){
            view.addSubview(imageView)
            view.addSubview(addView)
            view.addSubview(scrollView)
            scrollView.addSubview(containerView)

        
            
      
                containerView.addSubview(startButton)
                containerView.addSubview(logoWhite)
                containerView.addSubview(welcomeLabel)
                containerView.addSubview(secondLabel)



        
    }
    
    
    fileprivate func configureConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 50),
            welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        // LogoWhite ImageView Constraints
        NSLayoutConstraint.activate([
            logoWhite.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 80),
            logoWhite.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoWhite.widthAnchor.constraint(equalToConstant: 200),
            logoWhite.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: logoWhite.bottomAnchor, constant: 50),
            secondLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 40),
            secondLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 50),
            startButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            startButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            startButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        // Background ImageView Constraints
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        // AddView Overlay Constraints
        NSLayoutConstraint.activate([
            addView.widthAnchor.constraint(equalTo: view.widthAnchor),
            addView.heightAnchor.constraint(equalTo: view.heightAnchor),
            addView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

        
    }
    
   


