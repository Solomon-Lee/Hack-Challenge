//
//  SceneDelegate.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 4/29/23.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        self.setupWindow(with: scene)
        self.checkAuthentication()
        
    }
    private func setupWindow(with scene: UIScene){
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
    
    public func checkAuthentication(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async { [ weak self] in
                UIView.animate(withDuration: 0.25){
                    self?.window?.layer.opacity = 0.25
                }completion: { [weak self] _ in
                    let nav = UINavigationController(rootViewController: WelcomeViewController())
                    nav.modalPresentationStyle = .fullScreen
                    self?.window?.rootViewController = nav
                    UIView.animate(withDuration: 0.25) { [weak self] in
                        self?.window?.layer.opacity = 1
                    }
                    
                }
            }
        }else{
            
            //setting up tabs
            let tabBarVC = UITabBarController()
            let homeView = UINavigationController(rootViewController: HomeViewController())
            let savedView = UINavigationController(rootViewController: SavedViewController())
            let postView = UINavigationController(rootViewController: PostViewController())
            let mailView = UINavigationController(rootViewController: MailViewController())
            let profileView = UINavigationController(rootViewController: ProfileViewController())
            
            //setting up the tab bars
            tabBarVC.delegate = ProfileViewController()
            tabBarVC.setViewControllers([homeView,savedView,postView,mailView,profileView], animated: false)
            tabBarVC.tabBar.layer.borderWidth = 4
            tabBarVC.tabBar.layer.borderColor = UIColor(red: 0.12, green: 0.12, blue: 0.13, alpha: 1).cgColor
            tabBarVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            tabBarVC.title = nil
            tabBarVC.tabBar.backgroundColor = .black
            tabBarVC.selectedIndex = 0
            tabBarVC.tabBar.unselectedItemTintColor = .black
            tabBarVC.tabBar.backgroundColor = .white
        
            
            guard let items = tabBarVC.tabBar.items else{
                return
            }
            items[3].badgeValue = "1"
            let images = ["Search","Bookmark","add","mail","profile" ]
            let selectedImages = ["SSearch", "SBookmark", "add", "Smail","Sprofile"]
            for x in 0..<items.count{
                items[x].image = UIImage(named: images[x])
                items[x].selectedImage = UIImage(named: selectedImages[x])?.withRenderingMode(.alwaysOriginal)
                items[x].imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -6, right: 0)
                items[x].title = nil
                
            }
            
            DispatchQueue.main.async { [ weak self] in
                UIView.animate(withDuration: 0.25){
                    self?.window?.layer.opacity = 0
                }completion: { [weak self] _ in
                    tabBarVC.modalPresentationStyle = .fullScreen
                    
                    self?.window?.rootViewController = tabBarVC
                    UIView.animate(withDuration: 0.25) { [weak self] in
                        self?.window?.layer.opacity = 1
                    }
                    
                }
            }
            
        }
    }
}
extension SceneDelegate: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("ABC")
    }

}
