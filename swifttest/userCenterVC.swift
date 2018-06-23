

//
//  userCenterVC.swift
//  swifttest
//
//  Created by admin on 2018/4/8.
//  Copyright © 2018年 xmt. All rights reserved.
//

import UIKit
struct  CollecLayoutType : OptionSet {
    let rawValue: UInt
    static let CollecLayoutType_1 =  CollecLayoutType(rawValue: 1 << 0)
    static let CollecLayoutType_2 =  CollecLayoutType(rawValue: 1 << 1)
    static let CollecLayoutType_3 =  CollecLayoutType(rawValue: 1 << 2)
    static let CollecLayoutType_HNews =  CollecLayoutType(rawValue: 1 << 3)
    static let CollecLayoutType_BaseCell =
        [CollecLayoutType_1, CollecLayoutType_2, CollecLayoutType_3]
}


class userCenterVC: UIViewController {

    //MARK: ----------------------------- property            -----------------------------
    
    //MARK: ----------------------------- life cycle          -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubProperty()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    //MARK: ----------------------------- System Delegate     -----------------------------
    
    //MARK: ----------------------------- Custom Delegate     -----------------------------
    
    //MARK: ----------------------------- event  Response     -----------------------------
    
    //MARK: ----------------------------- private Methods     -----------------------------
    func testOptionSet() -> Void {
        
        let options: CollecLayoutType = [.CollecLayoutType_1, .CollecLayoutType_2]  // 3 (= 1 + 2)
        let op1 = options.contains(.CollecLayoutType_1)          // → true
        let op2 = options.contains(.CollecLayoutType_HNews)  // → false
        let op3 =  options.union([.CollecLayoutType_3]) // → 7 (= 1 + 2 + 4)
        
        print("op1:\(op1), op2:\(op2), op3:\(op3)")
        
        let type: CollecLayoutType = .CollecLayoutType_1
        if (type  == .CollecLayoutType_1) {  // → true
            // TODO
            print("TODO...")
        }
        if (CollecLayoutType.CollecLayoutType_BaseCell.contains(type)) { // → true
            // TODO
            print("TODO...")
        }
        
    }
    //MARK: ----------------------------- HTTP    Server      -----------------------------
    
    //MARK: ----------------------------- getter and setter   -----------------------------
    func setSubProperty() -> () {
        self.view.backgroundColor = UIColor.white
        self.title = NSStringFromClass(self.classForCoder)
        
        testOptionSet()
        
    }

}
