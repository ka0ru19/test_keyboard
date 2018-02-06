//
//  KeyboardViewController.swift
//  Clipboard01
//
//  Created by Wataru Inoue on 2017/12/09.
//  Copyright © 2017年 Wataru Inoue. All rights reserved.
//

import UIKit
class KeyboardViewController: UIInputViewController {
    
    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var clipboardButton1: UIButton!
    @IBOutlet var clipboardButton2: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    let ud = UserDefaults.standard
    
    //    var clbArray: [String] = []
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(
            nibName: "CustomKeyboard",
            bundle: nil
            ).instantiate(withOwner: self, options: nil).first as! UIView
        self.inputView?.addSubview(nib)
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        scrollView.backgroundColor = UIColor.cyan
//        scrollView.frame.size = CGSize(width: 200, height: 200)
//        scrollView.center = self.view.center
        scrollView.contentSize = CGSize(width: 200, height: 10 + 30 * 40)
        scrollView.bounces = false
        scrollView.indicatorStyle = .default
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        scrollView.delegate = self
        
        for i in 0 ..< 30 {
            let button = UIButton()
            button.setTitle("ボタン\(i)", for: .normal)
            button.addTarget(self, action: #selector(self.buttonTapped(sender:)), for: .touchUpInside)
            button.layer.frame.size = CGSize(width: scrollView.layer.frame.width - 20   , height: 30)
            button.frame.origin.y = CGFloat(10 + i * 40)
            button.center.x = scrollView.layer.frame.width / 2
            button.backgroundColor = UIColor.blue
            scrollView.addSubview(button)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    @objc func buttonTapped(sender: UIButton) {
        print("ボタンが押された。タイトル: \(sender.titleLabel?.text)")
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
    
    // helloボタン
    @IBAction func tappedHello(sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.insertText("Hello!!")
    }
    
    // 更新ボタン
    @IBAction func tappedReload(sender: UIButton) {
        // Clipboardをインスタンス化
        let pasteboard = UIPasteboard.general
        
        // クリップボードにテキストがあったら
        if let pasteboardString = pasteboard.string {
            
            //            // KEY01に既にある単語をKEY02に移動する
            //            if let pasteboardString2 = ud.object(forKey: "KEY01") {
            //                print(pasteboardString2)
            //                ud.set(pasteboardString2, forKey: "KEY02")
            //            }
            //
            //            print(pasteboardString)
            //
            //            // udに今のClipboardの単語をkey: KEY01としてその単語を保存
            //            ud.set(pasteboardString, forKey: "KEY01")
            
            // 配列に単語を追加
            
            // udから配列を読み込む
            var wordArray: [AnyObject] = []
            
            if let wordObjectArray = ud.array(forKey: "KEY_ARRAY") {
                wordArray = wordObjectArray as [AnyObject]
            }
            
            // 配列に単語を追加
            wordArray.append(pasteboardString as AnyObject)
            
            ud.set(wordArray, forKey: "KEY_ARRAY")
            
        }
    }
    
    
    // Clipboard1ボタン
    @IBAction func tappedClipboard1(sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if let wordObjectArray = ud.array(forKey: "KEY_ARRAY") {
            print(wordObjectArray)
            proxy.insertText(wordObjectArray[wordObjectArray.count - 1] as? String ?? "")
        }
        
    }
    
    // Clipboard2ボタン
    @IBAction func tappedClipboard2(sender: UIButton) {
        let proxy = textDocumentProxy as UITextDocumentProxy
        if let wordObjectArray = ud.array(forKey: "KEY_ARRAY") {
            print(wordObjectArray)
            proxy.insertText(wordObjectArray[wordObjectArray.count - 2] as? String ?? "")
        }
        
    }
    
    
}

extension KeyboardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //        print("スクロールした")
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //        print("ドラッグ開始")
    }
}

//class KeyboardViewController: UIInputViewController {
//
//    @IBOutlet var nextKeyboardButton: UIButton!
//
//    override func updateViewConstraints() {
//        super.updateViewConstraints()
//
//        // Add custom view sizing constraints here
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Perform custom UI setup here
//        self.nextKeyboardButton = UIButton(type: .system)
//
//        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
//        self.nextKeyboardButton.sizeToFit()
//        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
//
//        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
//
//        self.view.addSubview(self.nextKeyboardButton)
//
//        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
//        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated
//    }
//
//    override func textWillChange(_ textInput: UITextInput?) {
//        // The app is about to change the document's contents. Perform any preparation here.
//    }
//
//    override func textDidChange(_ textInput: UITextInput?) {
//        // The app has just changed the document's contents, the document context has been updated.
//
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
//            textColor = UIColor.white
//        } else {
//            textColor = UIColor.black
//        }
//        self.nextKeyboardButton.setTitleColor(textColor, for: [])
//    }
//
//}

