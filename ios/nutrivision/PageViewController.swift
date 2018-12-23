////
////  PageViewController.swift
////  Nutrivision
////
////  Created by Priyank Varshney on 12/22/18.
////  Copyright © 2018 Priyank Varshney. All rights reserved.
////
//
//import UIKit
//
//class PageViewController: UIPageViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        dataSource = self
//    }
//    
//    
//    private func newColoredViewController(color: String) -> UIViewController {
//        return UIStoryboard(name: "Main", bundle: nil) .
//            instantiateViewController(withIdentifier: "\(color)ViewController")
//    }
//    
//    var a: UIViewController = self.newColoredViewController(color: "1")
//    var orderedViewControllers: [UIViewController] = [a, newColoredViewController("2")]
//    
//}
//    
//extension PageViewController: UIPageViewControllerDataSource {
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        return nil
//    }
//}
