//
//  DataRetrieval.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1011--2020.
//

import Foundation
import FirebaseDatabase

protocol MyDataSendingDelegateProtocol: AnyObject {
    func sendDataToFirstViewController(vragenLijst: [Vragen])
}

class FirebaseService {
    var vragenLijst = [Vragen]()
    weak var delegate: MyDataSendingDelegateProtocol?
    func ophalenVragenLijst() {
        
        //    var database: DatabaseReference!
        
        let database = Database.database().reference().child("interviewTemplates/DNA_Interview").queryOrdered(byChild: "vragen")
        
        database.observe(.value, with: { (snapshot) in
            if snapshot.childrenCount > 0 {
                self.vragenLijst.removeAll()
                guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value!) else { return }
                let dnaInterview = try? JSONDecoder().decode(DNAInterview.self, from: data)
                let aantalVragen = dnaInterview?.vragen.count
                var teller: Int
                teller = 0
                
                repeat {
                    if let vraag = dnaInterview?.vragen[teller]
                    {
                        self.vragenLijst.append(vraag)
                        teller += 1
                    }
                } while teller < aantalVragen!
                
                if self.delegate != nil && self.vragenLijst.count != 0 {
                    let dataToBeSent = self.vragenLijst
                    self.delegate?.sendDataToFirstViewController(vragenLijst: dataToBeSent)
                }
            }
        })
    }
}
