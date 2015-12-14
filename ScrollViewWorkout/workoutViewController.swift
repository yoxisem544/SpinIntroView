//
//  workoutViewController.swift
//  ScrollViewWorkout
//
//  Created by David on 2015/12/11.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class workoutViewController: UIViewController {
    
    var topScrollView: UIScrollView?
    var spinContentView: UIView?
    
    func setupTopScrollView() {
        topScrollView = UIScrollView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        topScrollView?.contentSize = CGSize(width: view.frame.width * 6, height: view.frame.height)
        topScrollView?.backgroundColor = UIColor.clearColor()
        view.addSubview(topScrollView!)
        topScrollView?.delegate = self
        topScrollView?.pagingEnabled = true
    }
    
    func setupSpinContentView() {
        spinContentView = UIView(frame: CGRectMake(0, 0, view.frame.height, view.frame.height))
        spinContentView?.center = CGPoint(x: view.center.x, y: view.frame.maxY)
        spinContentView?.clipsToBounds = true
        spinContentView?.backgroundColor = UIColor.yellowColor()
        spinContentView?.layer.cornerRadius = spinContentView!.bounds.size.height / 2
        view.addSubview(spinContentView!)
        let v = UIImageView(frame: CGRectMake(0,0,100,100))
        v.image = UIImage(named: "1.png")
        v.clipsToBounds = true
        v.center.x = spinContentView!.bounds.midX
//        spinContentView?.addSubview(v)
    }
    
    func attachImagesToSpinContentView(spinView: UIView, imagePaths: [String]) {
        var images: [UIImage] = [UIImage]()
        // get images
        for path in imagePaths {
            if let image = UIImage(named: path) {
                images.append(image)
            }
        }
        // attach it onto the view
        // calculate the center of the view
        let originOfSpinView = (x: spinView.bounds.width.DoubleValue / 2, y: spinView.bounds.height.DoubleValue / 2)
        // set start degree
        let startAngle = 90.0
        // radius
        let radiusOfSpinView = (spinView.bounds.height / 2).DoubleValue - 50
        // check the image counts
        for (index, image) : (Int, UIImage) in images.enumerate() {
            let degreesPerSpace = 360.0 / Double(images.count)
            let degreeOfImage = (index.DoubleValue * degreesPerSpace) - startAngle
            print(degreeOfImage)
            // calculate (x, y) with degree
            let x = cos(degreeOfImage.RadianValue) * radiusOfSpinView + originOfSpinView.x
            let y = sin(degreeOfImage.RadianValue) * radiusOfSpinView + originOfSpinView.y
            let positionOnSpinView = (x: x, y: y)
            print(positionOnSpinView)
            let imageView = UIImageView(frame: CGRectMake(0, 0, 100, 100))
            imageView.image = image
            
            // center the view
            imageView.center = CGPoint(x: positionOnSpinView.x, y: positionOnSpinView.y)
            // spin images on the view
            imageView.transform = CGAffineTransformMakeRotation((degreeOfImage + startAngle).RadianValue.CGFloatValue)
            
            spinView.addSubview(imageView)
        }
    }
    
    func addViewsToView(view: UIView, contents: [String]) {
        // w must equal to h
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupSpinContentView()
        setupTopScrollView()
        attachImagesToSpinContentView(spinContentView!, imagePaths: ["2.png","3.png","1.png","1.png","1.png","1.png"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func degreesToRadians(angle: Double) -> CGFloat {
        return (M_PI * angle / 180.0).CGFloatValue
    }
    
//    func offsetToDegreesOfView(view: UIView, offset: CGFloat) -> CGFloat {
//        let diameter = view.bounds.height
//        let radian = offset / diameter
//        return
//    }
    
    func offsetToRadiansOfView(view: UIView, offset: CGFloat) -> CGFloat {
        // problem tranfrom degree in to radian
        let diameter = view.bounds.height
        let factor = (self.view.bounds.height / self.view.bounds.width)
//        print(factor)
        let radian = offset / diameter * factor
//        print(radian)
        return radian
    }

    func updateUI(offset: CGFloat) {
        // calculate percentage
        let percent = offset / (topScrollView!.contentSize.width)
        print(percent)
        print("size \(topScrollView?.contentSize), now \(offset)")
        spinContentView?.transform = CGAffineTransformMakeRotation(percentToDegree(percent.DoubleValue).CGFloatValue.DoubleValue.RadianValue.CGFloatValue)
    }
    
    func percentToDegree(percent: Double) -> Double {
        return 360.0 * percent
    }

}

extension CGFloat {
    var DoubleValue: Double {
        return Double(self)
    }
}

extension Double {
    var CGFloatValue: CGFloat {
        return CGFloat(self)
    }
    
    var RadianValue: Double {
        return (M_PI * self / 180.0)
    }
}

extension Int {
    var DoubleValue: Double {
        return Double(self)
    }
}

extension workoutViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        updateUI(-scrollView.contentOffset.x)
    }
}
