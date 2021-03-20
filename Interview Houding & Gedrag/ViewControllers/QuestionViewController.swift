//
//  QuestionViewController.swift
//  Interview Houding & Gedrag
//
//  Created by Nguyen Xuan Tho on 20/03/2021.
//

import UIKit

class QuestionViewController: UIViewController {
    var service: FirebaseService = FirebaseService()
    var myControllers = [UIViewController]()
    var data: [Vragen] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let introVC = storyboard?.instantiateViewController(identifier: "IntroVC") as! IntroViewController
        myControllers = [introVC]
        for index in 1...20 {
            let vc = storyboard?.instantiateViewController(identifier: "QuestionDetailVC") as! QuestionDetailViewController
            myControllers.append(vc)
        }
        service.ophalenVragenLijst()
        service.delegate = self
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
        
        addChild(vc)
        vc.view.frame = view.frame
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}

extension QuestionViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1
        let question = data[before]
        let questionVC = myControllers[before] as! QuestionDetailViewController
        questionVC.question = question
        
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

extension QuestionViewController: UIPageViewControllerDelegate {
    
}

extension QuestionViewController: MyDataSendingDelegateProtocol {
    func sendDataToFirstViewController(vragenLijst: [Vragen]) {
        data = vragenLijst
        presentPageVC()
    }
}
