//
//  DataRetrieval.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1011--2020.
//

import Foundation
import FirebaseDatabase

protocol MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(vragenLijst: [Vragen])
}

var vragenLijst = [Vragen]()
var delegate: MyDataSendingDelegateProtocol? = nil
func ophalenVragenLijst() {
    
//    var database: DatabaseReference!

    let database = Database.database().reference().child("interviewTemplates/DNA_Interview").queryOrdered(byChild: "vragen")

    database.observe(.value, with: { (snapshot) in
        if snapshot.childrenCount > 0 {
            vragenLijst.removeAll()
            guard let data = try? JSONSerialization.data(withJSONObject: snapshot.value!) else { return }
            let dnaInterview = try? JSONDecoder().decode(DNAInterview.self, from: data)
            let aantalVragen = dnaInterview?.vragen.count
            var teller: Int
            teller = 0
            
            repeat {
                if let vraag = dnaInterview?.vragen[teller]
                {
                    vragenLijst.append(vraag)
                    teller += 1
                }
            } while teller < aantalVragen!
            
            if delegate != nil && vragenLijst.count != 0 {
                let dataToBeSent = vragenLijst
                delegate?.sendDataToFirstViewController(vragenLijst: dataToBeSent)
            }
        }
    })
}
