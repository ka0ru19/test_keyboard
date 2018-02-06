//
//  ViewController.swift
//  KeyboardTest
//
//  Created by Wataru Inoue on 2017/12/09.
//  Copyright © 2017年 Wataru Inoue. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.cyan
        
        scrollView.frame.size = CGSize(width: 200, height: 200)
        scrollView.center = self.view.center
        
        scrollView.contentSize = CGSize(width: 200, height: 10 + 30 * 40)
        
        scrollView.bounces = false
        
        scrollView.indicatorStyle = .default
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        scrollView.delegate = self
        
        for i in 0 ..< 30 {
            let button = UIButton()
            button.setTitle("ボタン0\(i)", for: .normal)
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            button.layer.frame.size = CGSize(width: 120, height: 30)
            button.frame.origin.y = CGFloat(10 + i * 40)
            button.center.x = 100
            button.backgroundColor = UIColor.blue
            scrollView.addSubview(button)
        }
        
        self.view.addSubview(scrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func buttonTapped(sender: UIButton) {
        print("ボタンが押された。タイトル: \(sender.titleLabel?.text)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("スクロールした")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        print("ドラッグ開始")
    }

}

