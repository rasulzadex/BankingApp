//
//  TransferController.swift
//  BankAPP
//
//  Created by Javidan on 15.11.24.
//

import UIKit
import RealmSwift

class TransferController: BaseViewController {

    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    var selectedFromCardRow: Int?
    var selectedToCardRow: Int?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        fetchCustomerList()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchCustomerList() {
        self.cardList = realm?.objects(CardModel.self)
    }
    
    private lazy var greenView: UILabel = {
        let l = UILabel()
        l.backgroundColor = .appGreen.withAlphaComponent(0.8)
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
        
    }()
    
    private lazy var fromCard: ReusableLabel = {
        let l = ReusableLabel(text: "Select a card transfer from", textAlignment: .left, fontName: "", fontSize: 14, textColor: .white, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .clear
        l.isUserInteractionEnabled = true
        return l
    }()
    
    private lazy var toCard: ReusableLabel = {
        let l = ReusableLabel(text: "Select a card to transfer", textAlignment: .left, fontName: "", fontSize: 14, textColor: .white, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor = .clear
        l.isUserInteractionEnabled = true
        return l
        
    }()
    
    private lazy var transferAmount: ReusableTextField = {
        let t = ReusableTextField(placeholder: "Transfer amount", placeholderColor: .appGreen, borderColor: .white, texttColor: .appGreen, bgColor: .white.withAlphaComponent(0.7))
        t.delegate = self
        t.textAlignment = .center
        return t
    }()
    
    private lazy var currencyLabel: ReusableLabel = {
        let l = ReusableLabel(text: "AZN", textAlignment: .center, fontName: "", fontSize: 14, textColor: .appGreen, numberOfLines: 0, cornerRadius: 10)
        l.backgroundColor  = .white.withAlphaComponent(0.7)
        l.layer.borderColor = UIColor.white.withAlphaComponent(0.7).cgColor
        l.layer.borderWidth = 1
        return l
    }()
    
    private lazy var transferButton: ReusableButton = {
        let b = ReusableButton(title: "Transfer", buttonColor: .appYellow) {
            [weak self] in self?.transferAction()
        }
        return b
    }()
    
    private lazy var toPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white.withAlphaComponent(0.7)
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.borderWidth = 1
        picker.delegate = self
        picker.dataSource = self
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    private lazy var fromPicker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white.withAlphaComponent(0.7)
        picker.layer.borderColor = UIColor.white.cgColor
        picker.layer.borderWidth = 1
        picker.delegate = self
        picker.dataSource = self
        picker.layer.cornerRadius = 10
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func configureView() {
        super.configureView()
        view.addViews(view: [greenView, fromCard, toCard, toPicker, fromPicker, transferAmount, currencyLabel, transferButton])
    }
    
    @objc func transferAction() {
        guard let transferAmountValue = Double(transferAmount.text ?? "") else {
               print("Yanlış məbləğ daxil edildi.")
               return
           } 
        
        let fromRow = fromPicker.selectedRow(inComponent: 0)
        let toRow = toPicker.selectedRow(inComponent: 0)
        
       
        
        guard let fromCard = cardList?[fromRow], let toCard = cardList?[toRow] else {
            print("Kart tapılmadı.")
            return
        }
        
        guard let balance = Double(fromCard.cardBalance), balance >= transferAmountValue else  {
                print("Yetərli balans yoxdur.")
                return
            }
            
        
        
        
        do {
            try realm?.write {
                guard var fromBalance = Double(fromCard.cardBalance), var toBalance = Double(toCard.cardBalance) else {return}
                if fromRow == toRow {
                    print ("Eyni kartlardan transfer mumkun deyil")
                } else {
                    fromBalance -= transferAmountValue
                    toBalance += transferAmountValue
                    
                    fromCard.cardBalance = String(format: "%.2f", fromBalance)
                    toCard.cardBalance = String(format: "%.2f", toBalance)
                    
                    print("Transfer uğurla tamamlandı.")
                    self.transferAmount.text = ""
                    self.fromPicker.reloadAllComponents()
                    self.toPicker.reloadAllComponents()
                 navigationController?.popViewController(animated: true)

                }
            }
        } catch {
            print("Transfer zamanı səhv baş verdi: \(error.localizedDescription)")
        }
        
          
    }

    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            greenView.topAnchor.constraint(equalTo: view.topAnchor),
            greenView.leftAnchor.constraint(equalTo: view.leftAnchor),
            greenView.rightAnchor.constraint(equalTo: view.rightAnchor),
            greenView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
        ])
        NSLayoutConstraint.activate([
            fromCard.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            fromCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromCard.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            fromPicker.topAnchor.constraint(equalTo: fromCard.bottomAnchor, constant: 0),
            fromPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            fromPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            fromPicker.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            toCard.topAnchor.constraint(equalTo: fromPicker.bottomAnchor, constant: 32),
            toCard.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            toCard.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            toCard.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            toPicker.topAnchor.constraint(equalTo: toCard.bottomAnchor, constant: 0),
            toPicker.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            toPicker.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            toPicker.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            transferAmount.topAnchor.constraint(equalTo: toPicker.bottomAnchor, constant: 32),
            transferAmount.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            transferAmount.rightAnchor.constraint(equalTo: currencyLabel.leftAnchor, constant: -16),
            transferAmount.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            currencyLabel.topAnchor.constraint(equalTo: toPicker.bottomAnchor, constant: 32),
            currencyLabel.leftAnchor.constraint(equalTo: transferAmount.rightAnchor, constant: 16),
            currencyLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            currencyLabel.heightAnchor.constraint(equalToConstant: 40),
            currencyLabel.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            transferButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            transferButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            transferButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24),
            transferButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }

}

extension TransferController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let textField = transferAmount.text
    }
    
}


extension TransferController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cardList?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var nameLabel: UILabel? = (view as? UILabel)
        
        if nameLabel == nil {
            nameLabel = UILabel()
            nameLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
            nameLabel?.textAlignment = .center
        }
        let card = cardList?[row]
        nameLabel?.text = (card?.cardName ?? "Salam") + "  -  " + (card?.cardNumber ?? "Salam") + "  -  " + (card?.cardBalance ?? "Salam") + "AZN"
        nameLabel?.textColor = .appGreen
        return nameLabel!
        
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return cardList?[row].cardName
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if pickerView == fromPicker {
                let selectedCard = cardList?[row]
//                let cardBalance = selectedCard?.cardBalance
//                let displayBalance = Double(cardBalance ?? "0") ?? 0.0
//                transferAmount.text = String(format: "%.2f"/*, displayBalance*/)
            }
            
        }

}
