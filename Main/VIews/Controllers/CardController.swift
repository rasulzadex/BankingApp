//
//  ProfileController.swift
//  BankAPP
//
//  Created by Javidan on 13.11.24.
//

import UIKit

class CardController: BaseViewController {

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
    
    @objc func addCardFunction(){
        navigationController?.pushViewController(AddCardController(), animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
    }
    
    
    override func configureView() {
        super.configureView()
        view.addSubview(cardCollection)

        view.addSubview(plusImage)

    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            plusImage.bottomAnchor.constraint(equalTo: tabBarController?.tabBar.topAnchor ?? view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            plusImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
            plusImage.heightAnchor.constraint(equalToConstant: 48),
            plusImage.widthAnchor.constraint(equalTo: plusImage.heightAnchor, multiplier: 1)
        ])
        
        NSLayoutConstraint.activate([
            cardCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            cardCollection.leftAnchor.constraint(equalTo: view.leftAnchor),
            cardCollection.rightAnchor.constraint(equalTo: view.rightAnchor),
            cardCollection.heightAnchor.constraint(equalToConstant: 300)
            
        ])
    }


}
    
extension CardController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCell
        return cell
    }
    
    
}

