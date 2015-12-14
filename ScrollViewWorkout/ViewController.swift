//
//  ViewController.swift
//  ScrollViewWorkout
//
//  Created by David on 2015/12/8.
//  Copyright © 2015年 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topScrollView: UIScrollView!
    var contentScrollView: UIScrollView!
    var colorChangingBackgroundView: UIView!
    
    var changingColors = [["r": 238/255.0, "g": 148/255.0, "b": 125/255.0], ["r": 155/255.0, "g": 249/255.0, "b": 249/255.0], ["r": 1.0, "g": 1.0, "b": 1.0]]
    
    // rotate view
    var view1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topScrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        contentScrollView = UIScrollView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        topScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        contentScrollView.contentSize = CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        
        let colors = [UIColor.redColor(), UIColor.blueColor(), UIColor.greenColor(), UIColor.purpleColor(), UIColor.grayColor()]
        for i in 0...2 {
            let v = UIView(frame: CGRectMake(0 + CGFloat(i) * contentScrollView.frame.width, 0, contentScrollView.frame.width, contentScrollView.frame.height))
            v.backgroundColor = colors[i]
            contentScrollView.addSubview(v)
        }
        
//        view.addSubview(contentScrollView)
        view.addSubview(topScrollView)
        topScrollView.delegate = self
        topScrollView.pagingEnabled = true
        topScrollView.bounces = false
        
        // color background
        colorChangingBackgroundView = UIView(frame: self.view.frame)
        view.addSubview(colorChangingBackgroundView)
        view.bringSubviewToFront(topScrollView)
        colorChangingBackgroundView.backgroundColor = UIColor(red: 238/255.0, green: 148/255.0, blue: 125/255.0, alpha: 1)
        
        // attach view
        view1 = UIImageView(frame: CGRectMake(200, 0, 100, 200))
        view1.image = UIImage(named: "1.png")
        
        topScrollView.addSubview(view1)
        
        //test rotate and add a view
        let v = UIView(frame: CGRectMake(0,0,50,50))
        v.backgroundColor = UIColor.blueColor()
        view1.transform = CGAffineTransformMakeRotation(degreesToRadians(30))
        view1.addSubview(v)
        
    }
    
    func updateUI(offset: CGFloat) {
        view1.transform = CGAffineTransformMakeRotation(degreesToRadians(offset.DoubleValue))
    }
    
    func degreesToRadians(angle: Double) -> CGFloat {
        return CGFloat(M_PI * angle / 180.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
//        contentScrollView.contentOffset.x = scrollView.contentOffset.x
        let index = Int(scrollView.contentOffset.x / self.view.frame.width)
        let offset = scrollView.contentOffset.x % self.view.frame.width
        
        if index < 2 {
            let r = CGFloat(changingColors[index]["r"]!) * (255.0 - offset) / 255.0 +  CGFloat(changingColors[index + 1]["r"]!) * (offset) / 255.0
            let g = CGFloat(changingColors[index]["g"]!) * (255.0 - offset) / 255.0  +  CGFloat(changingColors[index + 1]["g"]!) * (offset) / 255.0
            let b = CGFloat(changingColors[index]["b"]!) * (255.0 - offset) / 255.0  +  CGFloat(changingColors[index + 1]["b"]!) * (offset) / 255.0
            
            print("r:\(r) g:\(g) b:\(b)")

            colorChangingBackgroundView.backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        }
        
        updateUI(-scrollView.contentOffset.x)
    }
}

