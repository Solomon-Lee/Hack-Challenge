//
//  NetworkManager.swift
//  Housing and Pet
//
//  Created by Wei Zheng on 5/4/23.
//

import Foundation


class NetworkManager {
    
    static let shared = NetworkManager()
    
    var url = URL(string: "http://34.85.147.40/")
    var urlCreateUser = URL(string: "http://34.85.147.40/register/")
    var urlLogin = URL(string: "http://34.85.147.40/login/")
    var urlLogout = URL(string: "http://34.85.147.40/logout")
    var urlUpdateUser = URL(string: "http://34.85.147.40/user")
    var getUserbyToken = URL(string: "http://34.85.147.40/user")
    var userImgUrl = URL(string: "http://34.85.147.40/upload/user/")
    var petAdopterReqUrl = URL(string: "http://34.85.147.40/user/pet_adoption_request/")
    
    func petSitPost(token:String,name:String,age:String,gender:String,breed:String,category:String,on_campus:Bool,off_campus:Bool,outside:Bool,start_time:String,end_time:String,addtional_info:String,pet_description:String,food_supplies:String,adopter_reward:Bool,completion:@escaping(petAdopReq) -> Void){
        var request = URLRequest(url: petAdopterReqUrl!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let body: [String:Any] = [
                "name": name,
                "age": age,
                "gender": gender,
                "breed": breed,
                "category": category,
                "on_campus": on_campus,
                "off_campus": off_campus,
                "outside": outside,
                "start_time": start_time,
                "end_time": end_time,
                "additional_info": addtional_info,
                "pet_description":  pet_description,
                "food_supplies": food_supplies,
                "adopter_reward": adopter_reward
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
        let sitReq = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(petAdopReq.self, from: data)
                    print("pet req good")
                    completion(response)
                }
                catch (let error){
                    print(error)
                    print(error.localizedDescription)
                }
            }
        }
        sitReq.resume()
        
    }
    
        func createUserImage(token:String,image_data:String,compeltion:@escaping(assett) -> Void){
            var request = URLRequest(url: userImgUrl!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            let body: [String:String] = [
                "image_data": image_data
            ]
    
            request.httpBody = try? JSONSerialization.data(withJSONObject: body,options: .fragmentsAllowed)
            let asset = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data{
                    do{
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(assett.self, from: data)
                        print("good upload")
                        compeltion(response)
                    }
                    catch (let error){
                        print(error)
                        print(error.localizedDescription)
                    }
                }
            }
            asset.resume()
    
        }
    
    func updateUserbyToken(token:String,image_data:String?, gender:String?, age:String?, college_student:Bool?,curr_location:String?,pet_owner_boolean:Bool?,phone:String?,completion:@escaping(AppUser) -> Void){
        var request = URLRequest(url: urlUpdateUser!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        var body: [String:Any] = [:]
        if let phone = phone{
            body["phone"] = phone
        }
        if let gender = gender{
            body["gender"] = gender
        }
        if let age = age{
            body["age"] = age
        }
        if let curr_location = curr_location{
            body["curr_location"] = curr_location
        }
        if let college_student = college_student{
            body["college_student"] = college_student
        }
        if let pet_owner_boolean = pet_owner_boolean{
            body["pet_owner_boolean"] = pet_owner_boolean
        }
        if let image_data = image_data{
            body["image_data"] = image_data
        }
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let user = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AppUser.self, from: data)
                    print("HAPPY")
                    completion(response)
                }
                catch (let error){
                    print(error)
                }
                
            }
        }
        user.resume()
        
    }
    
    func getUserbyToken(token:String, completion:@escaping(AppUser) -> Void){
        var request = URLRequest(url: getUserbyToken!)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let user = URLSession.shared.dataTask(with: request) { data,response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(AppUser.self, from: data)
                    DispatchQueue.main.async {
                        print("PPPPPPPPPPPPPPP")
                        completion(response)
                    }
                }
                catch(let error){
                    print(error.localizedDescription)
                }
            }
        }
        user.resume()
        
    }
    
    func createUser(email:String ,password:String, username:String, phone:String, completion:@escaping(userResponse) -> Void){
        print("Creating")
        var request = URLRequest(url: urlCreateUser!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String:String] = [
            "email": email,
            "password": password,
            "username": username,
            "phone": phone
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let user = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(userResponse.self, from: data)
                    completion(response)
                }
                catch (let error){
                    print(error.localizedDescription)
                }
            }
        }
        user.resume()
    }
    
    func loginUser(email:String ,password:String, completion:@escaping(userResponse) -> Void){
        var request = URLRequest(url: urlLogin!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String:String] = [
            "email": email,
            "password": password
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let user = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(userResponse.self, from: data)
                    UserDefaults.standard.set(response.session_token, forKey: "SessionToken")
                    completion(response)
                }
                catch (let error){
                    print(error)
                }
            }
        }
        user.resume()
    }
    
    func logOutUser(token:String, completion:@escaping (logoutMessage) -> Void){
        var request = URLRequest(url: urlLogout!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let user = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data{
                do{
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(logoutMessage.self, from: data)
                    print(response.message)
                    completion(response)
                }
                catch (let error){
                    print(error)
                }
            }
        }
        user.resume()
    }
    
}
