//
//
//  PostStep5AdopterViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit
import CustomSwitch

class PostStep5SitterViewController: UIViewController {
    
    let step5Label = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    let foodLabel = UILabel()
    let yesNoFoodswitch = CustomSwitch()
    let yesFoodLabel = UILabel()
    let noFoodLabel = UILabel()
    let step5TextView = UITextView()
    let placeholder = "List out the instructions to take care of\nyour pet here\n(maximum 200 words)"
    let maxWords = 200
    let awardLabel = UILabel()
    let yesNoAwardswitch = CustomSwitch()
    let yesAwardLabel = UILabel()
    let noAwardLabel = UILabel()
    let housingLabel = UILabel()
    let yesNoHousingswitch = CustomSwitch()
    let yesHousingLabel = UILabel()
    let noHousingLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        //Step4 Label
        let step5Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 5", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Tell the sitters what", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "to do and the reward", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])
        


        step5Text.append(firstLine)
        step5Text.append(NSAttributedString(string: "\n"))
        step5Text.append(NSAttributedString(string: "\n"))
        step5Text.append(NSAttributedString(string: "\n"))
        step5Text.append(thirdLine)
        step5Text.append(NSAttributedString(string: "\n"))
        step5Text.append(fourthLine)
        
        step5Label.numberOfLines = 5
        step5Label.attributedText = step5Text
        step5Label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        step5Label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(step5Label, at: 0)
        
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
        
        //foodLabel
        foodLabel.text = "Food and Supplies Provided"
        foodLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        foodLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(foodLabel, at: 0)
        
        //Label
        awardLabel.text = "I will pay the sitter"
        awardLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        awardLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        awardLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(awardLabel, at: 0)
        
        //yesno switch
        yesNoFoodswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoFoodswitch, at: 0)
        yesNoFoodswitch.clipsToBounds = true
        yesNoFoodswitch.layer.cornerRadius = 15
        yesNoFoodswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoFoodswitch.layer.borderWidth = 2
        yesNoFoodswitch.addTarget(self, action: #selector(switchFoodButton), for: .touchUpInside)
       
        //yes label
        yesFoodLabel.text = "Yes"
        yesFoodLabel.textColor = .white
        yesFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        yesFoodLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(yesFoodLabel, at: 1)
        
        //no label
        noFoodLabel.text = "No"
        noFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        noFoodLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noFoodLabel, at: 1)
        
        //step 4 textview
        step5TextView.clipsToBounds = true
        step5TextView.layer.cornerRadius = 30
        step5TextView.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        step5TextView.layer.borderWidth = 3
        step5TextView.text = placeholder
        step5TextView.isEditable = true
        step5TextView.delegate = self
        step5TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
        step5TextView.translatesAutoresizingMaskIntoConstraints = false
        step5TextView.textContainerInset = UIEdgeInsets(top: 32, left: 40, bottom: 32, right: 40)
        step5TextView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        step5TextView.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(step5TextView, at: 0)
        
        //award switch
        yesNoAwardswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoAwardswitch, at: 0)
        yesNoAwardswitch.clipsToBounds = true
        yesNoAwardswitch.layer.cornerRadius = 15
        yesNoAwardswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoAwardswitch.layer.borderWidth = 2
        yesNoAwardswitch.addTarget(self, action: #selector(switchAwardButton), for: .touchUpInside)
       
        //yes label
        yesAwardLabel.text = "Yes"
        yesAwardLabel.textColor = .white
        yesAwardLabel.translatesAutoresizingMaskIntoConstraints = false
        yesAwardLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(yesAwardLabel, at: 1)
        
        //no label
        noAwardLabel.text = "No"
        noAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noAwardLabel.translatesAutoresizingMaskIntoConstraints = false
        noAwardLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noAwardLabel, at: 1)
        
        //Label
        housingLabel.text = "I will offer free housing"
        housingLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        housingLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        housingLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(housingLabel, at: 0)

        //housing switch
        yesNoHousingswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoHousingswitch, at: 0)
        yesNoHousingswitch.clipsToBounds = true
        yesNoHousingswitch.layer.cornerRadius = 15
        yesNoHousingswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoHousingswitch.layer.borderWidth = 2
        yesNoHousingswitch.addTarget(self, action: #selector(switchHousingButton), for: .touchUpInside)
       
        //yes label
        yesHousingLabel.text = "Yes"
        yesHousingLabel.textColor = .white
        yesHousingLabel.translatesAutoresizingMaskIntoConstraints = false
        yesHousingLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(yesHousingLabel, at: 1)
        
        //no label
        noHousingLabel.text = "No"
        noHousingLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noHousingLabel.translatesAutoresizingMaskIntoConstraints = false
        noHousingLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noHousingLabel, at: 1)
        
        //constraints
        setCons()
    }
    
    @objc private func switchFoodButton(){
        if yesNoFoodswitch.isOn{
            yesFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noFoodLabel.textColor = .white
        }
        else{
            yesFoodLabel.textColor = .white
            noFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func switchHousingButton(){
        if yesNoHousingswitch.isOn{
            yesHousingLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noHousingLabel.textColor = .white
        }
        else{
            yesHousingLabel.textColor = .white
            noHousingLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func switchAwardButton(){
        if yesNoAwardswitch.isOn{
            yesAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noAwardLabel.textColor = .white
        }
        else{
            yesAwardLabel.textColor = .white
            noAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        navigationController?.pushViewController(PostStep6SitterViewController(), animated: true)
    }
    
    
    
    private func setCons(){
        NSLayoutConstraint.activate([
        
            //step 5 label
            step5Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            step5Label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 31),
            
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
            
            //Food label
            foodLabel.topAnchor.constraint(equalTo: step5Label.bottomAnchor,constant: 72),
            foodLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 44),
            
            //yesNo Foodswitch
            yesNoFoodswitch.topAnchor.constraint(equalTo: step5Label.bottomAnchor,constant: 64),
            yesNoFoodswitch.leadingAnchor.constraint(equalTo: foodLabel.trailingAnchor,constant: 15),
            yesNoFoodswitch.widthAnchor.constraint(equalToConstant: 90),
            yesNoFoodswitch.heightAnchor.constraint(equalToConstant: 30),
            
            //yeslabel
            yesFoodLabel.leadingAnchor.constraint(equalTo: yesNoFoodswitch.leadingAnchor,constant: 15),
            yesFoodLabel.centerYAnchor.constraint(equalTo: yesNoFoodswitch.centerYAnchor),
            
            //nolabel
            noFoodLabel.trailingAnchor.constraint(equalTo: yesNoFoodswitch.trailingAnchor,constant: -15),
            noFoodLabel.centerYAnchor.constraint(equalTo: yesNoFoodswitch.centerYAnchor),
            
            //step 4 textview
            step5TextView.widthAnchor.constraint(equalToConstant: 340),
            step5TextView.heightAnchor.constraint(equalToConstant: 262),
            step5TextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            step5TextView.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 28),
            
            //award label
            awardLabel.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 318),
            awardLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //yesNo Awardswitch
            yesNoAwardswitch.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 310),
            yesNoAwardswitch.leadingAnchor.constraint(equalTo: yesNoFoodswitch.leadingAnchor),
            yesNoAwardswitch.widthAnchor.constraint(equalToConstant: 90),
            yesNoAwardswitch.heightAnchor.constraint(equalToConstant: 30),
            
            //yeslabel
            yesAwardLabel.leadingAnchor.constraint(equalTo: yesNoAwardswitch.leadingAnchor,constant: 15),
            yesAwardLabel.centerYAnchor.constraint(equalTo: yesNoAwardswitch.centerYAnchor),
            
            //nolabel
            noAwardLabel.trailingAnchor.constraint(equalTo: yesNoAwardswitch.trailingAnchor,constant: -15),
            noAwardLabel.centerYAnchor.constraint(equalTo: yesNoAwardswitch.centerYAnchor),
            
            //housing label
            housingLabel.topAnchor.constraint(equalTo: awardLabel.bottomAnchor,constant: 25),
            housingLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 64),
            
            //yesNo Housingswitch
            yesNoHousingswitch.topAnchor.constraint(equalTo: yesNoAwardswitch.bottomAnchor,constant: 16),
            yesNoHousingswitch.leadingAnchor.constraint(equalTo: yesNoFoodswitch.leadingAnchor),
            yesNoHousingswitch.widthAnchor.constraint(equalToConstant: 90),
            yesNoHousingswitch.heightAnchor.constraint(equalToConstant: 30),
            
            //yeslabel
            yesHousingLabel.leadingAnchor.constraint(equalTo: yesNoAwardswitch.leadingAnchor,constant: 15),
            yesHousingLabel.centerYAnchor.constraint(equalTo: yesNoHousingswitch.centerYAnchor),
            
            //nolabel
            noHousingLabel.trailingAnchor.constraint(equalTo: yesNoAwardswitch.trailingAnchor,constant: -15),
            noHousingLabel.centerYAnchor.constraint(equalTo: yesNoHousingswitch.centerYAnchor),
        ])
    }
}

extension PostStep5SitterViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if step5TextView.text == placeholder {
            step5TextView.text = ""
            step5TextView.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if step5TextView.text.isEmpty {
           step5TextView.text = placeholder
            step5TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            // Calculate the new number of words
            let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
            let words = newText.components(separatedBy: .whitespacesAndNewlines)
            let numWords = words.count
            
            // Limit to the maximum number of words
            return numWords <= maxWords
        }
    
}
