//
//  ViewProfile.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/5/23.
//

import Foundation
import UIKit
import CustomSwitch

class ViewProfileViewController: UIViewController {
    
    let profilePic = UIButton()
    let genderLabel = UILabel()
    let genderTextField = UITextField()
    let ageLabel = UILabel()
    let ageTextField = UITextField()
    let studentLabel = UILabel()
    let ownPetLabel = UILabel()
    let personalInfo = UILabel()
    let contactInfo = UILabel()
    let phoneNumLabel = UILabel()
    let phoneNumField = UITextField()
    let emailAddressLabel = UILabel()
    let emailAddressView = UITextField()
    let saveButton = UIBarButtonItem()
    let yesNoStudentswitch = CustomSwitch()
    var yesStudentLabel = UILabel()
    var noStudentLabel = UILabel()
    let currentLocation = UILabel()
    let onCampusButton = UIButton()
    let offCampusButton = UIButton()
    let outsideIthacaButton = UIButton()
    let yesNoPetswitch = CustomSwitch()
    var yesPetLabel = UILabel()
    var noPetLabel = UILabel()
    let bottomLine = UIImageView()
    let nextButton = UIButton()
    let cancelButton = UIButton()
    let completeProfile = UILabel()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.isNavigationBarHidden = true
        
        NetworkManager.shared.getUserbyToken(token: ProfileViewController.backEndToken) { Appuser in
            self.genderTextField.text = Appuser.gender ?? ""
            self.ageTextField.text = Appuser.age ?? ""
            if (Appuser.college_student ?? true){
                print("yesNostudentSwitch is on")
                self.yesStudentLabel.text = "Yes"
                self.noStudentLabel.text = "No"
            }
            else{
                self.yesStudentLabel.text = "No"
                self.noStudentLabel.text = "Yes"
                print("yesNoStudentswitch is off")
            }
            if (Appuser.curr_location != nil) && (Appuser.curr_location == "On-Campus"){
                self.onCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                self.onCampusButton.setTitleColor(.white, for: .normal)
                self.offCampusButton.backgroundColor = .white
                self.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
                self.outsideIthacaButton.backgroundColor = .white
                self.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
            }
            else if (Appuser.curr_location != nil) && (Appuser.curr_location == "Off-Campus | Ithaca"){
                self.offCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                self.offCampusButton.setTitleColor(.white, for: .normal)
                self.onCampusButton.backgroundColor = .white
                self.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
                self.outsideIthacaButton.backgroundColor = .white
                self.outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
            }
            else if (Appuser.curr_location != nil) && (Appuser.curr_location == "Outside Ithaca"){
                self.outsideIthacaButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                self.outsideIthacaButton.setTitleColor(.white, for: .normal)
                self.offCampusButton.backgroundColor = .white
                self.offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
                self.onCampusButton.backgroundColor = .white
                self.onCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
            }
            if (Appuser.pet_owner_boolean ?? true){
                self.yesPetLabel.text = "Yes"
                self.noPetLabel.text = "No"

            }
            else{
                self.yesPetLabel.text = "No"
                self.noPetLabel.text = "Yes"
            }
            self.phoneNumField.text = Appuser.phone ?? ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                self.personalInfo.text = user.username
                self.emailAddressView.text = user.email
            }
            
        }
        
        //complete Profile
        completeProfile.text = "My Profile"
        completeProfile.font = UIFont(name: "Ubuntu-Medium", size: 18)
        completeProfile.translatesAutoresizingMaskIntoConstraints = false
        completeProfile.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        view.insertSubview(completeProfile, at: 0)
        
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
        onCampusButton.isEnabled = false
        onCampusButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        onCampusButton.layer.borderWidth = 2
        view.insertSubview(onCampusButton, at: 0)
        
        //bottom line
        bottomLine.image = UIImage(named: "postPagesLine")
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(bottomLine, at: 0)
        
        //next button
        let nextButtonTitle = "Done"
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
        offCampusButton.isEnabled = false
        offCampusButton.layer.borderWidth = 2
        view.insertSubview(offCampusButton, at: 0)
        
        //off ithaca button
        outsideIthacaButton.setTitle("Outside Ithaca", for: .normal)
        outsideIthacaButton.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 12)
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.translatesAutoresizingMaskIntoConstraints = false
        outsideIthacaButton.clipsToBounds = true
        outsideIthacaButton.isEnabled = false
        outsideIthacaButton.addTarget(self, action: #selector(offIthacaClick), for: .touchUpInside)
        outsideIthacaButton.layer.cornerRadius = 15
        outsideIthacaButton.backgroundColor = .white
        outsideIthacaButton.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        outsideIthacaButton.layer.borderWidth = 2
        view.insertSubview(outsideIthacaButton, at: 0)
        
            
        //personal info label
        personalInfo.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        personalInfo.font = UIFont(name: "Ubuntu-Medium", size: 25)
        personalInfo.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(personalInfo, at: 0)
        
        //profile img
        profilePic.setImage(UIImage(named:"default_profile"), for: .normal)
        profilePic.layer.cornerRadius = 130/2
        profilePic.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        profilePic.layer.borderWidth = 2
        profilePic.clipsToBounds = true
        profilePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(profilePic, at: 0)
        
        
        //gender label
        genderLabel.text = "Gender"
        genderLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        genderLabel.textColor = .black
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(genderLabel, at: 0)
        
        //gender field
        let genderFieldPlaceHolderText = "Not provided"
        let genderFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let genderFieldAttributedTitle = NSAttributedString(string: genderFieldPlaceHolderText, attributes: genderFieldTextAttributes)
        genderTextField.translatesAutoresizingMaskIntoConstraints = false
        genderTextField.attributedPlaceholder = genderFieldAttributedTitle
        genderTextField.delegate = self
        genderTextField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        genderTextField.autocapitalizationType = .none
        genderTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        genderTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        genderTextField.layer.borderWidth = 2
        genderTextField.font = UIFont(name: "Ubuntu-Regular", size: 14)
        genderTextField.clipsToBounds = true
        genderTextField.isUserInteractionEnabled = false
        genderTextField.layer.cornerRadius = 15
        genderTextField.autocorrectionType = .no
        genderTextField.textAlignment = .center
        genderTextField.autocapitalizationType = .none
        genderTextField.delegate = self
        view.insertSubview(genderTextField, at: 0)
        
        //age label
        ageLabel.text = "Age Group"
        ageLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        ageLabel.textColor = .black
        ageLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(ageLabel, at: 0)
        
        //age field
        let ageFieldPlaceHolderText = "Not Provided"
        let ageFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let ageFieldAttributedTitle = NSAttributedString(string: ageFieldPlaceHolderText, attributes: ageFieldTextAttributes)
        ageTextField.translatesAutoresizingMaskIntoConstraints = false
        ageTextField.attributedPlaceholder = ageFieldAttributedTitle
        ageTextField.delegate = self
        ageTextField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        ageTextField.autocapitalizationType = .none
        ageTextField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        ageTextField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        ageTextField.layer.borderWidth = 2
        ageTextField.font = UIFont(name: "Ubuntu-Regular", size: 14)
        ageTextField.clipsToBounds = true
        ageTextField.isUserInteractionEnabled = false
        ageTextField.layer.cornerRadius = 15
        ageTextField.autocorrectionType = .no
        ageTextField.textAlignment = .center
        ageTextField.autocapitalizationType = .none
        ageTextField.delegate = self
        view.insertSubview(ageTextField, at: 0)
        
        //student label
        studentLabel.text = "College Student"
        studentLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        studentLabel.textColor = .black
        studentLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(studentLabel, at: 0)
        
        //yes label
//        yesStudentLabel.text = "Yes"
        yesStudentLabel.textColor = .white
        yesStudentLabel.translatesAutoresizingMaskIntoConstraints = false
        yesStudentLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(yesStudentLabel, at: 1)
        
        //no label
//        noStudentLabel.text = "No"
        noStudentLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noStudentLabel.translatesAutoresizingMaskIntoConstraints = false
        noStudentLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noStudentLabel, at: 1)
        
        //yesno switch
        yesNoStudentswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoStudentswitch, at: 0)
        yesNoStudentswitch.clipsToBounds = true
        yesNoStudentswitch.isEnabled = false
        yesNoStudentswitch.layer.cornerRadius = 15
        yesNoStudentswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoStudentswitch.layer.borderWidth = 2
        yesNoStudentswitch.addTarget(self, action: #selector(switchStudentButton), for: .touchUpInside)
        
        //ownPet label
        ownPetLabel.text = "Own Pet(s)"
        ownPetLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        ownPetLabel.textColor = .black
        ownPetLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(ownPetLabel, at: 0)
        
        //yes label
//        yesPetLabel.text = "Yes"
        yesPetLabel.textColor = .white
        yesPetLabel.translatesAutoresizingMaskIntoConstraints = false
        yesPetLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(yesPetLabel, at: 1)
        
        //no label
//        noPetLabel.text = "No"
        noPetLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noPetLabel.translatesAutoresizingMaskIntoConstraints = false
        noPetLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noPetLabel, at: 1)
        
        //yesno switch
        yesNoPetswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoPetswitch, at: 0)
        yesNoPetswitch.clipsToBounds = true
        yesNoPetswitch.isEnabled = false
        yesNoPetswitch.layer.cornerRadius = 15
        yesNoPetswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoPetswitch.layer.borderWidth = 2
        yesNoPetswitch.addTarget(self, action: #selector(switchPetButton), for: .touchUpInside)
        
        
        //contact Info label
        contactInfo.text = "Contact Information"
        contactInfo.font = UIFont(name: "Ubuntu-Regular", size: 14)
        contactInfo.textColor = .black
        contactInfo.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(contactInfo, at: 0)
        
        //phone number label
        phoneNumLabel.text = "Phone Number"
        phoneNumLabel.font = UIFont(name: "Ubuntu-Medium", size: 12)
        phoneNumLabel.textColor = .black
        phoneNumLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(phoneNumLabel, at: 0)
        
        //phone num field
        let phoneFieldPlaceHolderText = "Not provided"
        let phoneFieldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "Ubuntu-Regular", size: 14) ?? .systemFont(ofSize: 14, weight: .regular),
            .foregroundColor: UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1),
        ]
        let phoneFieldAttributedTitle = NSAttributedString(string: phoneFieldPlaceHolderText, attributes: phoneFieldTextAttributes)
        phoneNumField.translatesAutoresizingMaskIntoConstraints = false
        phoneNumField.attributedPlaceholder = phoneFieldAttributedTitle
        phoneNumField.delegate = self
        phoneNumField.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        phoneNumField.autocapitalizationType = .none
        phoneNumField.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        phoneNumField.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        phoneNumField.layer.borderWidth = 2
        phoneNumField.font = UIFont(name: "Ubuntu-Regular", size: 14)
        phoneNumField.clipsToBounds = true
        phoneNumField.layer.cornerRadius = 15
        phoneNumField.isEnabled = false
        phoneNumField.keyboardType = .asciiCapableNumberPad
        phoneNumField.autocorrectionType = .no
        phoneNumField.textAlignment = .center
        phoneNumField.autocapitalizationType = .none
        phoneNumField.delegate = self
        view.insertSubview(phoneNumField, at: 0)
        
        //email label
        emailAddressLabel.text = "Email Address"
        emailAddressLabel.font = UIFont(name: "Ubuntu-Medium", size: 12)
        emailAddressLabel.textColor = .black
        emailAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(emailAddressLabel, at: 0)
        
        //exitbutton
        cancelButton.setImage(UIImage(named: "back"), for: .normal)
        cancelButton.clipsToBounds = true
        cancelButton.layer.cornerRadius = 39.16/2
        cancelButton.layer.borderWidth = 2
        cancelButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.addTarget(self, action: #selector(button1), for: .touchUpInside)
        view.insertSubview(cancelButton, at: 1)
        
        //email Address
        emailAddressView.translatesAutoresizingMaskIntoConstraints = false
        emailAddressView.textColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        emailAddressView.autocapitalizationType = .none
        emailAddressView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        emailAddressView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        emailAddressView.layer.borderWidth = 2
        emailAddressView.font = UIFont(name: "Ubuntu-Regular", size: 12)
        emailAddressView.clipsToBounds = true
        emailAddressView.layer.cornerRadius = 15
        emailAddressView.isUserInteractionEnabled = false
        emailAddressView.keyboardType = .asciiCapableNumberPad
        emailAddressView.autocorrectionType = .no
        emailAddressView.textAlignment = .center
        emailAddressView.autocapitalizationType = .none
        view.insertSubview(emailAddressView, at: 0)
        
        setCons()
    }
    @objc private func onCampusClick(){
        onCampusButton.backgroundColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        onCampusButton.setTitleColor(.white, for: .normal)
        offCampusButton.backgroundColor = .white
        offCampusButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
        outsideIthacaButton.backgroundColor = .white
        outsideIthacaButton.setTitleColor(UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1), for: .normal)
    }
    
    @objc private func button1(){
        print("cancel")
        self.tabBarController?.selectedIndex = 4
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([ProfileViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        self.tabBarController?.selectedIndex = 4
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([ProfileViewController()], animated: true)
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
    
    @objc private func switchStudentButton(){
        if yesNoStudentswitch.isOn{
            yesStudentLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noStudentLabel.textColor = .white
        }
        else{
            yesStudentLabel.textColor = .white
            noStudentLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func switchPetButton(){
        if yesNoPetswitch.isOn{
            yesPetLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noPetLabel.textColor = .white
        }
        else{
            yesPetLabel.textColor = .white
            noPetLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    
    
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
        //complete profile
            completeProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            completeProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        //set up the current location label
        currentLocation.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        currentLocation.topAnchor.constraint(equalTo: studentLabel.bottomAnchor,constant: 20),
        
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
        
        //bottom line
        bottomLine.leftAnchor.constraint(equalTo: view.leftAnchor),
        bottomLine.rightAnchor.constraint(equalTo: view.rightAnchor),
        bottomLine.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        bottomLine.heightAnchor.constraint(equalToConstant: 60),
        
        //cancel button
            cancelButton.centerYAnchor.constraint(equalTo: completeProfile.centerYAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 31),
            
        //next button
        nextButton.widthAnchor.constraint(equalToConstant: 81),
        nextButton.heightAnchor.constraint(equalToConstant: 41),
        nextButton.centerYAnchor.constraint(equalTo: bottomLine.centerYAnchor,constant: 3),
            nextButton.centerXAnchor.constraint(equalTo: bottomLine.centerXAnchor),
        
        //off ithaca button
        outsideIthacaButton.widthAnchor.constraint(equalToConstant: 110),
        outsideIthacaButton.heightAnchor.constraint(equalToConstant: 29),
        outsideIthacaButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        outsideIthacaButton.topAnchor.constraint(equalTo: onCampusButton.bottomAnchor,constant: 7),
            
        //yesNo Studentswitch
        yesNoStudentswitch.topAnchor.constraint(equalTo: ageTextField.bottomAnchor,constant: 16),
        yesNoStudentswitch.centerXAnchor.constraint(equalTo: ageTextField.centerXAnchor),
        yesNoStudentswitch.widthAnchor.constraint(equalToConstant: 90),
        yesNoStudentswitch.heightAnchor.constraint(equalToConstant: 30),
        
        //yeslabel
        yesStudentLabel.leadingAnchor.constraint(equalTo: yesNoStudentswitch.leadingAnchor,constant: 15),
        yesStudentLabel.centerYAnchor.constraint(equalTo: yesNoStudentswitch.centerYAnchor),
        
        //nolabel
        noStudentLabel.trailingAnchor.constraint(equalTo: yesNoStudentswitch.trailingAnchor,constant: -15),
        noStudentLabel.centerYAnchor.constraint(equalTo: yesNoStudentswitch.centerYAnchor),
        
        //yesNo Petswitch
        yesNoPetswitch.topAnchor.constraint(equalTo: outsideIthacaButton.bottomAnchor,constant: 16),
        yesNoPetswitch.centerXAnchor.constraint(equalTo: ageTextField.centerXAnchor),
        yesNoPetswitch.widthAnchor.constraint(equalToConstant: 90),
        yesNoPetswitch.heightAnchor.constraint(equalToConstant: 30),
        
        //yeslabel
        yesPetLabel.leadingAnchor.constraint(equalTo: yesNoPetswitch.leadingAnchor,constant: 15),
        yesPetLabel.centerYAnchor.constraint(equalTo: yesNoPetswitch.centerYAnchor),
        
        //nolabel
        noPetLabel.trailingAnchor.constraint(equalTo: yesNoPetswitch.trailingAnchor,constant: -15),
        noPetLabel.centerYAnchor.constraint(equalTo: yesNoPetswitch.centerYAnchor),
        
        //profile pic
            profilePic.widthAnchor.constraint(equalToConstant: 130),
            profilePic.heightAnchor.constraint(equalToConstant: 130),
            profilePic.topAnchor.constraint(equalTo: completeProfile.bottomAnchor,constant: 30),
            profilePic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        
        //personal info
            personalInfo.topAnchor.constraint(equalTo: profilePic.bottomAnchor,constant: 12),
            personalInfo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        //gender
            genderLabel.centerYAnchor.constraint(equalTo: genderTextField.centerYAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
        //gender textfield
            genderTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            genderTextField.widthAnchor.constraint(equalToConstant: 125),
            genderTextField.heightAnchor.constraint(equalToConstant: 30),
            genderTextField.topAnchor.constraint(equalTo: personalInfo.bottomAnchor,constant: 23),
        
        //age
            ageLabel.centerYAnchor.constraint(equalTo: ageTextField.centerYAnchor),
            ageLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
        //age textfield
            ageTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -64),
            ageTextField.widthAnchor.constraint(equalToConstant: 125),
            ageTextField.heightAnchor.constraint(equalToConstant: 30),
            ageTextField.topAnchor.constraint(equalTo: genderTextField.bottomAnchor,constant: 16),
        
        //student
        studentLabel.centerYAnchor.constraint(equalTo: yesNoStudentswitch.centerYAnchor),
            studentLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),

        //own pet
        ownPetLabel.centerYAnchor.constraint(equalTo: yesNoPetswitch.centerYAnchor),
            ownPetLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        
        //contact info
        contactInfo.topAnchor.constraint(equalTo: yesNoPetswitch.bottomAnchor,constant: 16),
        contactInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        
        //Phone Number
            phoneNumLabel.topAnchor.constraint(equalTo: contactInfo.bottomAnchor,constant: 12),
        phoneNumLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        
        //phone Number textfield
            phoneNumField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            phoneNumField.widthAnchor.constraint(equalToConstant: 248),
            phoneNumField.heightAnchor.constraint(equalToConstant: 30),
            phoneNumField.topAnchor.constraint(equalTo: phoneNumLabel.bottomAnchor,constant: 5),
            
        //Email Address
            emailAddressLabel.topAnchor.constraint(equalTo: phoneNumField.bottomAnchor,constant: 12),
        emailAddressLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
        
        //Email View
            emailAddressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailAddressView.widthAnchor.constraint(equalToConstant: 248),
            emailAddressView.heightAnchor.constraint(equalToConstant: 30),
            emailAddressView.topAnchor.constraint(equalTo: emailAddressLabel.bottomAnchor,constant: 5),
            
        ])
    }
    

}
extension ViewProfileViewController: UITextFieldDelegate{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if textField == ageTextField {
                let allowedCharacterSet = CharacterSet(charactersIn: "0123456789").inverted
                let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
                let filtered = newString.components(separatedBy: allowedCharacterSet).joined(separator: "")
                return newString == filtered && Int(newString) ?? 0 <= 120
            }
            if textField == phoneNumField{
                
                //only numbers
                let allowedCharacters = CharacterSet.decimalDigits
                let characterSet = CharacterSet(charactersIn: string)
                
                //maximum length
                let maxLength = 10
                    let currentString = (textField.text ?? "") as NSString
                    let newString = currentString.replacingCharacters(in: range, with: string)

                return allowedCharacters.isSuperset(of: characterSet) && newString.count <= maxLength

            }
            return true
        }
    }
    

