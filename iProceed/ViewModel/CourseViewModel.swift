//
//  CourseViewModel.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class CourseViewModel {
    
    func getCourses(completed: @escaping (Bool, [Course]?) -> Void) {
        AF.request(Constants.serverUrl + "/course",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    debugPrint(jsonData)
                    
                    var courses : [Course]? = []
                    debugPrint(jsonData["course"])
                    for singleJsonItem in jsonData["course"] {
                        courses!.append(self.makeCourse(jsonItem: singleJsonItem.1))
                    }
                    completed(true, courses)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func getCourseById(_id: String, completed: @escaping (Bool, Course?) -> Void) {
        AF.request(Constants.serverUrl + "/course",
                   method: .get,
                   parameters: ["_id" : _id])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    debugPrint(jsonData)
                    let course = self.makeCourse(jsonItem: jsonData["course"])
                    completed(true,course)
                case let .failure(error):
                    print(error)
                    completed(false, nil)
                }
            }
    }
    
    func addCourse(title: String, description: String, date: Date, completed: @escaping (Bool) -> Void) {
        AF.request(Constants.serverUrl + "/course",
                   method: .post,
                   parameters: [
                    "title" : title,
                    "description" : description,
                    "date" : date,
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func editCourse(_id: String, title: String, description: String, date: Date, completed: @escaping (Bool) -> Void) {
        AF.request(Constants.serverUrl + "/course",
                   method: .put,
                   parameters: [
                    "_id" : _id,
                    "title" : title,
                    "description" : description,
                    "date" : date,
                   ])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func deleteCourse(_id: String, completed: @escaping (Bool) -> Void) {
        AF.request(Constants.serverUrl + "/course",
                   method: .delete,
                   parameters: ["_id" : _id])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    
    func makeCourse(jsonItem: JSON) -> Course {
        Course(
            _id: jsonItem["_id"].stringValue,
            title: jsonItem["title"].stringValue,
            description: jsonItem["description"].stringValue,
            date: Date()
        )
    }
}
