//
//  Details.swift
//  Feedback
//
//  Created by Jatin Kamal Vangani on 18/01/24.
//

import Foundation

class Details{
    var userName:String?
    var phoneNumber:String?
    var email:String?
    var review:String?
    
    init(userName: String? = nil, phoneNumber: String? = nil, email: String? = nil, review: String? = nil) {
        self.userName = userName?.isEmpty == true ?nil:userName
        self.phoneNumber = isValidNumber(phoneNumber) ?phoneNumber:nil
        self.email = isValidEmail(email) ?email:nil
        self.review = review?.isEmpty==true ?nil:review
    }
    
    private func isValidEmail(_ email:String?)->Bool{
        guard let email = email else{return false}
        
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Za-z0-9._%+-]+@practo+\\.[A-Za-z]{2,}")
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidNumber(_ phoneNumber:String?)->Bool{
        guard let phoneNumber = phoneNumber else{return false}
        
        let numberPredicate = NSPredicate(format: "SELF MATCHES %@", "[0-9]{10}")
        return numberPredicate.evaluate(with: phoneNumber)
    }
    
}
