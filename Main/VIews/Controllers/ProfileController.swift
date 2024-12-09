//
//  ProfileController.swift
//  BankAPP
//
//  Created by Javidan on 13.11.24.
//

import UIKit

class ProfileController: BaseViewController {
    
    
    private lazy var logoutImage: ReusableImageView = {
        let i = ReusableImageView(imageName: "logout", contentMode: .scaleAspectFill, cornerRadius: 10)
        return i
    }()
    
    private lazy var nameLabel: ReusableLabel = {
        let l = ReusableLabel(text: "  Name", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .appGreen.withAlphaComponent(0.2)
        return l
    }()
    
    private lazy var lastNameLabel: ReusableLabel = {
        let l = ReusableLabel(text: "  Lastname", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .appGreen.withAlphaComponent(0.2)
        return l
    }()
    
    private lazy var phoneNumber: ReusableLabel = {
        let l = ReusableLabel(text: "  Phone number", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .appGreen.withAlphaComponent(0.2)
        return l
    }()
    
    private lazy var emailLabel: ReusableLabel = {
        let l = ReusableLabel(text: "  Email", textAlignment: .left, fontName: "", fontSize: 12, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .appGreen.withAlphaComponent(0.2)
        return l
    }()
    
    private lazy var logOutButton: ReusableButton = {
        let b = ReusableButton(title: "Log out", buttonColor: .appGreen) {
            [weak self] in self?.logOutAction()
        }
        return b
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let phone = UserDefaults.standard.string(forKey: "phone") {
               phoneNumber.text = "  Phone: " + phone
           }
        
        if let email = UserDefaults.standard.string(forKey: "email") {
               emailLabel.text = "  Email: " + email
           }
        if let name = UserDefaults.standard.string(forKey: "firstName") {
               nameLabel.text = "  Name: " + name
           }
    
        if let lastname = UserDefaults.standard.string(forKey: "lastName") {
               lastNameLabel.text = "  Lastname: " + lastname
           }
                
    }
    
    @objc private func logOutAction() {
        logoutAlert(message: "Hope to see you soon")
    }
    
    
   private func logoutAlert(message: String) {
        let alert = UIAlertController(title: "Are you logging out?", message: message, preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "Log out", style: .default) { _ in
            if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                scene.switchToLogin()
            }
            UserDefaults.standard.removeObject(forKey: "lastName")
            UserDefaults.standard.removeObject(forKey: "email")
            UserDefaults.standard.removeObject(forKey: "firstName")
            UserDefaults.standard.removeObject(forKey: "phone")
        }
        yesAction.setValue(UIColor.appGreen, forKey: "titleTextColor")
        let noAction = UIAlertAction(title: "Cancel", style: .destructive) { _ in
        }
                alert.addAction(yesAction)
        alert.addAction(noAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [logOutButton, logoutImage, nameLabel, lastNameLabel, phoneNumber, emailLabel])
    }
    
 
    override func configureConstraint() {
        super.configureConstraint()
        
        NSLayoutConstraint.activate([
            logOutButton.bottomAnchor.constraint(equalTo: tabBarController?.tabBar.topAnchor ?? view.bottomAnchor, constant: -100),
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            logOutButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            logoutImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 144),
            logoutImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutImage.heightAnchor.constraint(equalToConstant: 160),
            logoutImage.widthAnchor.constraint(equalToConstant: 160)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: logoutImage.bottomAnchor, constant: 48),
            nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            nameLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            lastNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
            lastNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            lastNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumber.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 24),
            phoneNumber.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            phoneNumber.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            phoneNumber.heightAnchor.constraint(equalToConstant: 36)
        ])
        
        NSLayoutConstraint.activate([
            emailLabel.topAnchor.constraint(equalTo: phoneNumber.bottomAnchor, constant: 24),
            emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            emailLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            emailLabel.heightAnchor.constraint(equalToConstant: 36)
        ])
    }
    
}
