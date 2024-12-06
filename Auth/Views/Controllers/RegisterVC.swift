//
//  ViewController.swift
//  BankAPP
//
//  Created by Javidan on 02.11.24.
//

import UIKit
import RealmSwift

final class RegisterVC: UIViewController {
    
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
    
    private lazy var firstNameLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Firstname", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()

    private lazy var firstNameTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "John", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()
  
    private lazy var lastNameLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Lastname", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
 
    private lazy var welcomeLabel: UILabel = {
        let l = UILabel()
        l.text = "Enter details to create manat bank account"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    private lazy var lastNameTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "Doe", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()

    private lazy var finLabel: ReusableLabel = {
        let l = ReusableLabel(text: "FIN Code", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    
    private lazy var finCodeTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "XXXXXXX", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()

    private lazy var emailLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Email", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
   
    private lazy var emailTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "hello@example.com", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()
  
    private lazy var phoneLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Phone", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
    
    private lazy var phoneNumberTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "994XXXXXXXXX", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()
   
    private lazy var passwordLabel: ReusableLabel = {
        let l = ReusableLabel(text: "Password", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return l
    }()
  
    private lazy var passwordTF: ReusableTextField = {
        let tf = ReusableTextField(placeholder: "********", placeholderColor: .appGreen, borderColor: .appGreen.withAlphaComponent(0.5), texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.5))
        tf.delegate = self
        return tf
    }()
   
    
    
    
    private lazy var actionButton: ReusableButton = {
        let b = ReusableButton(title: "Register", buttonColor: UIColor.appGreen, onAction: {[weak self] in self?.submitButton()})
        return b
    }()
    
    
    private lazy var loginButton: UIButton = {
        let b = UIButton(type: .system)
        b.setUnderlinedTitle("Login")
        b.setTitleColor(.systemBlue, for: .normal)
        b.backgroundColor = .clear
        b.layer.cornerRadius = 0
        b.layer.borderWidth = 0
        b.layer.borderColor = UIColor.clear.cgColor
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
        return b
    }()
    
    private lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bubbleBackground")
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()
    
    
    private lazy var closedEyeImage: UIImageView = {
        let iv = UIImageView()
        iv.image = passwordTF.isSecureTextEntry ? UIImage(named: "eyeClosed") : UIImage(named: "eyeOpen")
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
        if passwordTF.isSecureTextEntry == true {
            closedEyeImage.image = UIImage(named: "eyeOpen")
            passwordTF.isSecureTextEntry = false
            
        }else{
            closedEyeImage.image = UIImage(named: "eyeClosed")
            passwordTF.isSecureTextEntry = true
            
        }
    }
  
    private lazy var createAccountLabel: UILabel = {
        let l = UILabel()
        l.text = "Create Account"
        l.textAlignment = .center
        l.numberOfLines = 0
        l.font = UIFont(name: "Revue", size: 44)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    
    private lazy var alreadyAccLabel: UILabel = {
        let l = UILabel()
        l.text = "Already have an account?"
        l.textAlignment = .left
        l.numberOfLines = 0
        l.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        l.textColor = .appGreen
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private let viewModel: RegisterViewModel
    private var validationMapping: [UITextField: RegisterViewModel.ValidationType] = [:]
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupValidatinMapping()
    }
    
    
    required init?(coder: NSCoder) {
        self.viewModel = RegisterViewModel()
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        let realm = try! Realm()
//        print("Realm path", realm.configuration.fileURL!)
        viewModel.fetchCustomerList()
        configureView()
        configureConstraints()
        
    }
    func setupValidatinMapping() {
        validationMapping = [
            emailTF: .email,
            lastNameTF: .lastname,
            firstNameTF: .name,
            finCodeTF: .fin,
            phoneNumberTF: .phone,
            passwordTF: .password
        
        ]
        
    }

    
    fileprivate func configureView(){
        view.addSubview(imageView)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addViews(view: [createAccountLabel, welcomeLabel, firstNameTF, firstNameLabel, lastNameTF, lastNameLabel, finLabel, finCodeTF, emailTF, emailLabel, phoneNumberTF, phoneLabel, passwordTF, passwordLabel, actionButton, loginButton, alreadyAccLabel, closedEyeImage])
        configureViewModel()
        
    }
    
    fileprivate func configureConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 36),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            createAccountLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0),
            createAccountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            createAccountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)])
        
        NSLayoutConstraint.activate([
            welcomeLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 0),
            welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            welcomeLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            firstNameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 24),
            firstNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            firstNameLabel.heightAnchor.constraint(equalToConstant: 20)])
                
        NSLayoutConstraint.activate([
            firstNameTF.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 0),
            firstNameTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            firstNameTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            firstNameTF.heightAnchor.constraint(equalToConstant: 40)])
                
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: firstNameTF.bottomAnchor, constant: 12),
            lastNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            lastNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        
        NSLayoutConstraint.activate([
            lastNameTF.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 0),
            lastNameTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            lastNameTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            lastNameTF.heightAnchor.constraint(equalToConstant: 40)])
        
        
        NSLayoutConstraint.activate([
            finLabel.topAnchor.constraint(equalTo: lastNameTF.bottomAnchor, constant: 12),
            finLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            finLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            finLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            finCodeTF.topAnchor.constraint(equalTo: finLabel.bottomAnchor, constant: 0),
            finCodeTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            finCodeTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            finCodeTF.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: finCodeTF.bottomAnchor, constant: 12),
            phoneLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            phoneNumberTF.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 0),
            phoneNumberTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            phoneNumberTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            phoneNumberTF.heightAnchor.constraint(equalToConstant: 40)])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneNumberTF.bottomAnchor, constant: 12),
            emailLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            emailLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            emailTF.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 0),
            emailTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            emailTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            emailTF.heightAnchor.constraint(equalToConstant: 40)])
                        
        NSLayoutConstraint.activate([
            passwordLabel.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 12),
            passwordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            passwordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            passwordLabel.heightAnchor.constraint(equalToConstant: 20)])
        
        NSLayoutConstraint.activate([
            passwordTF.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 0),
            passwordTF.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            passwordTF.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            passwordTF.heightAnchor.constraint(equalToConstant: 40)])
                
        NSLayoutConstraint.activate([
            closedEyeImage.centerYAnchor.constraint(equalTo: passwordTF.centerYAnchor),
            closedEyeImage.leftAnchor.constraint(equalTo: passwordTF.rightAnchor, constant: -32),
            closedEyeImage.heightAnchor.constraint(equalTo: passwordTF.heightAnchor, multiplier: 0.5),
            closedEyeImage.widthAnchor.constraint(equalTo: closedEyeImage.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 40),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 40)])
                
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 10),
            loginButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 170),
            loginButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 40),
                        loginButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            alreadyAccLabel.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 10),
            alreadyAccLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            alreadyAccLabel.heightAnchor.constraint(equalToConstant: 40),
            alreadyAccLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -100)
        ])
        }
    
    
    @objc func submitButton() {
        if phoneNumberTF.layer.borderColor == UIColor.green.cgColor && firstNameTF.layer.borderColor == UIColor.green.cgColor && lastNameTF.layer.borderColor == UIColor.green.cgColor && finCodeTF.layer.borderColor == UIColor.green.cgColor && emailTF.layer.borderColor == UIColor.green.cgColor && passwordTF.layer.borderColor == UIColor.green.cgColor && viewModel.isAllValid {
            
            guard let name = firstNameTF.text,
                  let lastname = lastNameTF.text,
                  let fin = finCodeTF.text,
                  let phone = phoneNumberTF.text,
                  let email = emailTF.text,
                  let pass = passwordTF.text else {return}
            
            viewModel.saveCustomer(name: name, lastName: lastname, customerID: fin, email: email, phoneNumber: phone, password: pass)
            viewModel.registerListener?(.success("New customer is created here"))
            navigationController?.popViewController(animated: true)
        } else {
            viewModel.registerListener?(.error("Couldn't create customer"))
        }
    }

    private func configureViewModel() {
        viewModel.registerListener = {[weak self] state in
            guard let self else {return}
            switch state {
            case .success(let message):
                print(message)
            case .error(let message):
                showAlert(message: message)
            }
        }
    }
    
    @objc func loginButtonClick() {
        navigationController?.popViewController(animated: true)
        
    }
    
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let validationType = validationMapping[textField] else {return}
        
        let isValid =  viewModel.validate(value: textField.text ?? "", type: validationType)
        textField.layer.borderColor = isValid ? UIColor.green.cgColor : UIColor.red.cgColor
    
    }
}

