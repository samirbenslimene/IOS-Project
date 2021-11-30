//
//  CourseDetailsView.swift
//  iProceed
//
//  Created by Mac-Mini_2021 on 25/11/2021.
//

import UIKit

class CourseDetailsView: UIViewController {

    // variables
    var course: Course?
    
    // iboutlets
    @IBOutlet weak var descriptionTextView: UITextView!
    
    // life cycle
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "courseDetailSegue" {
            let destination = segue.destination as! CourseDetailsView
            destination.course = course
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = course?.title
        descriptionTextView.text = course?.description
    }
    
    // actions
    @IBAction func editCourse(_ sender: Any) {
        self.performSegue(withIdentifier: "editCourseSegue", sender: nil)
    }
}
