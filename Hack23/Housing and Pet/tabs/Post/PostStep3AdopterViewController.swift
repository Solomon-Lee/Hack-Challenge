//
//  PostStep3AdopterViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/3/23.
//

import UIKit
import PhotosUI

class PostStep3AdopterViewController: UIViewController {

    let step3Label = UILabel()
    let bottomLine = UIImageView()
    let cancelButton = UIButton()
    let nextButton = UIButton()
    let bigPic = UIImageView()
    let bigPicLabel = UIButton()
    let postPicCamera = UIButton()
    var imageArray = [UIImage]()
    let smallPic1 = UIButton()
    let smallPic2 = UIButton()
    let smallPic3 = UIButton()
    let smallPic4 = UIButton()
    var checkArray = [UIImage]()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bigPic.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        bigPic.image = nil
        imageArray = [UIImage(),UIImage(),UIImage(),UIImage(),UIImage()]
        bigPicLabel.setTitle("1/5", for: .normal)
        
        smallPic1.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic2.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic3.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic4.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic1.setImage(UIImage(), for: .normal)
        smallPic2.setImage(UIImage(), for: .normal)
        smallPic3.setImage(UIImage(), for: .normal)
        smallPic4.setImage(UIImage(), for: .normal)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        
        
        //Step3 Label
        let step3Text = NSMutableAttributedString()

        let firstLine = NSAttributedString(string: "Step 3", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 40.0)!
        ])

        let thirdLine = NSAttributedString(string: "Share some photos", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])

        let fourthLine = NSAttributedString(string: "of your pet", attributes: [
            .font: UIFont(name: "Ubuntu-Medium", size: 30.0)!
        ])
        


        step3Text.append(firstLine)
        step3Text.append(NSAttributedString(string: "\n"))
        step3Text.append(NSAttributedString(string: "\n"))
        step3Text.append(NSAttributedString(string: "\n"))
        step3Text.append(thirdLine)
        step3Text.append(NSAttributedString(string: "\n"))
        step3Text.append(fourthLine)
        
        step3Label.numberOfLines = 5
        step3Label.attributedText = step3Text
        step3Label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        step3Label.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(step3Label, at: 0)
        
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
        
        //big pic
        imageArray = [UIImage(),UIImage(),UIImage(),UIImage(),UIImage()]
        bigPic.clipsToBounds = true
        bigPic.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        bigPic.translatesAutoresizingMaskIntoConstraints = false
        bigPic.layer.cornerRadius = 30
        view.insertSubview(bigPic, at: 0)
        
        //bigPic Label
        bigPicLabel.setTitle("1/5", for: .normal)
        bigPicLabel.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        bigPicLabel.translatesAutoresizingMaskIntoConstraints = false
        bigPicLabel.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        bigPicLabel.clipsToBounds = true
        bigPicLabel.layer.cornerRadius = 15
        bigPicLabel.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.insertSubview(bigPicLabel, at: 1)
        
        //camera button
        postPicCamera.setImage(UIImage(named: "postPicIcon"), for: .normal)
        postPicCamera.translatesAutoresizingMaskIntoConstraints = false
        postPicCamera.clipsToBounds = true
        postPicCamera.addTarget(self, action: #selector(cameraClick), for: .touchUpInside)
        postPicCamera.layer.cornerRadius = 25
        view.insertSubview(postPicCamera, at: 0)
        
        //small pic1
        smallPic1.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic1.clipsToBounds = true
        smallPic1.layer.cornerRadius = 17.65
        smallPic1.translatesAutoresizingMaskIntoConstraints = false
        smallPic1.addTarget(self, action: #selector(smallPic1Click), for: .touchUpInside)
        view.insertSubview(smallPic1, at: 0)
        
        //small pic2
        smallPic2.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic2.clipsToBounds = true
        smallPic2.layer.cornerRadius = 17.65
        smallPic2.translatesAutoresizingMaskIntoConstraints = false
        smallPic2.addTarget(self, action: #selector(smallPic2Click), for: .touchUpInside)
        view.insertSubview(smallPic2, at: 0)
        
        //small pic3
        smallPic3.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic3.clipsToBounds = true
        smallPic3.layer.cornerRadius = 17.65
        smallPic3.addTarget(self, action: #selector(smallPic3Click), for: .touchUpInside)
        smallPic3.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(smallPic3, at: 0)
        
        //small pic4
        smallPic4.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 0.6)
        smallPic4.clipsToBounds = true
        smallPic4.layer.cornerRadius = 17.65
        smallPic4.addTarget(self, action: #selector(smallPic4Click), for: .touchUpInside)
        smallPic4.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(smallPic4, at: 0)
        
        setCons()
    }
    
    @objc private func smallPic1Click(){
        var temp = UIImage()
        temp = bigPic.image ?? UIImage()
        bigPic.image = smallPic1.currentImage
        smallPic1.setImage(temp, for: .normal)
        for (index,image) in self.imageArray.enumerated(){
            if bigPic.image == image{
                bigPicLabel.setTitle("\(index+1)/5", for: .normal)
            }
        }
    }
    
    @objc private func smallPic2Click(){
        var temp = UIImage()
        temp = bigPic.image ?? UIImage()
        bigPic.image = smallPic2.currentImage
        smallPic2.setImage(temp, for: .normal)
        for (index,image) in self.imageArray.enumerated(){
            if bigPic.image == image{
                bigPicLabel.setTitle("\(index+1)/5", for: .normal)
            }
        }
    }

    @objc private func smallPic3Click(){
        var temp = UIImage()
        temp = bigPic.image ?? UIImage()
        bigPic.image = smallPic3.currentImage
        smallPic3.setImage(temp, for: .normal)
        for (index,image) in self.imageArray.enumerated(){
            if bigPic.image == image{
                bigPicLabel.setTitle("\(index+1)/5", for: .normal)
            }
        }
    }

    @objc private func smallPic4Click(){
        var temp = UIImage()
        temp = bigPic.image ?? UIImage()
        bigPic.image = smallPic4.currentImage
        smallPic4.setImage(temp, for: .normal)
        for (index,image) in self.imageArray.enumerated(){
            if bigPic.image == image{
                bigPicLabel.setTitle("\(index+1)/5", for: .normal)
            }
        }
    }

    
    @objc private func xbutton(){
        self.tabBarController?.selectedIndex = 0
        self.tabBarController?.tabBar.isHidden = false
        navigationController?.setViewControllers([PostViewController()], animated: true)
    }
    
    @objc private func nextClicked(){
        if self.checkArray.isEmpty == false {
            navigationController?.pushViewController(PostStep4AdopterViewController(), animated: true)
        }
        else{
            return
        }
    }
    
    @objc private func cameraClick(){
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 5
        let phPickerVC = PHPickerViewController(configuration: config)
        phPickerVC.delegate = self
        self.present(phPickerVC,animated: true)
    }
    
    private func setCons(){
        NSLayoutConstraint.activate([
            
            //step 3 label
            step3Label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            step3Label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 31),
            
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
            
            //big pic
            bigPic.widthAnchor.constraint(equalToConstant: 342),
            bigPic.heightAnchor.constraint(equalToConstant: 262),
            bigPic.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bigPic.topAnchor.constraint(equalTo: step3Label.bottomAnchor,constant: 64),
            
            //big pic label
            bigPicLabel.bottomAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: -17),
            bigPicLabel.trailingAnchor.constraint(equalTo: bigPic.trailingAnchor,constant: -15),
            bigPicLabel.widthAnchor.constraint(equalToConstant: 50),
            bigPicLabel.heightAnchor.constraint(equalToConstant: 30),
            
            //camera button
            postPicCamera.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 26),
            postPicCamera.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 32),
            postPicCamera.heightAnchor.constraint(equalToConstant: 50),
            postPicCamera.widthAnchor.constraint(equalToConstant: 50),
            
            //small pic 1
            smallPic1.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 20),
            smallPic1.leadingAnchor.constraint(equalTo: postPicCamera.trailingAnchor,constant: 12),
            smallPic1.widthAnchor.constraint(equalToConstant: 62),
            smallPic1.heightAnchor.constraint(equalToConstant: 62),
            
            //small pic 2
            smallPic2.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 20),
            smallPic2.leadingAnchor.constraint(equalTo: smallPic1.trailingAnchor,constant: 6),
            smallPic2.widthAnchor.constraint(equalToConstant: 62),
            smallPic2.heightAnchor.constraint(equalToConstant: 62),
            
            //small pic 3
            smallPic3.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 20),
            smallPic3.leadingAnchor.constraint(equalTo: smallPic2.trailingAnchor,constant: 6),
            smallPic3.widthAnchor.constraint(equalToConstant: 62),
            smallPic3.heightAnchor.constraint(equalToConstant: 62),
            
            //small pic 4
            smallPic4.topAnchor.constraint(equalTo: bigPic.bottomAnchor,constant: 20),
            smallPic4.leadingAnchor.constraint(equalTo: smallPic3.trailingAnchor,constant: 6),
            smallPic4.widthAnchor.constraint(equalToConstant: 62),
            smallPic4.heightAnchor.constraint(equalToConstant: 62),
        ])
    }
}

extension PostStep3AdopterViewController: PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            dismiss(animated: true, completion: nil)
            
            for (index, result) in results.enumerated() {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        guard let image = image as? UIImage else { return }
                        self?.imageArray[index] = image
                        
                        DispatchQueue.main.async {
                            // Update the corresponding image view with the selected image
                            self?.bigPic.image = self?.imageArray[0]
                            self?.smallPic1.setImage(self?.imageArray[1], for: .normal)
                            self?.smallPic2.setImage(self?.imageArray[2], for: .normal)
                            self?.smallPic3.setImage(self?.imageArray[3], for: .normal)
                            self?.smallPic4.setImage(self?.imageArray[4], for: .normal)
                        }
                    }
                }
            }
        self.checkArray = self.imageArray
        }
    
}
