//
//  ProfileViewController.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit

class ProfileViewController: UIViewController{
    
    let passwordSetupPageCircle = UIView()
    let profilePagePic = UIImageView()
    let profileLabel = UILabel()
    let editProfile = UIButton()
    let signOutButton = UIButton()
    let profilePicTemp = UIImageView()
    let PersonalBackgroundView = UIView()
    static let username = UILabel()
    static let email = UILabel()
    static let useruid = UILabel()
    let personalInfoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 282, height: 28))
    let notificationButton = UIButton(frame: CGRect(x: 0, y: 0, width: 282, height: 28))
    let loginAndSecButton = UIButton(frame: CGRect(x: 0, y: 0, width: 282, height: 28))
    let privacyButton = UIButton(frame: CGRect(x: 0, y: 0, width: 282, height: 28))
    let getHelpButton = UIButton(frame: CGRect(x: 0, y: 0, width: 282, height: 28))
    let rightArrow = UIImageView()
    static var backEndToken: String = "No token Yet"
    var mainProfilePic: String = ""
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        NetworkManager.shared.getUserbyToken(token: ProfileViewController.backEndToken) { Appuser in
            self.mainProfilePic = Appuser.asset?.base_url ?? "http://default_profile"
            print(self.mainProfilePic)
            guard let url = URL(string: self.mainProfilePic) else{
                print("Invalid URL")
                self.profilePicTemp.image = UIImage(named: "default_profile")
                return
            }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else{
                    print("Error downloadng image")
                    DispatchQueue.main.async {
                        self.profilePicTemp.image = UIImage(named: "default_profile")
                        
                    }
                    return
                }
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.profilePicTemp.image  = image
                }
            }
            task.resume()
        }
        
    }
    
    let testLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        self.tabBarController?.delegate = self
        //settign up the signout button
        signOutButton.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        signOutButton.setTitle("Log out", for: .normal)
        signOutButton.titleLabel?.font = UIFont(name: "Ubuntu-Medium", size: 18)
        signOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
        signOutButton.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(signOutButton, at: 2)
        
        //testLabel
        testLabel.text = ProfileViewController.backEndToken
        testLabel.textColor = .black
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(testLabel, at: 2)
        
        //profilePagePic
        profilePagePic.image = UIImage(named: "profilePagePic")
        profilePagePic.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(profilePagePic, at: 1)
        
        //profileLabel
        profileLabel.text = "Profile"
        profileLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        profileLabel.font = UIFont(name: "Ubuntu-Medium", size: 40)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(profileLabel, at: 2)
        
        //set up the profile pic
//        profilePicTemp.image = UIImage(named: "default_profile")
        profilePicTemp.clipsToBounds = true
        profilePicTemp.layer.cornerRadius = 73/2
        profilePicTemp.layer.borderWidth = 2
        profilePicTemp.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        profilePicTemp.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(profilePicTemp, at: 1)
        
        //personal info button
        var personalInfoConf = UIButton.Configuration.plain()
        var personalInfoContainer = AttributeContainer()
        personalInfoContainer.font = UIFont(name: "Ubuntu-Regular", size: 14)
        personalInfoConf.attributedTitle = AttributedString("Personal Information", attributes: personalInfoContainer)
        personalInfoConf.image = UIImage(named: "arrowRight")
        personalInfoConf.imagePlacement = .trailing
        personalInfoConf.imagePadding = 123
        personalInfoConf.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        personalInfoConf.attributedTitle?.font = UIFont(name: "Ubuntu-regular", size: 14)
        personalInfoConf.attributedTitle?.foregroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        
        personalInfoButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = true
        personalInfoButton.setTitleColor(UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0), for: .normal)
        personalInfoButton.configuration = personalInfoConf
        personalInfoButton.translatesAutoresizingMaskIntoConstraints = false
        personalInfoButton.addTarget(self, action: #selector(personalInfoPush), for: .touchUpInside)
        view.insertSubview(personalInfoButton, at: 1)
        
        //get help button
        var getHelpConf = UIButton.Configuration.plain()
        var getHelpContainer = AttributeContainer()
        getHelpContainer.font = UIFont(name: "Ubuntu-Regular", size: 14)
        getHelpConf.attributedTitle = AttributedString("Get help", attributes: getHelpContainer)
        getHelpConf.image = UIImage(named: "arrowRight")
        getHelpConf.imagePlacement = .trailing
        getHelpConf.imagePadding = 202
        getHelpConf.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        getHelpConf.attributedTitle?.font = UIFont(name: "Ubuntu-regular", size: 14)
        getHelpConf.attributedTitle?.foregroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        
        getHelpButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        getHelpButton.translatesAutoresizingMaskIntoConstraints = true
        getHelpButton.setTitleColor(UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0), for: .normal)
        getHelpButton.configuration = getHelpConf
        getHelpButton.translatesAutoresizingMaskIntoConstraints = false
        getHelpButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.insertSubview(getHelpButton, at: 1)

        
        //privacy button
        var privConf = UIButton.Configuration.plain()
        var privContainer = AttributeContainer()
        privContainer.font = UIFont(name: "Ubuntu-Regular", size: 14)
        privConf.attributedTitle = AttributedString("Privacy and Sharing", attributes: privContainer)
        privConf.image = UIImage(named: "arrowRight")
        privConf.imagePlacement = .trailing
        privConf.imagePadding = 133
        privConf.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        privConf.attributedTitle?.font = UIFont(name: "Ubuntu-regular", size: 14)
        privConf.attributedTitle?.foregroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        
        privacyButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        privacyButton.translatesAutoresizingMaskIntoConstraints = true
        privacyButton.setTitleColor(UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0), for: .normal)
        privacyButton.configuration = privConf
        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.insertSubview(privacyButton, at: 1)
        
        //login and security button
        var loginSecConf = UIButton.Configuration.plain()
        var loginSecContainer = AttributeContainer()
        loginSecContainer.font = UIFont(name: "Ubuntu-Regular", size: 14)
        loginSecConf.attributedTitle = AttributedString("Login and Security", attributes: loginSecContainer)
        loginSecConf.image = UIImage(named: "arrowRight")
        loginSecConf.imagePlacement = .trailing
        loginSecConf.imagePadding = 140
        loginSecConf.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        loginSecConf.attributedTitle?.font = UIFont(name: "Ubuntu-regular", size: 14)
        loginSecConf.attributedTitle?.foregroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        
        loginAndSecButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        loginAndSecButton.translatesAutoresizingMaskIntoConstraints = true
        loginAndSecButton.setTitleColor(UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0), for: .normal)
        loginAndSecButton.configuration = loginSecConf
        loginAndSecButton.translatesAutoresizingMaskIntoConstraints = false
        loginAndSecButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.insertSubview(loginAndSecButton, at: 1)
        
        
        //notification button
        var notificationConf = UIButton.Configuration.plain()
        var notificationContainer = AttributeContainer()
        notificationContainer.font = UIFont(name: "Ubuntu-Regular", size: 14)
        notificationConf.attributedTitle = AttributedString("Notifications", attributes: notificationContainer)
        notificationConf.image = UIImage(named: "arrowRight")
        notificationConf.imagePlacement = .trailing
        notificationConf.imagePadding = 175
        notificationConf.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        notificationConf.attributedTitle?.font = UIFont(name: "Ubuntu-regular", size: 14)
        notificationConf.attributedTitle?.foregroundColor = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1)
        
        notificationButton.setImage(UIImage(named: "arrowRight"), for: .normal)
        notificationButton.translatesAutoresizingMaskIntoConstraints = true
        notificationButton.setTitleColor(UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0), for: .normal)
        notificationButton.configuration = notificationConf
        notificationButton.translatesAutoresizingMaskIntoConstraints = false
        notificationButton.addTarget(self, action: #selector(test), for: .touchUpInside)
        view.insertSubview(notificationButton, at: 1)
        
        //sign up circle
        passwordSetupPageCircle.clipsToBounds = true
        passwordSetupPageCircle.layer.cornerRadius = 380/2
        passwordSetupPageCircle.translatesAutoresizingMaskIntoConstraints = false
        passwordSetupPageCircle.backgroundColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1)
        view.insertSubview(passwordSetupPageCircle, at: 0)
        
        //personal Background View
        PersonalBackgroundView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        PersonalBackgroundView.clipsToBounds = true
        PersonalBackgroundView.layer.cornerRadius = 30
        PersonalBackgroundView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        PersonalBackgroundView.layer.borderWidth = 3
        PersonalBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(PersonalBackgroundView, at: 0)
        
        //setting up the user name
        ProfileViewController.username.textColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1.0)
        ProfileViewController.username.font = UIFont(name: "Ubuntu-Medium", size: 25)
        ProfileViewController.username.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(ProfileViewController.username, at: 1)
        
        //setting up the uid
//        ProfileViewController.useruid.textColor = .black
//        ProfileViewController.useruid.font = .systemFont(ofSize: 10)
//        ProfileViewController.useruid.translatesAutoresizingMaskIntoConstraints = false
//        view.insertSubview(ProfileViewController.useruid, at: 2)
        
        //setting up the user email
        ProfileViewController.email.textColor = .black
        ProfileViewController.email.font = .systemFont(ofSize: 20,weight: .bold)
        ProfileViewController.email.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(ProfileViewController.email, at: 2)
        
        AuthService.shared.fetchUser { [weak self] user, error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showFetchingUserError(on: self, with: error)
                return
            }
            
            if let user = user {
                ProfileViewController.email.text = user.email
                ProfileViewController.username.text = "\(user.username)"
                ProfileViewController.useruid.text = user.userUID
            }
            
        }
        
        editProfile.setTitle("Edit Profile", for: .normal)
        editProfile.setTitleColor(.white, for: .normal)
        editProfile.titleLabel?.font = UIFont(name: "Ubuntu-Regular", size: 14)
        editProfile.translatesAutoresizingMaskIntoConstraints = false
        editProfile.backgroundColor = .black
        editProfile.clipsToBounds = true
        editProfile.layer.cornerRadius = 15
        editProfile.addTarget(self, action: #selector(editProfilePage), for: .touchUpInside)
        view.insertSubview(editProfile, at: 0)
        
        
        setUpCons()
    }
    
    @objc private func test(){
        print("abc")
    }
    
    @objc private func personalInfoPush(){
        navigationController?.pushViewController(ViewProfileViewController(), animated: true)
    }
    
    private func setUpCons(){
        NSLayoutConstraint.activate([
            
            //testLabel
            testLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            testLabel.topAnchor.constraint(equalTo: profileLabel.topAnchor,constant: -20),
            
            //set up email conf circle
            passwordSetupPageCircle.topAnchor.constraint(equalTo: view.topAnchor,constant: -122),
            passwordSetupPageCircle.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 65),
            passwordSetupPageCircle.widthAnchor.constraint(equalToConstant: 380),
            passwordSetupPageCircle.heightAnchor.constraint(equalToConstant: 380),
            
            //prpfilePage Pic
            profilePagePic.topAnchor.constraint(equalTo: passwordSetupPageCircle.topAnchor,constant: 230),
            profilePagePic.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 61),
            profilePagePic.widthAnchor.constraint(equalToConstant: 210),
            profilePagePic.heightAnchor.constraint(equalToConstant: 253.88),
            
            //profilePic
            profilePicTemp.widthAnchor.constraint(equalToConstant: 73),
            profilePicTemp.heightAnchor.constraint(equalToConstant: 73),
            profilePicTemp.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -53),
            profilePicTemp.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,constant: 38),
            
            //Profile Label
            profileLabel.leadingAnchor.constraint(equalTo: profilePagePic.leadingAnchor),
            profileLabel.topAnchor.constraint(equalTo: profilePagePic.topAnchor,constant: 211),
            
            //personal background view
            PersonalBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            PersonalBackgroundView.widthAnchor.constraint(equalToConstant: 348),
            PersonalBackgroundView.heightAnchor.constraint(equalToConstant: 222.4),
            PersonalBackgroundView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,constant: 131),
            //perosnal info
            personalInfoButton.widthAnchor.constraint(equalToConstant: 282),
            personalInfoButton.heightAnchor.constraint(equalToConstant: 28),
            personalInfoButton.leadingAnchor.constraint(equalTo: PersonalBackgroundView.leadingAnchor,constant: 38),
            personalInfoButton.topAnchor.constraint(equalTo: PersonalBackgroundView.topAnchor,constant: 22),
            
            //notification info
            notificationButton.widthAnchor.constraint(equalToConstant: 282),
            notificationButton.heightAnchor.constraint(equalToConstant: 28),
            notificationButton.leadingAnchor.constraint(equalTo: PersonalBackgroundView.leadingAnchor,constant: 38),
            notificationButton.topAnchor.constraint(equalTo: personalInfoButton.bottomAnchor,constant: 9),
            
            //login and security Info
            loginAndSecButton.widthAnchor.constraint(equalToConstant: 282),
            loginAndSecButton.heightAnchor.constraint(equalToConstant: 28),
            loginAndSecButton.leadingAnchor.constraint(equalTo: PersonalBackgroundView.leadingAnchor,constant: 38),
            loginAndSecButton.topAnchor.constraint(equalTo: notificationButton.bottomAnchor,constant: 9),
            
            //privacy Info
            privacyButton.widthAnchor.constraint(equalToConstant: 282),
            privacyButton.heightAnchor.constraint(equalToConstant: 28),
            privacyButton.leadingAnchor.constraint(equalTo: PersonalBackgroundView.leadingAnchor,constant: 38),
            privacyButton.topAnchor.constraint(equalTo: loginAndSecButton.bottomAnchor,constant: 9),
            
            //privacy Info
            getHelpButton.widthAnchor.constraint(equalToConstant: 282),
            getHelpButton.heightAnchor.constraint(equalToConstant: 28),
            getHelpButton.leadingAnchor.constraint(equalTo: PersonalBackgroundView.leadingAnchor,constant: 38),
            getHelpButton.topAnchor.constraint(equalTo: privacyButton.bottomAnchor,constant: 9),
            
            
            //setting up the logout button
            signOutButton.leadingAnchor.constraint(equalTo: profileLabel.leadingAnchor),
            signOutButton.widthAnchor.constraint(equalToConstant: 65),
            signOutButton.heightAnchor.constraint(equalToConstant: 21),
            signOutButton.topAnchor.constraint(equalTo: PersonalBackgroundView.bottomAnchor,constant: 20),
            
            //username
            ProfileViewController.username.topAnchor.constraint(equalTo: profileLabel.bottomAnchor,constant: 38),
            ProfileViewController.username.centerXAnchor.constraint(equalTo: editProfile.centerXAnchor),
            
            //userUid
//            ProfileViewController.useruid.topAnchor.constraint(equalTo: ProfileViewController.email.topAnchor,constant: 30),
//            ProfileViewController.useruid.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //email
            ProfileViewController.email.topAnchor.constraint(equalTo: signOutButton.bottomAnchor,constant: 30),
            ProfileViewController.email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //edit profile
            editProfile.topAnchor.constraint(equalTo: ProfileViewController.username.bottomAnchor,constant: 12),
            editProfile.widthAnchor.constraint(equalToConstant: 112.23),
            editProfile.heightAnchor.constraint(equalToConstant: 29),
            editProfile.leadingAnchor.constraint(equalTo: profileLabel.leadingAnchor),
        ])
    }
    
    @objc private func editProfilePage(){
        navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    @objc private func logOut(){
        
//        NetworkManager.shared.logOutUser(token: ProfileViewController.backEndToken) { logoutMessage in
//            print("Good")
            AuthService.shared.signOut { [weak self] error in
                guard let self = self else {return}
                if let error = error{
                    AlertManager.showLogoutErrorAlert(on: self, with: error)
                    return
                }
                
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate{
                    sceneDelegate.checkAuthentication()
                }
            }
//        }
        
    }
}

extension ProfileViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        print(tabBarIndex)
        if tabBarIndex == 4{
            if let tabBarItem5 = self.tabBarController?.tabBar.items![4]{
                tabBarItem5.image = UIImage(named: "profile")
            }
        }
    }
}
