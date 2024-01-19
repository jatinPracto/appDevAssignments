//
//  DisplayDetailController.swift
//  Feedback
//
//  Created by Jatin Kamal Vangani on 17/01/24.
//

import Foundation
import UIKit

class DisplayDetailController: UIViewController {


    @IBOutlet weak var nameLabel: UITextField!

    @IBOutlet weak var emailLabel: UITextField!
    
    
    @IBOutlet weak var phoneLabel: UITextField!
    
    
    @IBOutlet weak var reviewLabel: UITextField!
    
    var feedbackRecieved:Details?
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true,completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameLabel.text=feedbackRecieved?.userName
        emailLabel.text=feedbackRecieved?.email
        phoneLabel.text=feedbackRecieved?.phoneNumber
        reviewLabel.text=feedbackRecieved?.review
    }
}
