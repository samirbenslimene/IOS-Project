//
//  AddCourseView.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 25/11/2021.
//

import UIKit

class AddCourseView: UIViewController {

    // variables
    
    // iboutlets
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!

    
    // protocols
    
    
    // life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // methods
    func formControl(titleIsEmpty: Bool, descriptionIsEmpty: Bool) -> Bool {
        if (titleIsEmpty) {
            self.present(Alert.makeAlert(titre: "Notice", message: "Please type a title"), animated: true)
            return false
        }
        
        if (descriptionIsEmpty) {
            self.present(Alert.makeAlert(titre: "Notice", message: "Please type the course content"), animated: true)
            return false
        }
        
        return true
    }

    // actions
    @IBAction func saveCourse(_ sender: Any) {
        if (!formControl(titleIsEmpty: titleTF.text!.isEmpty, descriptionIsEmpty: descriptionTF.text!.isEmpty)){
            return
        }
        
        CourseViewModel().addCourse(title: titleTF.text!, description: descriptionTF.text!, date: Date()) { (success) in
            if success {
                let action = UIAlertAction(title: "Proceed", style: .default) { actionMade in
                    self.performSegue(withIdentifier: "coursesSegue", sender: nil)
                }
                self.present(Alert.makeSingleActionAlert(titre: "Success", message: "Your course has been added", action: action), animated: true)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Course could not be added"), animated: true)
            }
        }
    }
    
    @IBAction func discardCourse(_ sender: Any) {
        let action = UIAlertAction(title: "Discard", style: .destructive) { actionMade in
            self.performSegue(withIdentifier: "coursesSegue", sender: nil)
        }
        self.present(Alert.makeActionAlert(titre: "Warning", message: "Are you sure you want to discard this current course ?", action: action), animated: true)
    }
}
