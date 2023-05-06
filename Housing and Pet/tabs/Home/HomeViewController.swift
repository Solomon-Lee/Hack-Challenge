//
//  ViewController.swift
//  hackaton
//
//  Created by Eman Abdu on 4/29/23.
//

import UIKit

class HomeViewController: UIViewController {

    let buttonWidth = 100
    let buttonHeight = 50
    let itemPadding: CGFloat = 10
    let sectionPadding: CGFloat = 5
    let filterHeight: CGFloat = 100
    let cellReuseID = "cellReuseID"
    let filterReuseID = "filterReuseID"
    var collectionViewTag = 0
    let AdopterCollectionViewTag = 2
    let filterCollectionViewTag = 1
    let all = UIButton()
    let dog = UIButton()
    let cat = UIButton()
    let rodent = UIButton()
    let bird = UIButton()
    let fish = UIButton()
    let reptile = UIButton()
    let insect = UIButton()
    let other = UIButton()
    
    let sitter = UIButton(frame: CGRect(x: 100, y: 100, width: 250, height: 70))

    let adopter = UIButton(frame: CGRect(x: 100, y: 100, width: 250, height: 70))
    let ovalTextField =  UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 30))
    var collectionView: UICollectionView!
//    var filterCollectionView: UICollectionView!
    let searchButton = UIButton()
    var filter = UIButton()
    let userModeView = UIView(frame: CGRect(x: 100, y: 100, width: 500, height: 70))
    

    private var filters = ["All", "Mix","Cat",  "Dog", "Bunny"]
    var selectedPets : Pets = Pets(pet_sitting_requests: [Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Bob", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "bob", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
                                                          
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Peter", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "Peter", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Jack", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "jack", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Poppy", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "fish 1", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),

        Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Spot", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "image3", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 25, pet_owner_id: 13, pet_sitter_id: 21,name: "Spot", age: "2", gender: "Male", category: "Peter", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "image3", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
        
        Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Ferguson", age: "2", gender: "Male", category: "Bunny", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "bunny1", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)])])
    private var pets : Pets = Pets(pet_sitting_requests: [Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Bob", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "bob", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
        Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Spot", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "image3", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Poppy", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "fish 1", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Jack", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "jack", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
      Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Peter", age: "2", gender: "Male", category: "Cat", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "Peter", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]),
        Pet(id: 23, pet_owner_id: 12, pet_sitter_id: 21,name: "Ferguson", age: "2", gender: "Male", category: "Bunny", breed: "Unknown", on_campus: true, off_campus: false, outside: false, start_time: "June 1", end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true,sitter_pay: true, sitter_housing: true, assets: [assets(base_url: "bunny1", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)])])
    var adoptionPets : AdoptionPets = AdoptionPets(pet_adoption_requests: [AdoptionPet(id: 123, pet_owner_id: 1, pet_adopter_id: 2,name: "Sunny", age: "3", gender: "Male", category: "Dog", breed: "Unknown", on_campus: true, off_campus: false, outside: false, end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true, adopter_reward : true , assets: [asset(base_url: "sunny", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]), AdoptionPet(id: 13, pet_owner_id: 12, pet_adopter_id: 3,name: "Trump", age: "2", gender: "Male", category: "Dog", breed: "Unknown", on_campus: true, off_campus: false, outside: false, end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true, adopter_reward : true , assets: [asset(base_url: "trump", created_at: "2023-05-05 07:01:42.443320", asset_id: 21, user_id: 11, pet_sitting_id: 20, pet_adoption_id: 41)])])
    var selectedAdoptionPets  : AdoptionPets = AdoptionPets(pet_adoption_requests: [AdoptionPet(id: 123, pet_owner_id: 1, pet_adopter_id: 2,name: "Bob", age: "3", gender: "Male", category: "Dog", breed: "Unknown", on_campus: true, off_campus: false, outside: false, end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true, adopter_reward : true , assets: [asset(base_url: "image", created_at: "2023-05-05 07:01:42.443320", asset_id: 2, user_id: 1, pet_sitting_id: 0, pet_adoption_id: 4)]), AdoptionPet(id: 13, pet_owner_id: 12, pet_adopter_id: 3,name: "Trump", age: "2", gender: "Male", category: "Dog", breed: "Unknown", on_campus: true, off_campus: false, outside: false, end_time: "August 1", pet_description: "None", additional_info: "None", food_supplies: true, adopter_reward : true , assets: [asset(base_url: "trump", created_at: "2023-05-05 07:01:42.443320", asset_id: 21, user_id: 11, pet_sitting_id: 20, pet_adoption_id: 41)])])
    var selectedFilters : [Int] = []
//
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //userModeView
        userModeView.layer.cornerRadius = 19
        userModeView.layer.borderWidth = 2.0
        userModeView.backgroundColor = .white
        userModeView.translatesAutoresizingMaskIntoConstraints = false
        


        
        //sitter button
        sitter.setTitle("Sitter", for: .normal)
        sitter.setTitleColor(.white, for: .normal)
        sitter.backgroundColor =  .black
        sitter.layer.cornerRadius = 18
        sitter.addTarget(self, action: #selector(changeToSitter), for: .touchUpInside)
        sitter.translatesAutoresizingMaskIntoConstraints = false
        userModeView.addSubview(sitter)
        
        //adopter button
        adopter.setTitle("Adopter", for: .normal)
        adopter.setTitleColor(.black, for: .normal)
        adopter.layer.cornerRadius = 18
        adopter.backgroundColor = .white
        adopter.addTarget(self, action: #selector(changeToAdopter), for: .touchUpInside)
        adopter.translatesAutoresizingMaskIntoConstraints = false
        userModeView.addSubview(adopter)
        view.addSubview(userModeView)
        
        // search field button
        ovalTextField.layer.cornerRadius = 2 * ovalTextField.frame.height / 3
        ovalTextField.backgroundColor = .white
        ovalTextField.setTitle("Search pets", for: .normal)
        ovalTextField.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        ovalTextField.contentHorizontalAlignment = .leading
        ovalTextField.titleEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 0)
        ovalTextField.setTitleColor(.lightGray, for: .normal)
        ovalTextField.layer.borderWidth = 1.5
        ovalTextField.addTarget(self, action: #selector(pushSearchView), for: .touchUpInside)
        ovalTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ovalTextField)
        
        
        //search button
        let searchImage = UIImage(systemName: "magnifyingglass")?.withTintColor(.black, renderingMode: .alwaysOriginal)
        searchButton.setImage(searchImage, for: .normal)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchButton)
        
        let title = "All"
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Ubuntu-Medium", size: 18)]
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        all.setAttributedTitle(attributedTitle, for: .normal)
        all.layer.cornerRadius = 20
        all.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        all.layer.borderWidth = 2.0
        all.layer.borderColor = UIColor.black.cgColor
        all.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        all.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(all)
        
        dog.setImage(UIImage(named: "dog"), for: .normal)
        dog.setTitle("Dog", for: .normal)
        dog.setTitleColor(.black, for: .normal)
        dog.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        dog.imageView?.contentMode = .bottomRight
        dog.titleEdgeInsets = UIEdgeInsets(top: 40, left: -45, bottom: 0, right: 0)
        dog.imageEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: -dog.titleLabel!.frame.size.width)
        dog.layer.cornerRadius = 25
        dog.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        dog.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dog)
        
        cat.setImage(UIImage(named: "cat"), for: .normal)
        cat.setTitle("Cat", for: .normal)
        cat.setTitleColor(.black, for: .normal)
        cat.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        cat.imageView?.contentMode = .bottomRight
        cat.titleEdgeInsets = UIEdgeInsets(top: 45, left: -45, bottom: 0, right: 0)
        cat.imageEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: -cat.titleLabel!.frame.size.width)
        cat.layer.cornerRadius = 25
        cat.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        cat.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(cat)
        
        rodent.setImage(UIImage(named: "rodent"), for: .normal)
        rodent.setTitle("Rodent", for: .normal)
        rodent.setTitleColor(.black, for: .normal)
        rodent.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        rodent.imageView?.contentMode = .bottomRight
        rodent.titleEdgeInsets = UIEdgeInsets(top: 45, left: -35, bottom: 0, right: 0)
        rodent.imageEdgeInsets = UIEdgeInsets(top: -10, left: 20, bottom: 0, right: -rodent.titleLabel!.frame.size.width)
        rodent.layer.cornerRadius = 25
        rodent.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        rodent.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rodent)
        
        bird.setImage(UIImage(named: "bird"), for: .normal)
        bird.setTitle("Bird", for: .normal)
        bird.setTitleColor(.black, for: .normal)
        bird.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        bird.imageView?.contentMode = .bottomRight
        bird.titleEdgeInsets = UIEdgeInsets(top: 45, left: -50, bottom: 0, right: 0)
        bird.imageEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: -bird.titleLabel!.frame.size.width)
        bird.layer.cornerRadius = 25
        bird.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        bird.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bird)
        
        fish.setImage(UIImage(named: "fish"), for: .normal)
        fish.setTitle("Fish", for: .normal)
        fish.setTitleColor(.black, for: .normal)
        fish.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        fish.imageView?.contentMode = .bottomRight
        fish.titleEdgeInsets = UIEdgeInsets(top: 45, left: -45, bottom: 0, right: 0)
        fish.imageEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: -fish.titleLabel!.frame.size.width)
        fish.layer.cornerRadius = 25
        fish.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        fish.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(fish)
        
        reptile.setImage(UIImage(named: "reptile"), for: .normal)
        reptile.setTitle("Reptile", for: .normal)
        reptile.setTitleColor(.black, for: .normal)
        reptile.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        reptile.imageView?.contentMode = .bottomRight
        reptile.titleEdgeInsets = UIEdgeInsets(top: 45, left: -45, bottom: 0, right: 0)
        reptile.imageEdgeInsets = UIEdgeInsets(top: -10, left: 10, bottom: 0, right: -reptile.titleLabel!.frame.size.width)
        reptile.layer.cornerRadius = 25
        reptile.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        reptile.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(reptile)
        
        insect.setImage(UIImage(named: "insect"), for: .normal)
        insect.setTitle("Insect", for: .normal)
        insect.setTitleColor(.black, for: .normal)
        insect.imageView?.contentMode = .bottomRight
        insect.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        insect.titleEdgeInsets = UIEdgeInsets(top: 45, left: -42, bottom: 0, right: 0)
        insect.imageEdgeInsets = UIEdgeInsets(top: -10, left: 15, bottom: 0, right: -insect.titleLabel!.frame.size.width)
        insect.layer.cornerRadius = 25
        insect.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        insect.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(insect)
        
        let titl = "Other"
        let attribute: [NSAttributedString.Key: Any] = [.font: UIFont(name: "Ubuntu-Regular", size: 12)]
        let attributedTitles = NSAttributedString(string: titl, attributes: attribute)
        other.setAttributedTitle(attributedTitles, for: .normal)
        other.layer.cornerRadius = 20
        other.setTitleColor(.black, for: .normal)
        other.layer.borderWidth = 2.0
        other.layer.borderColor = UIColor.black.cgColor
        other.addTarget(self, action: #selector(changeColor), for: .touchUpInside)
        other.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(other)
        
        // pets collection view
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
        collectionView.register(PetCollectionViewCell.self, forCellWithReuseIdentifier: cellReuseID)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //filter button
        let filterImage = UIImage(systemName: "line.horizontal.3.decrease.circle")?.withTintColor(.black).withRenderingMode(.alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 24, weight: .regular))
        filter.setImage(filterImage, for: .normal)
        filter.tintColor = .black
        filter.addTarget(self, action: #selector(filterButtonTapped), for: .touchUpInside)
        
        filter.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(filter)
        
        setupConstraints()
        
    }
            
    func setupConstraints() {
        //con
        NSLayoutConstraint.activate([
            userModeView.topAnchor.constraint(equalTo: view.topAnchor,constant: 83),
            userModeView.trailingAnchor.constraint(equalTo: adopter.trailingAnchor, constant: 1),
            userModeView.heightAnchor.constraint(equalToConstant: 37),
            userModeView.widthAnchor.constraint(equalToConstant: 152)

        ])
        
        NSLayoutConstraint.activate([
            sitter.topAnchor.constraint(equalTo: view.topAnchor,constant: 85),
            sitter.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            sitter.heightAnchor.constraint(equalToConstant: 35),
            sitter.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            adopter.topAnchor.constraint(equalTo: view.topAnchor,constant: 85),
            adopter.leadingAnchor.constraint(equalTo: sitter.trailingAnchor),
            adopter.heightAnchor.constraint(equalToConstant: 35),
            adopter.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        
        let collectionViewPadding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            ovalTextField.topAnchor.constraint(equalTo: sitter.bottomAnchor, constant: 28),
            ovalTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 44),
            ovalTextField.widthAnchor.constraint(equalToConstant: 272),
            ovalTextField.heightAnchor.constraint(equalToConstant: 38.84),
            searchButton.leadingAnchor.constraint(equalTo: ovalTextField.leadingAnchor, constant: 5),
            searchButton.widthAnchor.constraint(equalToConstant: 30),
            searchButton.heightAnchor.constraint(equalToConstant: 30),
            searchButton.topAnchor.constraint(equalTo: ovalTextField.topAnchor,constant: 5)
        ])
        
        NSLayoutConstraint.activate([
            all.topAnchor.constraint(equalTo: ovalTextField.bottomAnchor, constant: 38),
            all.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 27),
            all.heightAnchor.constraint(equalToConstant: 45),
            all.widthAnchor.constraint(equalToConstant: 53)])
        
        NSLayoutConstraint.activate([
            dog.topAnchor.constraint(equalTo: all.topAnchor),
            dog.leadingAnchor.constraint(equalTo: all.trailingAnchor, constant: 3),
            dog.heightAnchor.constraint(equalToConstant: 48.31),
            dog.widthAnchor.constraint(equalToConstant: 70),
        ])

        NSLayoutConstraint.activate([
            cat.topAnchor.constraint(equalTo: dog.topAnchor),
            cat.leadingAnchor.constraint(equalTo: dog.trailingAnchor),
            cat.widthAnchor.constraint(equalToConstant: 70),
            cat.heightAnchor.constraint(equalToConstant: 37.14),
        ])
        
        NSLayoutConstraint.activate([
            rodent.topAnchor.constraint(equalTo: cat.topAnchor),
            rodent.heightAnchor.constraint(equalToConstant: 37.41),
            rodent.leadingAnchor.constraint(equalTo: cat.trailingAnchor),
            rodent.widthAnchor.constraint(equalToConstant: 75)
        ])
        
        NSLayoutConstraint.activate([
            bird.topAnchor.constraint(equalTo: rodent.topAnchor),
            bird.heightAnchor.constraint(equalToConstant: 37.41),
            bird.leadingAnchor.constraint(equalTo: rodent.trailingAnchor),
            bird.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            fish.topAnchor.constraint(equalTo: all.bottomAnchor, constant: 34.29),
            fish.heightAnchor.constraint(equalToConstant: 60),
            fish.leadingAnchor.constraint(equalTo: all.trailingAnchor, constant: -30),
            fish.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            reptile.topAnchor.constraint(equalTo: fish.topAnchor,constant: 10),
            reptile.heightAnchor.constraint(equalToConstant: 35.78),
            reptile.leadingAnchor.constraint(equalTo: fish.trailingAnchor, constant: 5),
            reptile.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            insect.topAnchor.constraint(equalTo: fish.topAnchor,constant: -2),
            insect.heightAnchor.constraint(equalToConstant: 60),
            insect.leadingAnchor.constraint(equalTo: reptile.trailingAnchor, constant: 5),
            insect.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            other.topAnchor.constraint(equalTo: insect.topAnchor, constant: 8),
            other.heightAnchor.constraint(equalToConstant: 38),
            other.leadingAnchor.constraint(equalTo: insect.trailingAnchor, constant: 10),
            other.widthAnchor.constraint(equalToConstant: 53)
        ])
            
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: fish.bottomAnchor, constant: collectionViewPadding),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: collectionViewPadding),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -collectionViewPadding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -collectionViewPadding)
        ])
        
        NSLayoutConstraint.activate([
            filter.heightAnchor.constraint(equalToConstant: 40),
            filter.topAnchor.constraint(equalTo: ovalTextField.topAnchor),
            filter.widthAnchor.constraint(equalToConstant: 50),
            filter.leadingAnchor.constraint(equalTo: ovalTextField.trailingAnchor)
        ])
    }
    
    
    
    @objc func filterButtonTapped() {
        if collectionView.tag == collectionViewTag{
            let filterView = SitterFilterViewController()
            present(filterView, animated: true, completion: nil)
        }
        else{
            let filterView = AdoperFilterViewController()
            present(filterView, animated: true, completion: nil)
        }
    }
    
    @objc func pushSearchView() {
        let vc = SearchViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false, completion: nil)
    }
    
    @objc func changeToSitter(){
        sitter.backgroundColor =  .black
        sitter.setTitleColor(.white, for: .normal)
        adopter.backgroundColor = .white
        adopter.setTitleColor(.black, for: .normal)
        collectionView.tag = collectionViewTag
        collectionView.reloadData()
    }
    
    @objc func changeToAdopter(){
        sitter.backgroundColor = .white
        sitter.setTitleColor(.black, for: .normal)
        adopter.backgroundColor = .black
        adopter.setTitleColor(.white, for: .normal)
        collectionView.tag  = AdopterCollectionViewTag
        collectionView.reloadData()
    }
    

    func review() {

        if selectedFilters == [] {
            pets = selectedPets
            adoptionPets = selectedAdoptionPets
        }
        else{
            var pet : [Pet] = []
            var adoptionPet : [AdoptionPet] = []
            for i in 0..<selectedFilters.count {
                if selectedFilters[i] == 0 || selectedFilters[i] == 1 {
                    pets = selectedPets
                    adoptionPet = selectedAdoptionPets.pet_adoption_requests
                    break
                }
                else{
                    switch selectedFilters[i]{
                    case 2:
                        pet += selectedPets.pet_sitting_requests.filter{ $0.category == "Cat"}
                        adoptionPet += selectedAdoptionPets.pet_adoption_requests.filter{ $0.category == "Cat"}
                    case 3:
                        pet += selectedPets.pet_sitting_requests.filter{$0.category == "Dog"}
                        adoptionPet += selectedAdoptionPets.pet_adoption_requests.filter{$0.category == "Dog"}
                    case 4:
                        pet += selectedPets.pet_sitting_requests.filter{$0.category == "Bunny"}
                        adoptionPet += selectedAdoptionPets.pet_adoption_requests.filter{$0.category == "Bunny"}
                    default:
                        break
                    }
                }
            }
            pets = Pets(pet_sitting_requests: pet)
            adoptionPets = AdoptionPets(pet_adoption_requests: adoptionPet)
        }
        collectionView.reloadData()
    }
    
    @objc func changeColor(_ sender: UIButton) {
        if sender.currentTitleColor == .black {
            sender.setTitleColor(.white, for: .normal)
            sender.setImage(sender.imageView?.image?.withTintColor(.white), for: .normal)
            sender.backgroundColor = .black
            }
         else {
            sender.setTitleColor(.black, for: .normal)
            sender.setImage(sender.imageView?.image?.withTintColor(.black), for: .normal)
            sender.backgroundColor = .white
        }
    }

}

extension HomeViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == collectionViewTag{
            return pets.pet_sitting_requests.count
        }
        else if collectionView.tag == filterCollectionViewTag{
            return filters.count
        }
        else if collectionView.tag == AdopterCollectionViewTag{
            return adoptionPets.pet_adoption_requests.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == collectionViewTag{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? PetCollectionViewCell{
                cell.update(pet: pets.pet_sitting_requests[indexPath.item])
                return cell
            }
            else{
                return UICollectionViewCell()
            }
        }
        else if collectionView.tag == AdopterCollectionViewTag{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? PetCollectionViewCell{
                cell.update(pet: adoptionPets.pet_adoption_requests[indexPath.item])
                return cell
            }
            else{
                return UICollectionViewCell()
            }
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == filterCollectionViewTag{
            if let cell = collectionView.cellForItem(at: indexPath) as? CustomFilterCollectionViewCell{
                let u = cell.up()
                if (u == true){
                    selectedFilters.append(indexPath.item)
                }
                else{
                    selectedFilters = selectedFilters.filter{$0 != indexPath.item}
                }
                pets = selectedPets

                review()
            }
        }
        else if collectionView.tag == collectionViewTag{
            if let cell = collectionView.cellForItem(at: indexPath) as? PetCollectionViewCell{
                navigationController?.pushViewController(ViewProfileViewController2(pet: cell)!, animated: true)
            }
        }
        else{
            if let cell = collectionView.cellForItem(at: indexPath) as? PetCollectionViewCell{
                navigationController?.pushViewController(AdopterProfileViewController(pet:cell)!, animated: true)
            }
        }
    }
}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == collectionViewTag || collectionView.tag == AdopterCollectionViewTag{
            let len = (view.frame.width - (2 * itemPadding) - sectionPadding - 30) / 2
            return CGSize(width: len, height: 3/2 * len)
        }
        else{
            let width = view.frame.width / 6
            return CGSize(width: width, height: 70)
        }
    }
}



