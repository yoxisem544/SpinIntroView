//
//  TestViewViewController.swift
//  ScrollViewWorkout
//
//  Created by David on 2015/12/14.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class TestViewViewController: UIViewController {

    var topScrollView: UIScrollView?
    var spinV: SpinView?
    
    func setupTopScrollView() {
        topScrollView = UIScrollView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        topScrollView?.contentSize = CGSize(width: view.frame.width * 3, height: view.frame.height)
        topScrollView?.backgroundColor = UIColor.clearColor()
        view.addSubview(topScrollView!)
        topScrollView?.delegate = self
        topScrollView?.pagingEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setupSpinContentView()
        spinV = SpinView(radius: self.view.bounds.size.height, imagePaths: ["11.png","22.png","33.png"])
        spinV?.moveBelowBottom(view.bounds.size.height / 2)
        spinV?.delegate = self
        for (index, v) : (Int, SpinContentView) in spinV!.contentViews!.enumerate() {
//            v.bounds.size.width *= (10+index*3).DoubleValue.CGFloatValue / 10.0
//            v.bounds.size.height *= (10+index*3).DoubleValue.CGFloatValue / 10.0
        }
        view.addSubview(spinV!)
        setupTopScrollView()
        view.backgroundColor = UIColor(red:0.973,  green:0.588,  blue:0.502, alpha:1)
//        attachImagesToSpinContentView(spinContentView!, imagePaths: ["2.png","3.png","1.png","1.png","1.png","1.png"])
        print(UIScreen.mainScreen().bounds)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI(offset: CGFloat) {
        let percent = offset / topScrollView!.contentSize.width
        spinV?.rotatePercentage = percent.DoubleValue
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TestViewViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateUI(scrollView.contentOffset.x)
    }
}

extension TestViewViewController : SpinViewDelegate {
    func enterLastPage() {
        print("enterLastPage")
    }
}
