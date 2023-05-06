//
//  SavedViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class SavedViewController: UIViewController {
    
    let petInterestedInLabel = UILabel()
    var petCollectionView : UICollectionView!
    let petReuseId = "petReuseId"
    
    var savedPets: [SavedPagePets] = [SavedPagePets(petName: "Poppy", age: "1", gender: "Male", category: "Cat", breed: "Ragdoll", location: "On-Campus", time: "05/2023 - 06/2023", profilePic: "profilePicTemp", buttonTitle: "Sitter"),SavedPagePets(petName: "Alexander", age: "2", gender: "Female", category: "Dog", breed: "Bulldog", location: "Off-Campus", time: "05/2023 - 06/2023", profilePic: "profilePicTemp", buttonTitle: "Adopter"),SavedPagePets(petName: "BB", age: "3", gender: "Male", category: "Cat", breed: "Birman", location: "Outside Ithaca", time: "05/2023 - 06/2023", profilePic: "profilePicTemp", buttonTitle: "Sitter"),SavedPagePets(petName: "Happy", age: "1", gender: "Female", category: "Rabbit", breed: "Rex", location: "On-Campus", time: "05/2023 - 06/2023", profilePic: "profilePicTemp", buttonTitle: "Sitter")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //petsInterested Label
        petInterestedInLabel.numberOfLines = 2
        petInterestedInLabel.text = "Pets that you are\ninterested in"
        petInterestedInLabel.font = UIFont(name: "Ubuntu-Medium", size: 30)
        petInterestedInLabel.translatesAutoresizingMaskIntoConstraints = false
        petInterestedInLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1.0)
        view.insertSubview(petInterestedInLabel, at: 0)
        
        //setup the petCollectionView
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 10
        petCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        petCollectionView.translatesAutoresizingMaskIntoConstraints = false
        petCollectionView.register(SavedPageCollectionViewCell.self, forCellWithReuseIdentifier: petReuseId)
        petCollectionView.showsVerticalScrollIndicator = false
        petCollectionView.decelerationRate = .normal
        petCollectionView.delegate = self
        petCollectionView.dataSource = self
        
        
        view.insertSubview(petCollectionView, at: 0)
        
        //set up constraints
        setCons()
    }
    
    private func setCons(){
        
        NSLayoutConstraint.activate([
            
            //petInterestedInLabel
            petInterestedInLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 12),
            petInterestedInLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 26),
            
            //pet collectionView
            petCollectionView.topAnchor.constraint(equalTo: petInterestedInLabel.bottomAnchor,constant: 38),
            petCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            petCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            petCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        
        ])
        
    }

}
extension SavedViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return savedPets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = petCollectionView.dequeueReusableCell(withReuseIdentifier: petReuseId, for: indexPath) as? SavedPageCollectionViewCell{
            
            let pet = savedPets[indexPath.row]
            cell.configure(pet: pet)
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}

extension SavedViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 307.13, height: 194.4)
    }
}

extension SavedViewController: UICollectionViewDelegate{
    
}


