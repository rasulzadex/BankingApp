//
//  CardSelectionController.swift
//  BankAPP
//
//  Created by Javidan on 28.11.24.
//

import UIKit


final class CardSelectionController: BaseViewController {
    
      private var selectedIndex: Int?
       private var viewModel: CardSelectionViewModel

        var sendCardinfo: ((CardModel) -> Void)?
        
        init(viewModel: CardSelectionViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
  
    private func fetchCustomerList() {
        viewModel.fetchCustomerList()
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


    }
    
    
    private func configureViewModel(){
        viewModel.listener? = {[weak self] state in
            guard let self else {return}
            switch state {
            case .success(let message):
                print(message)
            case .error(let message):
                showAlert(message: message)
            }
        }
        
    }
    
    override func configureView() {
        super.configureView()
        view.addViews(view: [cardSelectionTable])
        configureViewModel()
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
        viewModel.cardList?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardTableCell", for: indexPath) as! CardTableCell
        selectedIndex = indexPath.row
        let card = viewModel.cardList?[indexPath.row]
        if let card = card {
            cell.configureTableCell(data: card)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let card = viewModel.cardList?[indexPath.row] else { return }
        sendCardinfo?(card)
        viewModel.listener?(.success("Card has been selected"))
        dismiss(animated: true)
    }
    
}

