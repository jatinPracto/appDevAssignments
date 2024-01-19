//
//  ViewController.swift
//  Feedback
//
//  Created by Jatin Kamal Vangani on 17/01/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var reviewField: UITextField!
    
    var detailsObj: Details?
    
    @IBAction func Submit(_ sender: Any) {
        
        detailsObj = Details(userName: userNameField.text,phoneNumber: phoneField.text,email: emailField.text,review: reviewField.text) //Model
        
        performSegue(withIdentifier : "ShowDetails",sender:self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }
    
    @IBAction func exitButton(_ sender: Any) {
        exit(0)
    }
    
    override func prepare(for segue: UIStoryboardSegue,sender:Any?){
        if segue.identifier == "ShowDetails" {
            if let displayDetailController = segue.destination as? DisplayDetailController{
                displayDetailController.feedbackRecieved = detailsObj
            }
        }
    }

}

