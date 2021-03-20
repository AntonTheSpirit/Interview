//
//  ViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1410--2020.
//

import UIKit
// import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var Start: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
/*    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.presentPageVC()
        })
    }
 */
    @IBAction func startInterview(sender: UIButton) {
//        if let vc = storyboard?.instantiateViewController(identifier: "IntroVC") {
//            vc.modalPresentationStyle = .fullScreen
//            present(vc, animated: true)
//         }
        if let vc = storyboard?.instantiateViewController(identifier: "QuestionVC") {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
}
