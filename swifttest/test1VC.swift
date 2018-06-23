//
//  test1VC.swift
//  swifttest
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 xmt. All rights reserved.
//

// FIXME: FIXME
// objc_getClass
// TODO: TODO

import UIKit

func WCLog<N>(message:N,fileName:String = #file,methodName:String = #function,lineNumber:Int = #line){
    #if DEBUG
    print("\(fileName as NSString)\n方法:\(methodName)\n行号:\(lineNumber)\n打印信息\(message)");
    #endif
}

/*   结构体  */
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

/*   扩展  */
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

/*   定义一个闭包，类似OC的typedef */
typealias vcCallbackClosure = (Int) -> Swift.Void

class test1VC: UIViewController {
//MARK: ----------------------------- property            -----------------------------
    public var interfaceVar: String?
    var interfaceClosure:((Int) -> Swift.Void)?
    
    private var vccbClosure: vcCallbackClosure?
    
    let propertyName1: String = "property1"
    var propertyName2: String?
    
    var callbackBtn: UIButton!
    
//MARK: ----------------------------- life cycle          -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setSubProperty()

//        闭包  主函数调用loadData:
        loadData { (callbackString) in
            self.propertyName2 = "2"
            print("异步闭包调用： \(callbackString)")
        }
        
//        范型
        var str1 = "str1", str2 = "str2"
        swapTwoValues(&str2, &str1)
        print("引用赋值：范型交换", str1, str2)
        
//        结构体
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        
        if let topItem = stackOfStrings.topItem {
            print("The top item on the stack is \(topItem).")
        }
        
        _ = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
        // doubleIndex is an optional Int with no value, because 9.3 is not in the array
        _ = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])
        // stringIndex is an optional Int containing a value of 2
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    deinit {
        print("deinit(dealloc) test1VC")
    }
//MARK: ----------------------------- System Delegate     -----------------------------

//MARK: ----------------------------- Custom Delegate     -----------------------------

//MARK: ----------------------------- event  Response     -----------------------------
    
    /*   对外回调方法  */
    public func setString(for title: String? , callback: @escaping vcCallbackClosure) -> Void {
        print("\n外部set方法传值：", title as Any)
        self.vccbClosure = callback
    }
    
    /*   event  */
    @objc private func pressToPOP(item: Any?) -> Void {
        shakeView(vw: item as! UIView)
        if let closure = self.vccbClosure {
            closure(1024)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    /*   other  */
    func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
        for (index, value) in array.enumerated() {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    //MARK: swift中闭包传值
    func loadData(completion: @escaping (_ result : [String]) -> Swift.Void ) -> () {
        
        //这里有一个很重要的参数 @escaping，逃逸闭包
        //简单来说就是 闭包在这个函数结束前内被调用，就是非逃逸闭包，调用的地方超过了这函数的范围，叫逃逸闭包
        //一般网络请求都是请求后一段时间这个闭包才执行，所以都是逃逸闭包。
        // 在Swift3.0中所有的闭包都默认为非逃逸闭包，所以需要用@escaping来修饰
        DispatchQueue.global().async {
            
            print("耗时操作\(Thread.current)")
            Thread.sleep(forTimeInterval: 1)
            let json=["1","2"]
            
            DispatchQueue.main.async {
                print("主线程更新\(Thread.current)")
                self.propertyName2 = "1"
                completion(json)
                //函数在执行完后俩秒，主线程才回调数据，超过了函数的范围，这里就是属于逃逸闭包，如果不用@escaping，编译器是编译不过的
            }
        }
    }
    
    /*
     swift：
     传递的是指针地址 : Swift中参数都是 值传递(默认加上let
     
     OC：
     OC对象默认都是指针类型(*)，所以都是引用赋值
    
     js：
     传值赋值 ：基本类型:undefined，boolean，number，string，null
     引用赋值 :     1.数组对自身操作(pop,push,splice)等，slice，filter会返回新数组也属于传值赋值
                    2.对象
    */
    func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
        let temporaryA = a
        a = b
        b = temporaryA
    }
    
    
//MARK: ----------------------------- private Methods     -----------------------------

//MARK: ----------------------------- HTTP    Server      -----------------------------

//MARK: ----------------------------- getter and setter   -----------------------------
    func setSubProperty() -> () {
        self.view.backgroundColor = UIColor.white
        self.title = NSStringFromClass(object_getClass(self)!)
        print("外部传来的值" + (interfaceVar ?? "no value"))
        if let closure = interfaceClosure {
            closure(9527)
        }
        
        //最简单的闭包
        let universalGreeting = {
            print("简单的闭包：Bah-weep-graaaaagnah wheep nini bong \n")
        }
        universalGreeting()
        
        let getGreeting = { (name: String) in
            return "Live long and prosper, \(name). \n"
        }
        let greeting = getGreeting("Paul")
        print(greeting)
        
        
        /// 有参有返回值的闭包  定义
        var block_E:((Int)->(Int))?
        block_E = { (num: Int) -> (Int) in
            let sum = num + 1
            return sum
        }
        /*   拆包调用  */
        if let block = block_E {
           let result = block(1)
            print("== 测试closure ==" ,result)
        }
        
        /*   UI setter  */
        callbackBtn = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        callbackBtn.setTitle("callback", for: .normal)
        callbackBtn.backgroundColor = UIColor.gray
        callbackBtn.setTitleColor(UIColor.white, for: .normal)
        self.view.addSubview(callbackBtn)
        callbackBtn.addTarget(self, action: #selector(pressToPOP(item:)), for: .touchUpInside)
        
        
        setDashLine()

    }
    
    func setDashLine() {
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 50, y: 100, width: 200, height: 200)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii:CGSize(width: 20, height: 10)).cgPath
        layer.strokeColor = UIColor.purple.cgColor
        layer.fillColor = nil 
        layer.lineDashPattern = [8, 6]
        
        self.view.layer.addSublayer(layer)
        
        
        let animation = CABasicAnimation(keyPath: "lineDashPhase")
        animation.fromValue = 0
        animation.toValue = layer.lineDashPattern?.reduce(0) { $0 - $1.intValue } ?? 0
        animation.duration = 1
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
    }
    func shakeView(vw: UIView) {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.4
        animation.isAdditive = true
        
        vw.layer.add(animation, forKey: "shake")
    }
    
    
    func getDefault(_ type: Int) -> Int {
        switch type {
        default:
            return 1
        }
    }
}


