//
//  CardSelectionController.swift
//  BankAPP
//
//  Created by Javidan on 28.11.24.
//

import UIKit
import RealmSwift

final class CardSelectionController: BaseViewController {
    
    var selectedIndex: Int?

    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    
    var sendCardinfo: ((CardModel) -> Void)?

    
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
    
    private lazy var cardSelectionTable: UITableView = {
        let t = UITableView()
        t.delegate =  self
        t.dataSource = self
        t.translatesAutoresizingMaskIntoConstraints = false
        t.backgroundColor = .clear
        t.register(CardTableCell.self, forCellReuseIdentifier: "CardTableCell")
        t.estimatedRowHeight = 100

        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCustomerList()
        cardSelectionTable.reloadData()

    }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [cardSelectionTable])
    }

    override func configureConstraint() {
        super.configureConstraint()

        NSLayoutConstraint.activate([
    
            cardSelectionTable.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            cardSelectionTable.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            cardSelectionTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            cardSelectionTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10)
        
        ])
        
    }
}


extension CardSelectionController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cardList?.count ?? 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell", for: indexPath) as! CardTableCell
        selectedIndex = indexPath.row
        fetchCustomerList()
        
        let card = cardList?[indexPath.row]
        cell.cardNumber.text = card?.cardNumber
        cell.cardBalance.text = (card?.cardBalance ?? "0") + " AZN"
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            guard let card = cardList?[indexPath.row] else { return }
            sendCardinfo?(card)
dismiss(animated: true)        }
    
}

