//
//  ModelController.swift
//  pratice
//
//  Created by bori－applepc on 16/4/20.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class ModelController: NSObject {
    
    var numberOfPages: Int
    var pdf: CGPDFDocumentRef
    
    override init() {
        let pdfURL = NSBundle.mainBundle().URLForResource("input_pdf.pdf", withExtension: nil)
        pdf = CGPDFDocumentCreateWithURL(pdfURL)!
        numberOfPages = CGPDFDocumentGetNumberOfPages(pdf)
        if numberOfPages % 2 != 0 {
            numberOfPages++
            print("numberOfPages == \(numberOfPages)")
        }
    }
    
    func viewControllerAtIndex(index: Int) -> DataViewController {
        let dataViewController = DataViewController()
        //传递pdf和index，dataVC拿到PDF具体的某一页
        dataViewController.pdf = pdf
        dataViewController.pageNumber = index + 1
        return dataViewController
    }
    
    func indexForViewController(controller: DataViewController) -> Int {
        return controller.pageNumber! - 1;
    }
    
}


// MARK: - UIPageViewControllerDataSource

extension ModelController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        var index = self.indexForViewController(viewController as! DataViewController)
        if index == 0 || index == NSNotFound {
            return nil;
        }
        index--
        return self.viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        var index = self.indexForViewController(viewController as! DataViewController)
        if index == NSNotFound {
            return nil
        }
        index++
        if index == numberOfPages {
            return nil
        }
        return self.viewControllerAtIndex(index)
    }
}

