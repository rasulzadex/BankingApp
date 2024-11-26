//
//  ProfileController.swift
//  BankAPP
//
//  Created by Javidan on 13.11.24.
//

import UIKit
import RealmSwift

class CardController: BaseViewController {
    
    
    var selectedIndex: Int?

    private let realm = try? Realm()
    var cardList: Results<CardModel>?
    

    
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
    
    private lazy var cardCollection: UICollectionView = {
       let flowLayout = UICollectionViewFlowLayout()
        let c = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.itemSize = CGSize(width: view.frame.width, height: 300)
        flowLayout.collectionView?.isPagingEnabled = true
        c.showsHorizontalScrollIndicator = false
        c.dataSource = self
        c.delegate = self
        c.register(CardCell.self, forCellWithReuseIdentifier: "CardCell")
        c.translatesAutoresizingMaskIntoConstraints = false
        c.backgroundColor = .clear
        return c

    }()
    
 
    
    private lazy var plusImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "plusAdd")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addCardFunction))
        iv.addGestureRecognizer(tapGesture)

        return iv
    }()
    
    
    
    private lazy var transferIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "transferIcon")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tranferFunction))
        iv.addGestureRecognizer(tapGesture)

        return iv
    }()
    
    private lazy var trashIcon: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "trashIcon")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(deleteCardFunction))
        iv.addGestureRecognizer(tapGesture)

        return iv
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.numberOfPages = self.cardList?.count ?? 0

        pc.currentPage = 0
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = .black
        pc.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
        return pc
    }()
    @objc private func pageControlTapped(_ sender: UIPageControl) {

        let currentPage = sender.currentPage
        let indexPath = IndexPath(item: currentPage, section: 0)
        cardCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    
    
    @objc func addCardFunction(){
        navigationController?.pushViewController(AddCardController(), animated: true)
        navigationController?.navigationBar.tintColor = .appGreen

    }
    
    @objc func tranferFunction(){
        navigationController?.pushViewController(TransferController(), animated: true)
        navigationController?.navigationBar.tintColor = .white
    }

    @objc func deleteCardFunction() {
        guard let index = selectedIndex, let cardToDelete = cardList?[index] else {
            print("No card selected or invalid index.")
            return
        }
        
        do {
            try realm?.write {
                realm?.delete(cardToDelete)
            }


            fetchCustomerList()

            if let updatedCardList = cardList, !updatedCardList.isEmpty {
                selectedIndex = min(index, updatedCardList.count - 1)
            } else {
                selectedIndex = nil
            }
            cardCollection.reloadData()
            pageControl.numberOfPages = cardList?.count ?? 0
            pageControl.currentPage = selectedIndex ?? 0
      
        } catch {
            print("Error deleting card: \(error)")
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()  

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCustomerList()
        cardCollection.reloadData()
        pageControl.numberOfPages = cardList?.count ?? 0
    }

    
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(cardCollection)
        view.addSubview(plusImage)
        view.addSubview(transferIcon)
        view.addSubview(trashIcon)
        view.addSubview(pageControl)


    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            plusImage.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            plusImage.trailingAnchor.constraint(equalTo: transferIcon.leadingAnchor, constant: -20),
            plusImage.heightAnchor.constraint(equalToConstant: 40),
            plusImage.widthAnchor.constraint(equalTo: plusImage.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            transferIcon.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            transferIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20),
            transferIcon.heightAnchor.constraint(equalToConstant: 40),
            transferIcon.widthAnchor.constraint(equalTo: transferIcon.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            trashIcon.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 10),
            trashIcon.leadingAnchor.constraint(equalTo: transferIcon.trailingAnchor, constant: 20),

            trashIcon.heightAnchor.constraint(equalToConstant: 40),
            trashIcon.widthAnchor.constraint(equalTo: transferIcon.heightAnchor, multiplier: 1)
        ])

        
        
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            cardCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardCollection.heightAnchor.constraint(equalToConstant: 300)
            
        ])
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: cardCollection.bottomAnchor, constant: 0),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])

    }


}
    
extension CardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.cardList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        selectedIndex = indexPath.row
        fetchCustomerList()
        
        let card = cardList?[indexPath.row]
        cell.cardName.text = card?.cardName
        cell.cardNumber.text = " **** " + (card?.cardNumber.suffix(4) ?? "****")
        cell.cardExp.text = card?.cardExpiration
        return cell
        
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
           pageControl.currentPage = Int(pageIndex)
       }
    
}

