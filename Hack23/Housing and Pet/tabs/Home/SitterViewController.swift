//
//  FilterViewController.swift
//  hackathon
//
//  Created by Eman Abdu on 5/2/23.
//

import UIKit

class SitterFilterViewController : UIViewController {
    
    let cancelButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let resetButton = UIButton()
    let petsLabel = UILabel()
    let petsVIew = UIView()
    let onePet = UIButton()
    let morePet = UIButton()
    let anyPet = UIButton()
    let locationLabel = UILabel()
    let locationView  = UIView()
    let location1 = UIButton()
    let location2 = UIButton()
    let location3 = UIButton()
    let location4 = UIButton()
    let timeLabel = UILabel()
    let calendar = UIButton()
    let calendarField = UITextField()
    let sortLabel = UILabel()
    let sortView = UIView()
    let sort1 = UIButton()
    let sort2 = UIButton()
    let sort3 = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 5.0
        title = "Filter"
        
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissSearchView), for: .touchUpInside)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.tintColor = .black
        view.addSubview(cancelButton )
        
        titleLabel.text = "Filter"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        resetButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        resetButton.setTitle("Reset", for: .normal)
        resetButton.addTarget(self, action: #selector(reset), for: .touchUpInside)
        resetButton.backgroundColor = .black
        resetButton.layer.cornerRadius = resetButton.frame.height / 2
        resetButton.clipsToBounds = true
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetButton)
        
        petsLabel.text = "Number of Pets"
        petsLabel.font = UIFont.boldSystemFont(ofSize: 18)
        petsLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        petsLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(petsLabel)
        
        onePet.setTitle("Sitter", for: .normal)
        onePet.setTitleColor(.black, for: .normal)
        onePet.backgroundColor =  .white
        onePet.layer.cornerRadius = 18
        onePet.addTarget(self, action: #selector(onePetButton), for: .touchUpInside)
        onePet.translatesAutoresizingMaskIntoConstraints = false
        petsVIew.addSubview(onePet)
        
        morePet.setTitle("More", for: .normal)
        morePet.setTitleColor(.black, for: .normal)
        morePet.backgroundColor =  .white
        morePet.layer.cornerRadius = 18
        morePet.addTarget(self, action: #selector(morePetButton), for: .touchUpInside)
        morePet.translatesAutoresizingMaskIntoConstraints = false
        petsVIew.addSubview(morePet)
        
        anyPet.setTitle("Any", for: .normal)
        anyPet.setTitleColor(.white, for: .normal)
        anyPet.backgroundColor =  .black
        anyPet.layer.cornerRadius = 18
        anyPet.addTarget(self, action: #selector(anyPetButton), for: .touchUpInside)
        anyPet.translatesAutoresizingMaskIntoConstraints = false
        petsVIew.addSubview(anyPet)
        
        petsVIew.layer.cornerRadius = 20
        petsVIew.layer.borderWidth = 2.0
        petsVIew.backgroundColor = .white
        petsVIew.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(petsVIew)
        
        locationLabel.text = "Preferred Location"
        locationLabel.font = UIFont.boldSystemFont(ofSize: 18)
        locationLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationLabel)
        
        locationView.backgroundColor = .white
        locationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationView)
        
        location1.layer.cornerRadius = 20
        location1.layer.borderWidth = 2.0
        location1.backgroundColor = .white
        location1.setTitle("On-Campus", for: .normal)
        location1.setTitleColor(.black, for: .normal)
        location1.addTarget(self, action: #selector(setLocation1), for: .touchUpInside)
        location1.translatesAutoresizingMaskIntoConstraints = false
        locationView.addSubview(location1)
        
        location2.layer.cornerRadius = 20
        location2.layer.borderWidth = 2.0
        location2.backgroundColor = .white
        location2.setTitle("Off-Campus | Ithaca", for: .normal)
        location2.setTitleColor(.black, for: .normal)
        location2.addTarget(self, action: #selector(setLocation2), for: .touchUpInside)
        location2.translatesAutoresizingMaskIntoConstraints = false
        locationView.addSubview(location2)
        
        location3.layer.cornerRadius = 20
        location3.layer.borderWidth = 2.0
        location3.backgroundColor = .white
        location3.setTitle("Outside Ithaca", for: .normal)
        location3.setTitleColor(.black, for: .normal)
        location3.addTarget(self, action: #selector(setLocation3), for: .touchUpInside)
        location3.translatesAutoresizingMaskIntoConstraints = false
        locationView.addSubview(location3)
        
        location4.layer.cornerRadius = 20
        location4.layer.borderWidth = 2.0
        location4.backgroundColor = .black
        location4.setTitle("Any", for: .normal)
        location4.setTitleColor(.white, for: .normal)
        location4.addTarget(self, action: #selector(setLocation4), for: .touchUpInside)
        location4.translatesAutoresizingMaskIntoConstraints = false
        locationView.addSubview(location4)
        
        timeLabel.text = "Starting Time"
        timeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        timeLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(timeLabel)
        
        let calendarImage = UIImage(systemName: "calendar")
        calendar.setImage(calendarImage, for: .normal)
        calendar.tintColor = .black
        calendar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendar)
        
        calendarField.layer.cornerRadius = 20
        calendarField.layer.borderWidth = 2.0
        calendarField.backgroundColor = .white
        calendarField.placeholder = "Mon/Year"
        calendarField.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: calendarField.frame.height))
        calendarField.leftView = paddingView
        calendarField.leftViewMode = .always
        calendarField.isEnabled = true
        view.addSubview(calendarField)
        
        sortLabel.text = "Sort By"
        sortLabel.font = UIFont.boldSystemFont(ofSize: 18)
        sortLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        sortLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sortLabel)
        
        locationView.backgroundColor = .white
        locationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(locationView)
        
        sort1.layer.cornerRadius = 20
        sort1.layer.borderWidth = 2.0
        sort1.backgroundColor = .white
        sort1.setTitle("Latest", for: .normal)
        sort1.setTitleColor(.black, for: .normal)
        sort1.addTarget(self, action: #selector(setSort1), for: .touchUpInside)
        sort1.translatesAutoresizingMaskIntoConstraints = false
        sortView.addSubview(sort1)
        
        sort2.layer.cornerRadius = 20
        sort2.layer.borderWidth = 2.0
        sort2.backgroundColor = .white
        sort2.setTitle("Start Date|Descending", for: .normal)
        sort2.setTitleColor(.black, for: .normal)
        sort2.addTarget(self, action: #selector(setSort2), for: .touchUpInside)
        sort2.translatesAutoresizingMaskIntoConstraints = false
        sortView.addSubview(sort2)
        
        sort3.layer.cornerRadius = 20
        sort3.layer.borderWidth = 2.0
        sort3.backgroundColor = .white
        sort3.setTitle("Starting Date|Ascending", for: .normal)
        sort3.setTitleColor(.black, for: .normal)
        sort3.addTarget(self, action: #selector(setSort3), for: .touchUpInside)
        sort3.translatesAutoresizingMaskIntoConstraints = false
        sortView.addSubview(sort3)
        
        
        sortView.backgroundColor = .white
        sortView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sortView)
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5),
            cancelButton.widthAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: cancelButton.bottomAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            resetButton.heightAnchor.constraint(equalToConstant: 50),
            resetButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            resetButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            petsLabel.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 15),
            petsLabel.heightAnchor.constraint(equalToConstant: 60),
            petsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 37.5),
            petsLabel.widthAnchor.constraint(equalToConstant: 170)
        ])
        
        NSLayoutConstraint.activate([
            petsVIew.topAnchor.constraint(equalTo: petsLabel.topAnchor, constant: 12),
            petsVIew.bottomAnchor.constraint(equalTo: petsLabel.bottomAnchor, constant: -12),
            petsVIew.leadingAnchor.constraint(equalTo: petsLabel.trailingAnchor, constant: -15),
            petsVIew.widthAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            onePet.topAnchor.constraint(equalTo: petsVIew.topAnchor),
            onePet.bottomAnchor.constraint(equalTo: petsVIew.bottomAnchor),
            onePet.leadingAnchor.constraint(equalTo: petsVIew.leadingAnchor),
            onePet.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            morePet.topAnchor.constraint(equalTo: petsVIew.topAnchor),
            morePet.bottomAnchor.constraint(equalTo: petsVIew.bottomAnchor),
            morePet.leadingAnchor.constraint(equalTo: onePet.trailingAnchor),
            morePet.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            anyPet.topAnchor.constraint(equalTo: petsVIew.topAnchor),
            anyPet.bottomAnchor.constraint(equalTo: petsVIew.bottomAnchor),
            anyPet.leadingAnchor.constraint(equalTo: morePet.trailingAnchor),
            anyPet.widthAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: anyPet.bottomAnchor, constant: 30),
            locationLabel.leadingAnchor.constraint(equalTo: petsLabel.leadingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            locationView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 10),
            locationView.heightAnchor.constraint(equalToConstant: 150),
            locationView.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            locationView.widthAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            location1.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 20),
            location1.heightAnchor.constraint(equalToConstant: 40),
            location1.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 5),
            location1.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            location2.topAnchor.constraint(equalTo: locationView.topAnchor, constant: 20),
            location2.heightAnchor.constraint(equalToConstant: 40),
            location2.leadingAnchor.constraint(equalTo: location1.trailingAnchor, constant: 10),
            location2.trailingAnchor.constraint(equalTo: locationView.trailingAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            location3.topAnchor.constraint(equalTo: location1.bottomAnchor, constant: 20),
            location3.heightAnchor.constraint(equalToConstant: 40),
            location3.leadingAnchor.constraint(equalTo: locationView.leadingAnchor, constant: 5),
            location3.trailingAnchor.constraint(equalTo: location3.leadingAnchor, constant:  160)
        ])
        
        NSLayoutConstraint.activate([
            location4.topAnchor.constraint(equalTo: location1.bottomAnchor, constant: 20),
            location4.heightAnchor.constraint(equalToConstant: 40),
            location4.leadingAnchor.constraint(equalTo: location3.trailingAnchor, constant: 30),
            location4.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: locationView.bottomAnchor, constant: 10),
            timeLabel.leadingAnchor.constraint(equalTo: petsLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: timeLabel.topAnchor, constant: 40),
            calendar.leadingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            calendar.heightAnchor.constraint(equalToConstant: 22),
            calendar.widthAnchor.constraint(equalToConstant: 33)
        ])
        
        NSLayoutConstraint.activate([
            calendarField.topAnchor.constraint(equalTo: calendar.topAnchor, constant: -10),
            calendarField.leadingAnchor.constraint(equalTo: calendar.trailingAnchor, constant: 10),
            calendarField.heightAnchor.constraint(equalToConstant: 40),
            calendarField.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            sortLabel.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 25),
            sortLabel.leadingAnchor.constraint(equalTo: petsLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            sortView.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 10),
            sortView.heightAnchor.constraint(equalToConstant: 150),
            sortView.leadingAnchor.constraint(equalTo: sortLabel.leadingAnchor),
            sortView.widthAnchor.constraint(equalToConstant: 320)
        ])
        
        NSLayoutConstraint.activate([
            sort1.topAnchor.constraint(equalTo: sortView.topAnchor, constant: 20),
            sort1.heightAnchor.constraint(equalToConstant: 40),
            sort1.leadingAnchor.constraint(equalTo: sortView.leadingAnchor, constant: 5),
            sort1.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            sort2.topAnchor.constraint(equalTo: sortView.topAnchor, constant: 20),
            sort2.heightAnchor.constraint(equalToConstant: 40),
            sort2.leadingAnchor.constraint(equalTo: sort1.trailingAnchor, constant: 10),
            sort2.trailingAnchor.constraint(equalTo: sortView.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            sort3.topAnchor.constraint(equalTo: sort1.bottomAnchor, constant: 20),
            sort3.heightAnchor.constraint(equalToConstant: 40),
            sort3.leadingAnchor.constraint(equalTo: sortView.leadingAnchor, constant: 5),
            sort3.trailingAnchor.constraint(equalTo: sort3.leadingAnchor, constant:  220)
        ])
    }
    
    @objc func dismissSearchView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func reset() {
        anyPetButton()
        setLocation4()
        removeSort()
    }
    
    @objc func onePetButton() {
        onePet.backgroundColor = .black
        onePet.setTitleColor(.white, for: .normal)
        morePet.backgroundColor = .white
        morePet.setTitleColor(.black, for: .normal)
        anyPet.backgroundColor = .white
        anyPet.setTitleColor(.black, for: .normal)
    }
    
    @objc func morePetButton() {
        morePet.backgroundColor = .black
        morePet.setTitleColor(.white, for: .normal)
        onePet.backgroundColor = .white
        onePet.setTitleColor(.black, for: .normal)
        anyPet.backgroundColor = .white
        anyPet.setTitleColor(.black, for: .normal)
    }
    
    @objc func anyPetButton() {
        anyPet.backgroundColor = .black
        anyPet.setTitleColor(.white, for: .normal)
        morePet.backgroundColor = .white
        morePet.setTitleColor(.black, for: .normal)
        onePet.backgroundColor = .white
        onePet.setTitleColor(.black, for: .normal)
    }
    
    @objc func setLocation1() {
        location1.setTitleColor(.white, for: .normal)
        location1.backgroundColor = .black
        location2.setTitleColor(.black, for: .normal)
        location2.backgroundColor = .white
        location3.setTitleColor(.black, for: .normal)
        location3.backgroundColor = .white
        location4.setTitleColor(.black, for: .normal)
        location4.backgroundColor = .white
    }
    
    @objc func setLocation2() {
        location1.setTitleColor(.black, for: .normal)
        location1.backgroundColor = .white
        location2.setTitleColor(.white, for: .normal)
        location2.backgroundColor = .black
        location3.setTitleColor(.black, for: .normal)
        location3.backgroundColor = .white
        location4.setTitleColor(.black, for: .normal)
        location4.backgroundColor = .white
    }
    
    @objc func setLocation3() {
        location1.setTitleColor(.black, for: .normal)
        location1.backgroundColor = .white
        location2.setTitleColor(.black, for: .normal)
        location2.backgroundColor = .white
        location3.setTitleColor(.white, for: .normal)
        location3.backgroundColor = .black
        location4.setTitleColor(.black, for: .normal)
        location4.backgroundColor = .white
    }
    
    @objc func setLocation4() {
        location1.setTitleColor(.black, for: .normal)
        location1.backgroundColor = .white
        location2.setTitleColor(.black, for: .normal)
        location2.backgroundColor = .white
        location3.setTitleColor(.black, for: .normal)
        location3.backgroundColor = .white
        location4.setTitleColor(.white, for: .normal)
        location4.backgroundColor = .black
    }
    
    @objc func setSort1() {
        sort1.setTitleColor(.white, for: .normal)
        sort1.backgroundColor = .black
        sort2.setTitleColor(.black, for: .normal)
        sort2.backgroundColor = .white
        sort3.setTitleColor(.black, for: .normal)
        sort3.backgroundColor = .white
    }
    
    @objc func setSort2() {
        sort1.setTitleColor(.black, for: .normal)
        sort1.backgroundColor = .white
        sort2.setTitleColor(.white, for: .normal)
        sort2.backgroundColor = .black
        sort3.setTitleColor(.black, for: .normal)
        sort3.backgroundColor = .white
    }
    
    @objc func setSort3() {
        sort1.setTitleColor(.black, for: .normal)
        sort1.backgroundColor = .white
        sort2.setTitleColor(.black, for: .normal)
        sort2.backgroundColor = .white
        sort3.setTitleColor(.white, for: .normal)
        sort3.backgroundColor = .black
    }
    
    @objc func removeSort() {
        sort1.setTitleColor(.black, for: .normal)
        sort1.backgroundColor = .white
        sort2.setTitleColor(.black, for: .normal)
        sort2.backgroundColor = .white
        sort3.setTitleColor(.black, for: .normal)
        sort3.backgroundColor = .white
    }
}
