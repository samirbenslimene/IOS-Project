//
//  EditCourseView.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 28/11/2021.
//

import Foundation
import UIKit

class EditCourseView: UIViewController {

    // iboutlet
    var course : Course?
    @IBOutlet weak var titreTextView: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titreTextView.text = course?.title
        descriptionTextView.text = course?.description
    }
    
    // actions
    @IBAction func save(_ sender: Any) {
        CourseViewModel().editCourse(_id: (course?._id)!, title: (course?.title)!, description: (course?.description)!, date: (course?.date)!) { success in
            if success {
                let action = UIAlertAction(title: "Proceed", style: .default) { UIAlertAction in
                    self.dismiss(animated: true, completion: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Course edited successfully", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not edit course"), animated: true)
            }
        }
    }
    
    @IBAction func discard(_ sender: Any) {
        let action = UIAlertAction(title: "Discard", style: .destructive) { UIAlertAction in
            self.dismiss(animated: true, completion: nil)
        }
        self.present(Alert.makeActionAlert(titre: "Warning", message: "Would you like to discard the changes", action: action),animated: true)
    }
}
