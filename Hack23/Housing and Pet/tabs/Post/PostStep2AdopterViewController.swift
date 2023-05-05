//
//  PostStep2AdopterViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit

class PostStep2AdopterViewController: UIViewController {
    
    let step2Label = UILabel()
    let nameLabel = UILabel()
    let nameField = UITextField()
    let ageLabel = UILabel()
    let ageField = UITextField()
    let yearsOldLabel = UILabel()
    let genderLabel = UILabel()
    let genderField = UITextField()
    let categoryLabel = UILabel()
    let categoryField = UITextField()
    let breedLabel = UILabel()
    let breedField = UITextField()
    let currentLocation = UILabel()
    let onCampusButton = UIButton()
    let offCampusButton = UIButton()
    let outsideIthacaButton = UIButton()
    let duratonLabel = UILabel()
    let durationStartField = UITextField()
    let durationEndField = UITextField()
    let toLabel = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        onCampusButton.backgroundColor = .white
        offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        offCampusButton.backgroundColor = .white
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.backgroundColor = .white
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        
        //Step2 Label
        let step2Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 2", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Tell us some Basic", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "information about", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])
        
            let fifthLine = NSAttributedString(string: "your pet", attributes: [
                .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])


        step2Text.append(firstLine)
        step2Text.append(NSAttributedString(string: "\n"))
        step2Text.append(NSAttributedString(string: "\n"))
        step2Text.append(NSAttributedString(string: "\n"))
        step2Text.append(thirdLine)
        step2Text.append(NSAttributedString(string: "\n"))
        step2Text.append(fourthLine)
        step2Text.append(NSAttributedString(string: "\n"))
        step2Text.append(fifthLine)
        
        step2Label.numberOfLines = 6
        step2Label.attributedText = step2Text
        step2Label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        step2Label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(step2Label, at: 0)
        
        //name label
        nameLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        nameLabel.text = "Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(nameLabel, at: 0)
        
        //name field
        let nameFieldPlaceHolderText = "Enter Name"
        let nameFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let nameFieldAttributedTitle = NSAttributedString(string: nameFieldPlaceHolderText, attributes: nameFieldTextAttributes)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.attributedPlaceholder = nameFieldAttributedTitle
        nameField.delegate = self
        nameField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        nameField.autocapitalizationType = .none
        nameField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        nameField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        nameField.autocorrectionType = .no
        nameField.layer.borderWidth = 2
        nameField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        nameField.clipsToBounds = true
        nameField.layer.cornerRadius = 15
        nameField.textAlignment = .center
        view.insertSubview(nameField, at: 0)
        
        //age label
        ageLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        ageLabel.text = "Age"
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        ageLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(ageLabel, at: 0)
        
        //age field
        let ageFieldPlaceHolderText = "#"
        let ageFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let ageFieldAttributedTitle = NSAttributedString(string: ageFieldPlaceHolderText, attributes: ageFieldTextAttributes)
        ageField.translatesAutoresizingMaskIntoConstraints = false
        ageField.attributedPlaceholder = ageFieldAttributedTitle
        ageField.delegate = self
        ageField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        ageField.autocapitalizationType = .none
        ageField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        ageField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ageField.autocorrectionType = .no
        ageField.layer.borderWidth = 2
        ageField.keyboardType = .asciiCapableNumberPad
        ageField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        ageField.clipsToBounds = true
        ageField.layer.cornerRadius = 15
        ageField.textAlignment = .center
        view.insertSubview(ageField, at: 0)
        
        //years label
        yearsOldLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        yearsOldLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        yearsOldLabel.text = "year(s) old"
        yearsOldLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yearsOldLabel, at: 0)
        
        //gender label
        genderLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        genderLabel.text = "Gender"
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(genderLabel, at: 0)
        
        //gender field
        let genderFieldPlaceHolderText = "Enter Gender"
        let genderFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let genderFieldAttributedTitle = NSAttributedString(string: genderFieldPlaceHolderText, attributes: genderFieldTextAttributes)
        genderField.translatesAutoresizingMaskIntoConstraints = false
        genderField.attributedPlaceholder = genderFieldAttributedTitle
        genderField.delegate = self
        genderField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        genderField.autocapitalizationType = .none
        genderField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        genderField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        genderField.autocorrectionType = .no
        genderField.layer.borderWidth = 2
        genderField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        genderField.clipsToBounds = true
        genderField.layer.cornerRadius = 15
        genderField.textAlignment = .center
        view.insertSubview(genderField, at: 0)
        
        //category label
        categoryLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        categoryLabel.text = "Category"
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(categoryLabel, at: 0)
        
        //category field
        let categoryFieldPlaceHolderText = "Enter Category"
        let categoryFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let categoryFieldAttributedTitle = NSAttributedString(string: categoryFieldPlaceHolderText, attributes: categoryFieldTextAttributes)
        categoryField.translatesAutoresizingMaskIntoConstraints = false
        categoryField.attributedPlaceholder = categoryFieldAttributedTitle
        categoryField.delegate = self
        categoryField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        categoryField.autocapitalizationType = .none
        categoryField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        categoryField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        categoryField.autocorrectionType = .no
        categoryField.layer.borderWidth = 2
        categoryField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        categoryField.clipsToBounds = true
        categoryField.layer.cornerRadius = 15
        categoryField.textAlignment = .center
        view.insertSubview(categoryField, at: 0)
        
        //breed label
        breedLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        breedLabel.text = "Breed"
        breedLabel.translatesAutoresizingMaskIntoConstraints = false
        breedLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(breedLabel, at: 0)
        
        //breed field
        let breedFieldPlaceHolderText = "Enter Breed"
        let breedFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let breedFieldAttributedTitle = NSAttributedString(string: breedFieldPlaceHolderText, attributes: breedFieldTextAttributes)
        breedField.translatesAutoresizingMaskIntoConstraints = false
        breedField.attributedPlaceholder = breedFieldAttributedTitle
        breedField.delegate = self
        breedField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        breedField.autocapitalizationType = .none
        breedField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        breedField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        breedField.autocorrectionType = .no
        breedField.layer.borderWidth = 2
        breedField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        breedField.clipsToBounds = true
        breedField.layer.cornerRadius = 15
        breedField.textAlignment = .center
        view.insertSubview(breedField, at: 0)
        
        //current location
        currentLocation.text = "Current Location"
        currentLocation.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        currentLocation.font = UIFont(name: "Ubuntu-Regular", size: 14)
        currentLocation.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(currentLocation, at: 0)
        
        //on campus button
        onCampusButton.setTitle("On-Campus", for: .normal)
        onCampusButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        onCampusButton.translatesAutoresizingMaskIntoConstraints = false
        onCampusButton.clipsToBounds = true
        onCampusButton.addTarget(self, action: #selector(onCampusClick), for: .touchUpInside)
        onCampusButton.layer.cornerRadius = 15
        onCampusButton.backgroundColor = .white
        onCampusButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        onCampusButton.layer.borderWidth = 2
        view.insertSubview(onCampusButton, at: 0)
        
        //off campus button
        offCampusButton.setTitle("Off-Campus | Ithaca", for: .normal)
        offCampusButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        offCampusButton.translatesAutoresizingMaskIntoConstraints = false
        offCampusButton.clipsToBounds = true
        offCampusButton.addTarget(self, action: #selector(offCampusClick), for: .touchUpInside)
        offCampusButton.layer.cornerRadius = 15
        offCampusButton.backgroundColor = .white
        offCampusButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        offCampusButton.layer.borderWidth = 2
        view.insertSubview(offCampusButton, at: 0)
        
        //off ithaca button
        outsideIthacaButton.setTitle("Outside Ithaca", for: .normal)
        outsideIthacaButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.translatesAutoresizingMaskIntoConstraints = false
        outsideIthacaButton.clipsToBounds = true
        outsideIthacaButton.addTarget(self, action: #selector(offIthacaClick), for: .touchUpInside)
        outsideIthacaButton.layer.cornerRadius = 15
        outsideIthacaButton.backgroundColor = .white
        outsideIthacaButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        outsideIthacaButton.layer.borderWidth = 2
        view.insertSubview(outsideIthacaButton, at: 0)
        
        //duration label
        duratonLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        duratonLabel.text = "Duration"
        duratonLabel.translatesAutoresizingMaskIntoConstraints = false
        duratonLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(duratonLabel, at: 0)
        
        //duration start field
        let durationStartFieldPlaceHolderText = "##/####"
        let durationStartFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let durationStartFieldAttributedTitle = NSAttributedString(string: durationStartFieldPlaceHolderText, attributes: durationStartFieldTextAttributes)
        durationStartField.translatesAutoresizingMaskIntoConstraints = false
        durationStartField.attributedPlaceholder = durationStartFieldAttributedTitle
        durationStartField.delegate = self
        durationStartField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        durationStartField.autocapitalizationType = .none
        durationStartField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        durationStartField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        durationStartField.autocorrectionType = .no
        durationStartField.layer.borderWidth = 2
        durationStartField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        durationStartField.clipsToBounds = true
        durationStartField.layer.cornerRadius = 15
        durationStartField.textAlignment = .center
        view.insertSubview(durationStartField, at: 0)
        
        //duration end field
        let durationEndFieldPlaceHolderText = "##/####"
        let durationEndFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let durationEndFieldAttributedTitle = NSAttributedString(string: durationEndFieldPlaceHolderText, attributes: durationEndFieldTextAttributes)
        durationEndField.translatesAutoresizingMaskIntoConstraints = false
        durationEndField.attributedPlaceholder = durationEndFieldAttributedTitle
        durationEndField.delegate = self
        durationEndField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        durationEndField.autocapitalizationType = .none
        durationEndField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        durationEndField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        durationEndField.autocorrectionType = .no
        durationEndField.layer.borderWidth = 2
        durationEndField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        durationEndField.clipsToBounds = true
        durationEndField.layer.cornerRadius = 15
        durationEndField.textAlignment = .center
        view.insertSubview(durationEndField, at: 0)
        
        //to label
        toLabel.text = "to"
        toLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        toLabel.font = UIFont(name: "Ubuntu-Regular", size: 12)
        toLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(toLabel, at: 0)
        
        //bottom line
        bottomLine.image = UIImage(named: "postPagesLine")
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomLine, at: 0)
        
        //exitbutton
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        cancelButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(xbutton), for: .touchUpInside)
        view.insertSubview(cancelButton, at: 1)
        
        //next button
        let nextButtonTitle = "Next"
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .strokeColor: UIColor.white,
            .foregroundColor: UIColor.white,
            .strokeWidth: -1.0,
            .font: UIFont(name: "Ubuntu-Medium", size: 18) ?? .systemFont(ofSize: 18, weight: .regular),
            
        ]
        let nextAttributedTitle = NSAttributedString(string: nextButtonTitle, attributes: strokeTextAttributes)
        nextButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        nextButton.clipsToBounds = true
        nextButton.layer.cornerRadius = 20
        nextButton.setAttributedTitle(nextAttributedTitle, for: .normal)
        nextButton.titleLabel?.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        nextButton.titleLabel?.textAlignment = .center
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.addTarget(self, action: #selector(nextClicked), for: .touchUpInside)
        view.insertSubview(nextButton, at: 1)
        
        //constraints
        setCons()
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        
        if ((nameField.text?.isEmpty == false) && (ageField.text?.isEmpty == false) && (genderField.text?.isEmpty == false) && (categoryField.text?.isEmpty == false) && (categoryField.text?.isEmpty == false) && (breedField.text?.isEmpty == false) && (durationStartField.text?.isEmpty == false) && (durationEndField.text?.isEmpty == false) && (((onCampusButton.backgroundColor != .white) || (offCampusButton.backgroundColor != .white) || (outsideIthacaButton.backgroundColor != .white)))) {
            navigationController?.setViewControllers([PostStep3AdopterViewController()], animated: true)
        }
        return
    }
    
    @objc private func onCampusClick(){
        onCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        onCampusButton.setTitleColor(.white, for: .normal)
        offCampusButton.backgroundColor = .white
        offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.backgroundColor = .white
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        
    }
    
    @objc private func offCampusClick(){
        offCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        offCampusButton.setTitleColor(.white, for: .normal)
        onCampusButton.backgroundColor = .white
        onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.backgroundColor = .white
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
    }
    
    @objc private func offIthacaClick(){
        outsideIthacaButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        outsideIthacaButton.setTitleColor(.white, for: .normal)
        offCampusButton.backgroundColor = .white
        offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        onCampusButton.backgroundColor = .white
        onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //step 2 label
            step2Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            step2Label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 31),
        
            //name label
            nameLabel.topAnchor.constraint(equalTo: step2Label.bottomAnchor,constant: 48.5),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the name textfield
            nameField.topAnchor.constraint(equalTo: step2Label.bottomAnchor, constant: 44),
            nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            nameField.widthAnchor.constraint(equalToConstant: 125),
            nameField.heightAnchor.constraint(equalToConstant: 30),
            
            //age label
            ageLabel.centerYAnchor.constraint(equalTo: ageField.centerYAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the age textfield
            ageField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            ageField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -138),
            ageField.widthAnchor.constraint(equalToConstant: 49),
            ageField.heightAnchor.constraint(equalToConstant: 30),
            
            //years old label
            yearsOldLabel.centerYAnchor.constraint(equalTo: ageField.centerYAnchor),
            yearsOldLabel.leadingAnchor.constraint(equalTo: ageField.trailingAnchor,constant: 8),
            
            //gender label
            genderLabel.centerYAnchor.constraint(equalTo: genderField.centerYAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the gender textfield
            genderField.topAnchor.constraint(equalTo: ageField.bottomAnchor, constant: 16),
            genderField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            genderField.widthAnchor.constraint(equalToConstant: 125),
            genderField.heightAnchor.constraint(equalToConstant: 30),
            
            //category label
            categoryLabel.centerYAnchor.constraint(equalTo: categoryField.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the category textfield
            categoryField.topAnchor.constraint(equalTo: genderField.bottomAnchor, constant: 16),
            categoryField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            categoryField.widthAnchor.constraint(equalToConstant: 125),
            categoryField.heightAnchor.constraint(equalToConstant: 30),
            
            //breed label
            breedLabel.centerYAnchor.constraint(equalTo: breedField.centerYAnchor),
            breedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the breed textfield
            breedField.topAnchor.constraint(equalTo: categoryField.bottomAnchor, constant: 16),
            breedField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            breedField.widthAnchor.constraint(equalToConstant: 125),
            breedField.heightAnchor.constraint(equalToConstant: 30),
            
            //set up the current location label
            currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            currentLocation.topAnchor.constraint(equalTo: breedField.bottomAnchor,constant: 24),
            
            //on campus button
            onCampusButton.widthAnchor.constraint(equalToConstant: 94),
            onCampusButton.heightAnchor.constraint(equalToConstant: 29),
            onCampusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            onCampusButton.topAnchor.constraint(equalTo: currentLocation.bottomAnchor,constant: 16),
            
            //off campus button
            offCampusButton.widthAnchor.constraint(equalToConstant: 138),
            offCampusButton.heightAnchor.constraint(equalToConstant: 29),
            offCampusButton.centerYAnchor.constraint(equalTo: onCampusButton.centerYAnchor),
            offCampusButton.leadingAnchor.constraint(equalTo: onCampusButton.trailingAnchor,constant: 10),
            
            //off ithaca button
            outsideIthacaButton.widthAnchor.constraint(equalToConstant: 110),
            outsideIthacaButton.heightAnchor.constraint(equalToConstant: 29),
            outsideIthacaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            outsideIthacaButton.topAnchor.constraint(equalTo: onCampusButton.bottomAnchor,constant: 7),
            
            //duration Label
            duratonLabel.topAnchor.constraint(equalTo: outsideIthacaButton.bottomAnchor,constant: 16),
            duratonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //duration Start field
            durationStartField.topAnchor.constraint(equalTo: duratonLabel.bottomAnchor, constant: 12),
            durationStartField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            durationStartField.widthAnchor.constraint(equalToConstant: 93),
            durationStartField.heightAnchor.constraint(equalToConstant: 30),
            
            //to label
            toLabel.centerYAnchor.constraint(equalTo: durationStartField.centerYAnchor),
            toLabel.leadingAnchor.constraint(equalTo: durationStartField.trailingAnchor,constant: 10),
            
            //duration end field
            durationEndField.topAnchor.constraint(equalTo: duratonLabel.bottomAnchor, constant: 12),
            durationEndField.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor,constant: 10),
            durationEndField.widthAnchor.constraint(equalToConstant: 93),
            durationEndField.heightAnchor.constraint(equalToConstant: 30),
            
            //bottom line
            bottomLine.leftAnchor.constraint(equalTo: view.leftAnchor),
            bottomLine.rightAnchor.constraint(equalTo: view.rightAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomLine.heightAnchor.constraint(equalToConstant: 60),
            
            //cancel button
            cancelButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            cancelButton.widthAnchor.constraint(equalToConstant: 57),
            cancelButton.heightAnchor.constraint(equalToConstant: 21),
            
            //next button
            nextButton.widthAnchor.constraint(equalToConstant: 81),
            nextButton.heightAnchor.constraint(equalToConstant: 41),
            nextButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor,constant: 3),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -57),
        ])
    }
    

}
extension PostStep2AdopterViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    }
