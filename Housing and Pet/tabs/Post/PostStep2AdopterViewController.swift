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
    static let nameField = UITextField()
    let ageLabel = UILabel()
    static let ageField = UITextField()
    let yearsOldLabel = UILabel()
    let genderLabel = UILabel()
    static let genderField = UITextField()
    let categoryLabel = UILabel()
    static let categoryField = UITextField()
    let breedLabel = UILabel()
    static let breedField = UITextField()
    let currentLocation = UILabel()
    static let onCampusButton = UIButton()
    static let offCampusButton = UIButton()
    static let outsideIthacaButton = UIButton()
    let duratonLabel = UILabel()
    static let durationStartField = UITextField()
    static let durationEndField = UITextField()
    let toLabel = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostStep2AdopterViewController.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.onCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.offCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.outsideIthacaButton.backgroundColor = .white
        
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
        PostStep2AdopterViewController.nameField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.nameField.attributedPlaceholder = nameFieldAttributedTitle
        PostStep2AdopterViewController.nameField.delegate = self
        PostStep2AdopterViewController.nameField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.nameField.autocapitalizationType = .none
        PostStep2AdopterViewController.nameField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.nameField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.nameField.autocorrectionType = .no
        PostStep2AdopterViewController.nameField.layer.borderWidth = 2
        PostStep2AdopterViewController.nameField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.nameField.clipsToBounds = true
        PostStep2AdopterViewController.nameField.layer.cornerRadius = 15
        PostStep2AdopterViewController.nameField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.nameField, at: 0)
        
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
        PostStep2AdopterViewController.ageField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.ageField.attributedPlaceholder = ageFieldAttributedTitle
        PostStep2AdopterViewController.ageField.delegate = self
        PostStep2AdopterViewController.ageField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.ageField.autocapitalizationType = .none
        PostStep2AdopterViewController.ageField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.ageField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.ageField.autocorrectionType = .no
        PostStep2AdopterViewController.ageField.layer.borderWidth = 2
        PostStep2AdopterViewController.ageField.keyboardType = .asciiCapableNumberPad
        PostStep2AdopterViewController.ageField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.ageField.clipsToBounds = true
        PostStep2AdopterViewController.ageField.layer.cornerRadius = 15
        PostStep2AdopterViewController.ageField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.ageField, at: 0)
        
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
        PostStep2AdopterViewController.genderField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.genderField.attributedPlaceholder = genderFieldAttributedTitle
        PostStep2AdopterViewController.genderField.delegate = self
        PostStep2AdopterViewController.genderField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.genderField.autocapitalizationType = .none
        PostStep2AdopterViewController.genderField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.genderField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.genderField.autocorrectionType = .no
        PostStep2AdopterViewController.genderField.layer.borderWidth = 2
        PostStep2AdopterViewController.genderField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.genderField.clipsToBounds = true
        PostStep2AdopterViewController.genderField.layer.cornerRadius = 15
        PostStep2AdopterViewController.genderField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.genderField, at: 0)
        
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
        PostStep2AdopterViewController.categoryField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.categoryField.attributedPlaceholder = categoryFieldAttributedTitle
        PostStep2AdopterViewController.categoryField.delegate = self
        PostStep2AdopterViewController.categoryField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.categoryField.autocapitalizationType = .none
        PostStep2AdopterViewController.categoryField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.categoryField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.categoryField.autocorrectionType = .no
        PostStep2AdopterViewController.categoryField.layer.borderWidth = 2
        PostStep2AdopterViewController.categoryField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.categoryField.clipsToBounds = true
        PostStep2AdopterViewController.categoryField.layer.cornerRadius = 15
        PostStep2AdopterViewController.categoryField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.categoryField, at: 0)
        
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
        PostStep2AdopterViewController.breedField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.breedField.attributedPlaceholder = breedFieldAttributedTitle
        PostStep2AdopterViewController.breedField.delegate = self
        PostStep2AdopterViewController.breedField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.breedField.autocapitalizationType = .none
        PostStep2AdopterViewController.breedField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.breedField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.breedField.autocorrectionType = .no
        PostStep2AdopterViewController.breedField.layer.borderWidth = 2
        PostStep2AdopterViewController.breedField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.breedField.clipsToBounds = true
        PostStep2AdopterViewController.breedField.layer.cornerRadius = 15
        PostStep2AdopterViewController.breedField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.breedField, at: 0)
        
        //current location
        currentLocation.text = "Current Location"
        currentLocation.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        currentLocation.font = UIFont(name: "Ubuntu-Regular", size: 14)
        currentLocation.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(currentLocation, at: 0)
        
        //on campus button
        PostStep2AdopterViewController.onCampusButton.setTitle("On-Campus", for: .normal)
        PostStep2AdopterViewController.onCampusButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.onCampusButton.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.onCampusButton.clipsToBounds = true
        PostStep2AdopterViewController.onCampusButton.addTarget(self, action: #selector(onCampusClick), for: .touchUpInside)
        PostStep2AdopterViewController.onCampusButton.layer.cornerRadius = 15
        PostStep2AdopterViewController.onCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.onCampusButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        PostStep2AdopterViewController.onCampusButton.layer.borderWidth = 2
        view.insertSubview(PostStep2AdopterViewController.onCampusButton, at: 0)
        
        //off campus button
        PostStep2AdopterViewController.offCampusButton.setTitle("Off-Campus | Ithaca", for: .normal)
        PostStep2AdopterViewController.offCampusButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.offCampusButton.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.offCampusButton.clipsToBounds = true
        PostStep2AdopterViewController.offCampusButton.addTarget(self, action: #selector(offCampusClick), for: .touchUpInside)
        PostStep2AdopterViewController.offCampusButton.layer.cornerRadius = 15
        PostStep2AdopterViewController.offCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.offCampusButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        PostStep2AdopterViewController.offCampusButton.layer.borderWidth = 2
        view.insertSubview(PostStep2AdopterViewController.offCampusButton, at: 0)
        
        //off ithaca button
        PostStep2AdopterViewController.outsideIthacaButton.setTitle("Outside Ithaca", for: .normal)
        PostStep2AdopterViewController.outsideIthacaButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.outsideIthacaButton.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.outsideIthacaButton.clipsToBounds = true
        PostStep2AdopterViewController.outsideIthacaButton.addTarget(self, action: #selector(offIthacaClick), for: .touchUpInside)
        PostStep2AdopterViewController.outsideIthacaButton.layer.cornerRadius = 15
        PostStep2AdopterViewController.outsideIthacaButton.backgroundColor = .white
        PostStep2AdopterViewController.outsideIthacaButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        PostStep2AdopterViewController.outsideIthacaButton.layer.borderWidth = 2
        view.insertSubview(PostStep2AdopterViewController.outsideIthacaButton, at: 0)
        
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
        PostStep2AdopterViewController.durationStartField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.durationStartField.attributedPlaceholder = durationStartFieldAttributedTitle
        PostStep2AdopterViewController.durationStartField.delegate = self
        PostStep2AdopterViewController.durationStartField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.durationStartField.autocapitalizationType = .none
        PostStep2AdopterViewController.durationStartField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.durationStartField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.durationStartField.autocorrectionType = .no
        PostStep2AdopterViewController.durationStartField.layer.borderWidth = 2
        PostStep2AdopterViewController.durationStartField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.durationStartField.clipsToBounds = true
        PostStep2AdopterViewController.durationStartField.layer.cornerRadius = 15
        PostStep2AdopterViewController.durationStartField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.durationStartField, at: 0)
        
        //duration end field
        let durationEndFieldPlaceHolderText = "##/####"
        let durationEndFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let durationEndFieldAttributedTitle = NSAttributedString(string: durationEndFieldPlaceHolderText, attributes: durationEndFieldTextAttributes)
        PostStep2AdopterViewController.durationEndField.translatesAutoresizingMaskIntoConstraints = false
        PostStep2AdopterViewController.durationEndField.attributedPlaceholder = durationEndFieldAttributedTitle
        PostStep2AdopterViewController.durationEndField.delegate = self
        PostStep2AdopterViewController.durationEndField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
        PostStep2AdopterViewController.durationEndField.autocapitalizationType = .none
        PostStep2AdopterViewController.durationEndField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep2AdopterViewController.durationEndField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PostStep2AdopterViewController.durationEndField.autocorrectionType = .no
        PostStep2AdopterViewController.durationEndField.layer.borderWidth = 2
        PostStep2AdopterViewController.durationEndField.font = UIFont(name: "Ubuntu-Regular", size: 12)
        PostStep2AdopterViewController.durationEndField.clipsToBounds = true
        PostStep2AdopterViewController.durationEndField.layer.cornerRadius = 15
        PostStep2AdopterViewController.durationEndField.textAlignment = .center
        view.insertSubview(PostStep2AdopterViewController.durationEndField, at: 0)
        
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
        
        if ((PostStep2AdopterViewController.nameField.text?.isEmpty == false) && (PostStep2AdopterViewController.ageField.text?.isEmpty == false) && (PostStep2AdopterViewController.genderField.text?.isEmpty == false) && (PostStep2AdopterViewController.categoryField.text?.isEmpty == false) && (PostStep2AdopterViewController.categoryField.text?.isEmpty == false) && (PostStep2AdopterViewController.breedField.text?.isEmpty == false) && (PostStep2AdopterViewController.durationStartField.text?.isEmpty == false) && (PostStep2AdopterViewController.durationEndField.text?.isEmpty == false) && (((PostStep2AdopterViewController.onCampusButton.backgroundColor != .white) || (PostStep2AdopterViewController.offCampusButton.backgroundColor != .white) || (PostStep2AdopterViewController.outsideIthacaButton.backgroundColor != .white)))) {
            navigationController?.setViewControllers([PostStep3AdopterViewController()], animated: true)
        }
        return
    }
    
    @objc private func onCampusClick(){
        PostStep2AdopterViewController.onCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        PostStep2AdopterViewController.onCampusButton.setTitleColor(.white, for: .normal)
        PostStep2AdopterViewController.offCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.outsideIthacaButton.backgroundColor = .white
        PostStep2AdopterViewController.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        
    }
    
    @objc private func offCampusClick(){
        PostStep2AdopterViewController.offCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        PostStep2AdopterViewController.offCampusButton.setTitleColor(.white, for: .normal)
        PostStep2AdopterViewController.onCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.outsideIthacaButton.backgroundColor = .white
        PostStep2AdopterViewController.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
    }
    
    @objc private func offIthacaClick(){
        PostStep2AdopterViewController.outsideIthacaButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        PostStep2AdopterViewController.outsideIthacaButton.setTitleColor(.white, for: .normal)
        PostStep2AdopterViewController.offCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        PostStep2AdopterViewController.onCampusButton.backgroundColor = .white
        PostStep2AdopterViewController.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
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
            PostStep2AdopterViewController.nameField.topAnchor.constraint(equalTo: step2Label.bottomAnchor, constant: 44),
            PostStep2AdopterViewController.nameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            PostStep2AdopterViewController.nameField.widthAnchor.constraint(equalToConstant: 125),
            PostStep2AdopterViewController.nameField.heightAnchor.constraint(equalToConstant: 30),
            
            //age label
            ageLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.ageField.centerYAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the age textfield
            PostStep2AdopterViewController.ageField.topAnchor.constraint(equalTo: PostStep2AdopterViewController.nameField.bottomAnchor, constant: 16),
            PostStep2AdopterViewController.ageField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -138),
            PostStep2AdopterViewController.ageField.widthAnchor.constraint(equalToConstant: 49),
            PostStep2AdopterViewController.ageField.heightAnchor.constraint(equalToConstant: 30),
            
            //years old label
            yearsOldLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.ageField.centerYAnchor),
            yearsOldLabel.leadingAnchor.constraint(equalTo: PostStep2AdopterViewController.ageField.trailingAnchor,constant: 8),
            
            //gender label
            genderLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.genderField.centerYAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the gender textfield
            PostStep2AdopterViewController.genderField.topAnchor.constraint(equalTo: PostStep2AdopterViewController.ageField.bottomAnchor, constant: 16),
            PostStep2AdopterViewController.genderField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            PostStep2AdopterViewController.genderField.widthAnchor.constraint(equalToConstant: 125),
            PostStep2AdopterViewController.genderField.heightAnchor.constraint(equalToConstant: 30),
            
            //category label
            categoryLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.categoryField.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the category textfield
            PostStep2AdopterViewController.categoryField.topAnchor.constraint(equalTo: PostStep2AdopterViewController.genderField.bottomAnchor, constant: 16),
            PostStep2AdopterViewController.categoryField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            PostStep2AdopterViewController.categoryField.widthAnchor.constraint(equalToConstant: 125),
            PostStep2AdopterViewController.categoryField.heightAnchor.constraint(equalToConstant: 30),
            
            //breed label
            breedLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.breedField.centerYAnchor),
            breedLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //set up the breed textfield
            PostStep2AdopterViewController.breedField.topAnchor.constraint(equalTo: PostStep2AdopterViewController.categoryField.bottomAnchor, constant: 16),
            PostStep2AdopterViewController.breedField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            PostStep2AdopterViewController.breedField.widthAnchor.constraint(equalToConstant: 125),
            PostStep2AdopterViewController.breedField.heightAnchor.constraint(equalToConstant: 30),
            
            //set up the current location label
            currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            currentLocation.topAnchor.constraint(equalTo: PostStep2AdopterViewController.breedField.bottomAnchor,constant: 24),
            
            //on campus button
            PostStep2AdopterViewController.onCampusButton.widthAnchor.constraint(equalToConstant: 94),
            PostStep2AdopterViewController.onCampusButton.heightAnchor.constraint(equalToConstant: 29),
            PostStep2AdopterViewController.onCampusButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            PostStep2AdopterViewController.onCampusButton.topAnchor.constraint(equalTo: currentLocation.bottomAnchor,constant: 16),
            
            //off campus button
            PostStep2AdopterViewController.offCampusButton.widthAnchor.constraint(equalToConstant: 138),
            PostStep2AdopterViewController.offCampusButton.heightAnchor.constraint(equalToConstant: 29),
            PostStep2AdopterViewController.offCampusButton.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.onCampusButton.centerYAnchor),
            PostStep2AdopterViewController.offCampusButton.leadingAnchor.constraint(equalTo: PostStep2AdopterViewController.onCampusButton.trailingAnchor,constant: 10),
            
            //off ithaca button
            PostStep2AdopterViewController.outsideIthacaButton.widthAnchor.constraint(equalToConstant: 110),
            PostStep2AdopterViewController.outsideIthacaButton.heightAnchor.constraint(equalToConstant: 29),
            PostStep2AdopterViewController.outsideIthacaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            PostStep2AdopterViewController.outsideIthacaButton.topAnchor.constraint(equalTo: PostStep2AdopterViewController.onCampusButton.bottomAnchor,constant: 7),
            
            //duration Label
            duratonLabel.topAnchor.constraint(equalTo: PostStep2AdopterViewController.outsideIthacaButton.bottomAnchor,constant: 16),
            duratonLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //duration Start field
            PostStep2AdopterViewController.durationStartField.topAnchor.constraint(equalTo: duratonLabel.bottomAnchor, constant: 12),
            PostStep2AdopterViewController.durationStartField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            PostStep2AdopterViewController.durationStartField.widthAnchor.constraint(equalToConstant: 93),
            PostStep2AdopterViewController.durationStartField.heightAnchor.constraint(equalToConstant: 30),
            
            //to label
            toLabel.centerYAnchor.constraint(equalTo: PostStep2AdopterViewController.durationStartField.centerYAnchor),
            toLabel.leadingAnchor.constraint(equalTo: PostStep2AdopterViewController.durationStartField.trailingAnchor,constant: 10),
            
            //duration end field
            PostStep2AdopterViewController.durationEndField.topAnchor.constraint(equalTo: duratonLabel.bottomAnchor, constant: 12),
            PostStep2AdopterViewController.durationEndField.leadingAnchor.constraint(equalTo: toLabel.trailingAnchor,constant: 10),
            PostStep2AdopterViewController.durationEndField.widthAnchor.constraint(equalToConstant: 93),
            PostStep2AdopterViewController.durationEndField.heightAnchor.constraint(equalToConstant: 30),
            
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
