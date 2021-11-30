//
//  UserViewModel.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 10/11/2021.
//

import SwiftyJSON
import Alamofire
import UIKit.UIImage

class UserViewModel {
    
    func signUp(user: User, completed: @escaping (Bool) -> Void ) {
        print(user)
        AF.request(Constants.serverUrl + "/user/signUp",
                   method: .post,
                   parameters: [
                    "name": user.name!,
                    "email": user.email!,
                    "address": user.address!,
                    "password": user.password!,
                    "phone": user.phone!,
                    "role": user.role!
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func login(email: String, password: String, completed: @escaping (Bool, Any?) -> Void ) {
        AF.request(Constants.serverUrl + "/user/login",
                   method: .post,
                   parameters: ["email": email, "password": password],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeUser(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "userToken")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func getUserFromToken(userToken: String, completed: @escaping (Bool, User?) -> Void ) {
        print("Looking for user --------------------")
        AF.request(Constants.serverUrl + "/user/getUserFromToken",
                   method: .post,
                   parameters: ["userToken": userToken],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeUser(jsonItem: jsonData["user"])
                        print("Found user --------------------")
                        print(user)
                        print("-------------------------------")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func loginWithSocialApp(email: String, name: String, completed: @escaping (Bool, User?) -> Void ) {
        AF.request(Constants.serverUrl + "/user/loginWithSocialApp",
                   method: .post,
                   parameters: ["email": email, "name": name],
                   encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeUser(jsonItem: jsonData["user"])
                    
                    print("this is the new token value : " + jsonData["token"].stringValue)
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "userToken")
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func resendConfirmation(email: String, completed: @escaping (Bool) -> Void ) {
        AF.request(Constants.serverUrl + "/user/resendConfirmation",
                   method: .post,
                   parameters: ["email": email])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func forgotPassword(email: String, resetCode: String, completed: @escaping (Bool) -> Void ) {
        AF.request(Constants.serverUrl + "/user/forgotPassword",
                   method: .post,
                   parameters: ["email": email, "resetCode": resetCode])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editPassword(email: String?, newPassword: String?, completed: @escaping (Bool) -> Void ) {
        AF.request(Constants.serverUrl + "/user/editPassword",
                   method: .put,
                   parameters: [
                    "email": email!,
                    "newPassword": newPassword!
                   ])
            .response { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editProfile(user: User, completed: @escaping (Bool) -> Void ) {
        
        AF.request(Constants.serverUrl + "/user/editProfile",
                   method: .put,
                   parameters: [
                    "_id" : user._id!,
                    "name": user.name!,
                    "email": user.email!,
                    "address": user.address!,
                    //"password": user.password!,
                    "phone": user.phone!
                   ])
            .response { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeUser(jsonItem: JSON) -> User {
        User(
            _id: jsonItem["_id"].stringValue,
            name: jsonItem["name"].stringValue,
            email: jsonItem["email"].stringValue,
            address: jsonItem["address"].stringValue,
            password: jsonItem["password"].stringValue,
            phone: jsonItem["phone"].stringValue,
            role: jsonItem["role"].stringValue,
            isVerified: jsonItem["isVerified"].boolValue
        )
    }
}
