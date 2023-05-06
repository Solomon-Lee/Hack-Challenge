//
//  PostStep4SitterViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit

class PostStep4SitterViewController: UIViewController {
    
    let step4Label = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    let step4TextView = UITextView()
    let placeholder = "Enter a brief description of your pet here (maximum 200 words)"
    let maxWords = 200


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        //Step4 Label
        let step4Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 4", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Tell the sitters more", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "about your pet", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])
        


        step4Text.append(firstLine)
        step4Text.append(NSAttributedString(string: "\n"))
        step4Text.append(NSAttributedString(string: "\n"))
        step4Text.append(NSAttributedString(string: "\n"))
        step4Text.append(thirdLine)
        step4Text.append(NSAttributedString(string: "\n"))
        step4Text.append(fourthLine)
        
        step4Label.numberOfLines = 5
        step4Label.attributedText = step4Text
        step4Label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        step4Label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(step4Label, at: 0)
        
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
        
        //step 4 textview
        step4TextView.clipsToBounds = true
        step4TextView.layer.cornerRadius = 30
        step4TextView.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
        step4TextView.layer.borderWidth = 3
        step4TextView.text = placeholder
        step4TextView.isEditable = true
        step4TextView.delegate = self
        step4TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
        step4TextView.translatesAutoresizingMaskIntoConstraints = false
        step4TextView.textContainerInset = UIEdgeInsets(top: 32, left: 40, bottom: 32, right: 40)
        step4TextView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        step4TextView.font = UIFont(name: "Ubuntu-Regular", size: 14)
        view.insertSubview(step4TextView, at: 0)
        
        setCons()
    }
    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        navigationController?.pushViewController(PostStep5SitterViewController(), animated: true)
    }
    
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //step 4 label
            step4Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            step4Label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 31),
            
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
            
            //step 4 textview
            step4TextView.widthAnchor.constraint(equalToConstant: 340),
            step4TextView.heightAnchor.constraint(equalToConstant: 262),
            step4TextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            step4TextView.topAnchor.constraint(equalTo: step4Label.bottomAnchor,constant: 64),
        ])
    }

}

extension PostStep4SitterViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if step4TextView.text == placeholder {
            step4TextView.text = ""
            step4TextView.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1)
                }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if step4TextView.text.isEmpty {
           step4TextView.text = placeholder
            step4TextView.textColor = UIColor(red: 0.48, green: 0.49, blue: 0.53, alpha: 1)
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
