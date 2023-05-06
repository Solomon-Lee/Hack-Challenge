//
//  MailViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class MailViewController: UIViewController {
    

    let inboxLabel = UILabel()
    var collectionView: UICollectionView!
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let cellReuseID = "cellReuse"
    
    let people : [Person] = [Person(email: "josh123", userName: "Josh", passWord: "321hsoj", phoneNumber: "456"),Person(email: "palindrome", userName: "Hannah", passWord: "hello", phoneNumber: "911")]

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        title = "Mail"
        view.backgroundColor = .white
        
        inboxLabel.text = "Inbox"
        inboxLabel.font = UIFont.boldSystemFont(ofSize: 35)
        inboxLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        inboxLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inboxLabel)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.scrollDirection = .vertical // scroll direction
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.tag = 0
        view.addSubview(collectionView)
        collectionView.register(CustomMailCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        
        NSLayoutConstraint.activate([ inboxLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30), inboxLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: inboxLabel.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

extension MailViewController :UICollectionViewDelegate{
}

extension MailViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? CustomMailCollectionViewCell{
                cell.update(person: people[indexPath.item])
                return cell
            }
            else{
                return UICollectionViewCell()
            }
        }
}
    extension MailViewController : UICollectionViewDelegateFlowLayout{
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
            let len = (view.frame.width - 70)
            return CGSize(width: len, height: 2/5 * len)
        }
}
