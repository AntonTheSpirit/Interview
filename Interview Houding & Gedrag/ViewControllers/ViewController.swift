//
//  ViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Anton Verver on 1410--2020.
//

import UIKit
// import FirebaseDatabase

class ViewController: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    @IBOutlet weak var Start: UIButton!
    var myControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = storyboard?.instantiateViewController(identifier: "vragenVC") as! InterviewViewController //UIViewController()
        vc.modalPresentationStyle = .fullScreen
        //vc.view.backgroundColor = .red
        myControllers.append(vc)
        addChild(vc)
              view.addSubview(vc.view)
    }
    
/*    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
            self.presentPageVC()
        })
    }
 */
    @IBAction func startInterview(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "vragenVC") as! InterviewViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func presentPageVC() {
        guard let first = myControllers.first else {
            return
        }
        
        let vc = UIPageViewController(transitionStyle: .scroll,
                                      navigationOrientation: .horizontal,
                                      options: nil)
        vc.delegate = self
        vc.dataSource = self
        vc.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        
        present(vc, animated: true)
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1
            return myControllers[before]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else {
            return nil
        }
        let after = index + 1
            return myControllers[after]
    }
    
}
