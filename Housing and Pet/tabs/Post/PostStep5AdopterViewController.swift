//
//  PostStep5AdopterViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit
import CustomSwitch

class PostStep5AdopterViewController: UIViewController {
    
    let step5Label = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    let foodLabel = UILabel()
    let yesNoFoodswitch = CustomSwitch()
    static let yesFoodLabel = UILabel()
    let noFoodLabel = UILabel()
    static let step5TextView = UITextView()
    let placeholder = "List out the instructions to take care of\nyour pet here\n(maximum 200 words)"
    let maxWords = 200
    let awardLabel = UILabel()
    let yesNoAwardswitch = CustomSwitch()
    static let yesAwardLabel = UILabel()
    let noAwardLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        //Step4 Label
        let step5Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 5", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Leave a note to the", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "new owner", attributes: [
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
        awardLabel.text = "I will reward the adopter"
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
        PostStep5AdopterViewController.yesFoodLabel.text = "Yes"
        PostStep5AdopterViewController.yesFoodLabel.textColor = .white
        PostStep5AdopterViewController.yesFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        PostStep5AdopterViewController.yesFoodLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(PostStep5AdopterViewController.yesFoodLabel, at: 1)
        
        //no label
        noFoodLabel.text = "No"
        noFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noFoodLabel.translatesAutoresizingMaskIntoConstraints = false
        noFoodLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noFoodLabel, at: 1)
        
        //step 4 textview
        PostStep5AdopterViewController.step5TextView.clipsToBounds = true
        PostStep5AdopterViewController.step5TextView.layer.cornerRadius = 30
        PostStep5AdopterViewController.step5TextView.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        PostStep5AdopterViewController.step5TextView.layer.borderWidth = 3
        PostStep5AdopterViewController.step5TextView.text = placeholder
        PostStep5AdopterViewController.step5TextView.isEditable = true
        PostStep5AdopterViewController.step5TextView.delegate = self
        PostStep5AdopterViewController.step5TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
        PostStep5AdopterViewController.step5TextView.translatesAutoresizingMaskIntoConstraints = false
        PostStep5AdopterViewController.step5TextView.textContainerInset = UIEdgeInsets(top: 32, left: 40, bottom: 32, right: 40)
        PostStep5AdopterViewController.step5TextView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PostStep5AdopterViewController.step5TextView.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(PostStep5AdopterViewController.step5TextView, at: 0)
        
        //award switch
        yesNoAwardswitch.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(yesNoAwardswitch, at: 0)
        yesNoAwardswitch.clipsToBounds = true
        yesNoAwardswitch.layer.cornerRadius = 15
        yesNoAwardswitch.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        yesNoAwardswitch.layer.borderWidth = 2
        yesNoAwardswitch.addTarget(self, action: #selector(switchAwardButton), for: .touchUpInside)
       
        //yes label
        PostStep5AdopterViewController.yesAwardLabel.text = "Yes"
        PostStep5AdopterViewController.yesAwardLabel.textColor = .white
        PostStep5AdopterViewController.yesAwardLabel.translatesAutoresizingMaskIntoConstraints = false
        PostStep5AdopterViewController.yesAwardLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(PostStep5AdopterViewController.yesAwardLabel, at: 1)
        
        //no label
        noAwardLabel.text = "No"
        noAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        noAwardLabel.translatesAutoresizingMaskIntoConstraints = false
        noAwardLabel.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(noAwardLabel, at: 1)
        
        //constraints
        setCons()
    }
    
    @objc private func switchFoodButton(){
        if yesNoFoodswitch.isOn{
            PostStep5AdopterViewController.yesFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noFoodLabel.textColor = .white
        }
        else{
            PostStep5AdopterViewController.yesFoodLabel.textColor = .white
            noFoodLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func switchAwardButton(){
        if yesNoAwardswitch.isOn{
            PostStep5AdopterViewController.yesAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
            noAwardLabel.textColor = .white
        }
        else{
            PostStep5AdopterViewController.yesAwardLabel.textColor = .white
            noAwardLabel.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
        }
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        navigationController?.pushViewController(PostStep6AdoperViewController(), animated: true)
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
            PostStep5AdopterViewController.yesFoodLabel.leadingAnchor.constraint(equalTo: yesNoFoodswitch.leadingAnchor,constant: 15),
            PostStep5AdopterViewController.yesFoodLabel.centerYAnchor.constraint(equalTo: yesNoFoodswitch.centerYAnchor),
            
            //nolabel
            noFoodLabel.trailingAnchor.constraint(equalTo: yesNoFoodswitch.trailingAnchor,constant: -15),
            noFoodLabel.centerYAnchor.constraint(equalTo: yesNoFoodswitch.centerYAnchor),
            
            //step 4 textview
            PostStep5AdopterViewController.step5TextView.widthAnchor.constraint(equalToConstant: 340),
            PostStep5AdopterViewController.step5TextView.heightAnchor.constraint(equalToConstant: 262),
            PostStep5AdopterViewController.step5TextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PostStep5AdopterViewController.step5TextView.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 28),
            
            //award label
            awardLabel.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 318),
            awardLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 44),
            
            //yesNo Awardswitch
            yesNoAwardswitch.topAnchor.constraint(equalTo: foodLabel.bottomAnchor,constant: 310),
            yesNoAwardswitch.leadingAnchor.constraint(equalTo: awardLabel.trailingAnchor,constant: 30),
            yesNoAwardswitch.widthAnchor.constraint(equalToConstant: 90),
            yesNoAwardswitch.heightAnchor.constraint(equalToConstant: 30),
            
            //yeslabel
            PostStep5AdopterViewController.yesAwardLabel.leadingAnchor.constraint(equalTo: yesNoAwardswitch.leadingAnchor,constant: 15),
            PostStep5AdopterViewController.yesAwardLabel.centerYAnchor.constraint(equalTo: yesNoAwardswitch.centerYAnchor),
            
            //nolabel
            noAwardLabel.trailingAnchor.constraint(equalTo: yesNoAwardswitch.trailingAnchor,constant: -15),
            noAwardLabel.centerYAnchor.constraint(equalTo: yesNoAwardswitch.centerYAnchor),
            
        ])
    }
}

extension PostStep5AdopterViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if PostStep5AdopterViewController.step5TextView.text == placeholder {
            PostStep5AdopterViewController.step5TextView.text = ""
            PostStep5AdopterViewController.step5TextView.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if PostStep5AdopterViewController.step5TextView.text.isEmpty {
            PostStep5AdopterViewController.step5TextView.text = placeholder
            PostStep5AdopterViewController.step5TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
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
