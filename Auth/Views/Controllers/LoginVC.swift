//  LoginVC.swift
//  BankAPP
//
//  Created by Javidan on 05.11.24.
//

import UIKit
import RealmSwift



class LoginVC: UIViewController {
    private var customerList: Results<Customer>?
    private let realm = try? Realm()
    
    
    
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
    
    
    private lazy var bubbleBG: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "bubbleBackground")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
        
    }()
    
    private lazy var logoGreen: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logoGreen")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var phoneNumberTextF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setLeftPadding(10)
        tf.setPlaceholder(text: "994XXXXXXXXX", color: .appGreen, alpha: 0.4)
    
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.appGreen.withAlphaComponent(0.5).cgColor
        tf.backgroundColor = .white.withAlphaComponent(0.5)
        tf.keyboardType = .numberPad
        tf.textColor = .appGreen
        tf.delegate = self

        return tf
    }()
    
    
    
    private lazy var closedEyeImage: UIImageView = {
        let iv = UIImageView()
        
        iv.image = passwordTextF.isSecureTextEntry ? UIImage(named: "eyeClosed") : UIImage(named: "eyeOpen")
        iv.alpha = 0.5
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true

        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(passwordVisibility))
        iv.addGestureRecognizer(tapGesture)
        
        return iv
    }()

    @objc private func passwordVisibility() {
        if passwordTextF.isSecureTextEntry == true {
            closedEyeImage.image = UIImage(named: "eyeOpen")
            passwordTextF.isSecureTextEntry = false
            
        }else{
            closedEyeImage.image = UIImage(named: "eyeClosed")
            passwordTextF.isSecureTextEntry = true
            
        }
    }

    
    private lazy var phoneLabel: UILabel = {
    
        let l = UILabel()
        l.text = "Phone number"
        l.textAlignment = .left
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    private lazy var passwordLabel: UILabel = {
    
        let l = UILabel()
        l.text = "Password"
        l.textAlignment = .left
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
        
    }()
    
    
    private lazy var passwordTextF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.setLeftPadding(10)
        tf.setPlaceholder(text: "**********", color: .appGreen, alpha: 0.3)
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 10
        tf.layer.borderColor = UIColor.appGreen.withAlphaComponent(0.5).cgColor
        tf.backgroundColor = .white.withAlphaComponent(0.5)
        tf.isSecureTextEntry = true
        tf.textColor = .appGreen
        tf.delegate = self
        
        return tf
    }()
    
    private lazy var loginButton: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.setTitle("Login", for: .normal)
        b.setTitleColor(.white, for: .normal)
        b.backgroundColor = .appGreen
        b.layer.cornerRadius = 10
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.black.cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        
        b.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)

        return b
        
        
    }()
    
    
    private lazy var signupButton: UIButton = {
        let b = UIButton()
        b.setUnderlinedTitle("Register")
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.layer.cornerRadius = 0
        b.layer.borderWidth = 0
        b.layer.borderColor = UIColor.clear.cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)

        return b
        
        
    }()
    
    
    private lazy var dontHaveAccountLabel: UILabel = {
    
        let l = UILabel()
        l.text = "Don’t have an account?"
        l.textAlignment = .left
        l.numberOfLines = 0
        
        l.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false


        return l
        
        
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addSubviews()
        confConstraints()
    }
    
    @objc
    func loginButtonClick() {
         guard let customers = fetchCustomers() else { 
             showAlert(on: self, message: "Failed to fetch customers.")
             return
         }
         
         for customer in customers {
             if phoneNumberTextF.text == customer.phoneNumber,
                passwordTextF.text == customer.customerPassword {
                 let navController = TestVC()
                 navigationController?.pushViewController(navController, animated: true)
                 navigationController?.navigationBar.tintColor = .appGreen
                 return
             }
         }
         
         showAlert(on: self, message: "Please check your inputs and try again.")
     }
     
     func showAlert(on viewController: UIViewController, message: String) {
         let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
         let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
         alert.addAction(okAction)
         viewController.present(alert, animated: true, completion: nil)
     }
    
    
    @objc
        func registerButtonClick() {
            let navController = RegisterVC(viewModel: RegisterViewModel())
            navigationController?.pushViewController(navController, animated: true)
            navigationController?.navigationBar.tintColor = .appGreen
        }
    
    fileprivate func addSubviews(){
        view.addSubview(bubbleBG)
        view.addSubview(logoGreen)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(phoneNumberTextF)
        containerView.addSubview(passwordTextF)
        containerView.addSubview(loginButton)
        containerView.addSubview(signupButton)
        containerView.addSubview(phoneLabel)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(dontHaveAccountLabel)
        containerView.addSubview(closedEyeImage)




    }

    fileprivate func confConstraints(){
        
        
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
            bubbleBG.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bubbleBG.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            bubbleBG.widthAnchor.constraint(equalTo: view.widthAnchor),
            bubbleBG.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoGreen.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 100),
            logoGreen.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            logoGreen.widthAnchor.constraint(equalToConstant: 150),
            logoGreen.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: logoGreen.bottomAnchor, constant: 50),
            phoneLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            phoneLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            phoneLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: phoneNumberTextF.bottomAnchor, constant: 20),
            passwordLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            passwordLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        NSLayoutConstraint.activate([
            phoneNumberTextF.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 0),
            phoneNumberTextF.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            phoneNumberTextF.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            phoneNumberTextF.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        
        
        NSLayoutConstraint.activate([
            passwordTextF.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0),
            passwordTextF.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            passwordTextF.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            passwordTextF.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextF.bottomAnchor, constant: 40),
            loginButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            closedEyeImage.centerYAnchor.constraint(equalTo: passwordTextF.centerYAnchor),
            closedEyeImage.leftAnchor.constraint(equalTo: passwordTextF.rightAnchor, constant: -32),
            closedEyeImage.heightAnchor.constraint(equalTo: passwordTextF.heightAnchor, multiplier: 0.5),
            closedEyeImage.widthAnchor.constraint(equalTo: closedEyeImage.heightAnchor, multiplier: 1)
        ])
        
        
        NSLayoutConstraint.activate([
            signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            signupButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 170),
            signupButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            signupButton.heightAnchor.constraint(equalToConstant: 40),
            signupButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            
            dontHaveAccountLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 10),
            dontHaveAccountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -50),
            dontHaveAccountLabel.heightAnchor.constraint(equalToConstant: 40),
            dontHaveAccountLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
       
        ])

    
        
    
    }
    
    func fetchCustomers() -> [Customer]? {
        guard let realm = realm else { // Check if Realm initialization was successful
            print("Error initializing Realm.")
            return nil
        }
        
        let customers = realm.objects(Customer.self)
        return Array(customers)
    }
}

extension LoginVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // Placeholder for UITextField delegate methods, if needed
    }
}
