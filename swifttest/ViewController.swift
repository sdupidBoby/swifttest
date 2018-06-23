//
//  ViewController.swift
//  swifttest
//
//  Created by admin on 2018/3/23.
//  Copyright © 2018年 xmt. All rights reserved.
//

import UIKit


/*   结构体和枚举是 值类型(在代码传递中总是被拷贝的）
     类是 引用类型
 */
enum PrinterError: Error {
    case outOfPaper
    case noToner
    case onFire
}
enum enumExp: Int { /*   以此类推  */
    case enum1 = 3
    case enmu2
    case enmu3
    case enmu4
    case enmu6 = 10
}
//                                          ----扩展
extension UIView {
    func getCenterX() -> CGFloat {
        let centerX = self.center.x
        return centerX
    }
    func getCenterY() -> CGFloat {
        let centerY = self.center.y
        return centerY
    }
}

//                                          ----协议
/*注意
 如果你在协议中标记实例方法需求为 mutating ，在为类实现该方法的时候不需要写 mutating 关键字。 mutating 关键字只在结构体和枚举类型中需要书写。
 
 添加 AnyObject 到继承列表中，只能被类类型采纳（并且不是结构体或者枚举）。
 */

//protocol ExampleProtocol: AnyObject
protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

/*  判断是否遵循了ExampleProtocol
    if item as? ExampleProtocol
 */
struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    mutating func adjust() {
        self.simpleDescription += " (adjusted)"
    }
}

class ViewController: UIViewController {
//MARK: ----------------------------- property            -----------------------------
    @IBOutlet weak var test1VC_btn: UIButton!
    
    let fridgeContent = ["milk", "eggs", "leftovers"]
    var VCArry: Array = [ test1VC(),
                          test2VC(),
                          userCenterVC()]
    
    var fridgeIsOpen = false
    var btnArry: Array<UIButton> = []
    var airports: Dictionary = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    
//MARK: ----------------------------- life cycle          -----------------------------

    override func viewDidLoad() {
        super.viewDidLoad()
        setSubProperty()
                
        print("Int类型枚举初始值 enum1:", enumExp.enum1,"enmu2.rawValue:",enumExp.enmu2.rawValue)
        

        var name: String? = """
        \n
        loveway
        this mute line \" words \"
        打印有格式的字符串\n
        """
        print(name!)
        name = nil
        //        if let 解包
        if let name = name {
            _ = "My name is " + name
        } else {
            print("if let 解包/ name is \(String(describing: name?.uppercased()))")
        }
        //        Nil Coalescing Operator（空合运算符 ??）   解包
        let newName1 = name == nil ? "no name" : name!
        let newName2 = name ?? generateRandomName()
        print("解包",newName1,"  空合运算符??  ",newName2)
        
        let possibleNumber = "12,3"
        let index = possibleNumber.index(of: "3")  //得到空格在字符串中的位置
        if let index = index {
            print("解包", possibleNumber.prefix(upTo: index), "\n")
        }
        _ = Int(possibleNumber)
        
        
        //       枚举  throw
        do {
            _ = try send(job: 2, toPrinter: "Never Has Toner")
        } catch PrinterError.noToner {
            print("使用do catch 捕获错误：noToner ")
        } catch {
            print(error)
        }
        let senfHandle = try? send(job: 2, toPrinter: "Never Has Toner") /*   try？ 这个问号表示可选项：允许为空*/
        print("捕获错误.枚举 : \(senfHandle as AnyObject) \n")
        
        //        函数使用
        let tmpFood = "eggs",tmpFood1 = "eggss"
    
        print("冰箱里面有\(tmpFood)? \(fridgeContains(tmpFood,tmpFood1)), 冰箱是否打开:\(fridgeIsOpen)")
        //        构造函数使用
        let food: Food = Food.init()
        print("构造函数使用 food's name: \(food.name)" , separator: "---", terminator: "\n结束符号" )
        
        //        增加可读性
        let justOverOneMillion = 1_000_000.000_000_1
        print("增加可读性: ",justOverOneMillion,"\n")
        
        //        元组
        let http404Error = (code: 200, description: "HTTP OK")
        print("元组：")
        print("The status code is \(http404Error.0)")
        // prints "The status code is 404"
        print("The status message is \(http404Error.1)")
        // prints "The status message is Not Found"
        print("The status message is \(http404Error.description) \n")
        
        //        字典  ----
        print("字典运用：---")
        let copyAirports = airports
        airports.updateValue("chongqing 373", forKey: "CQ")
        print(copyAirports, "------------", airports, "\n")
        
        let results = ["Meghan": 80, "Chris": 90, "Charlotte": 95]
        let formattedResults = results.mapValues { "Score: \($0)" }
        print("字典转换: \(formattedResults) \n")

        var hexColors1 = ["red": "#ff0000", "green": "#00ff00"]
        let hexColors2 = ["blue": "#0000ff"]
        hexColors1.merge(hexColors2) { (_, second) in second }
        print("字典合并：",hexColors1, "\n")
        
        let conferences = ["AltConf", "App Builders", "NSSpain", "gloab"]
        let alphabetical = Dictionary(grouping: conferences) { $0.first! }
        print("分组序列-1: \(alphabetical)")
        let length = Dictionary(grouping: conferences) { $0.count }
        print("分组序列-2: \(length) \n")
        
        let passes = results.filter { key, value in
            return value >= 85
        }
        print("过滤：\(passes) \n")
        
        var stateCapitals = [String: String]()
        stateCapitals.reserveCapacity(50)
        var stateCapitals1 = [String]()
        stateCapitals1.reserveCapacity(50)
        print("一次性分配好内存Capacity： 字典\(stateCapitals.count),\(stateCapitals) 数组\(stateCapitals1.count), \(stateCapitals1)")
        
        
         /*   捕获异常 方法一  */
        print("\n")
        let cacheSandx = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .allDomainsMask, true)
        let oriPath = URL(fileURLWithPath: "\(cacheSandx)/video.mp4")
        let toPath = URL(fileURLWithPath: "\(cacheSandx)/video2.MOV")
        do {
            try FileManager.default.copyItem(at: oriPath, to: toPath)
        }catch {
            print("异常消息-copyItem")
            print(error)
        }
        /*   捕获异常 方法二  */
        guard let _ = try? FileManager.default.copyItem(at: oriPath, to: toPath) else {
            print("异常消息")
            return
        }
        print("copy出错")
        
        
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
    
    // FIXME:swift关键字的使用
    /*
     @discardableResult     1.函数可以没有对象.接收返回值
     final                  1.加到class前，无法被继承  2.属性和函数，无法重写
     mutating               1.使方法可以修改结构体内的属性
     convenience            1.便利构造器
     */
    @discardableResult func fridgeContains(_ foods: String...) -> Bool { /*   ... 表示同类型多参数  */
        fridgeIsOpen = true
        /*
         使用 defer 来写在函数返回后也会被执行的代码块，无论是否错误被抛出。
         你甚至可以在没有错误处理的时候使用 defer ，来简化需要在多处地方返回的函数。
         */
        defer {
            fridgeIsOpen = false
        }
        
        var result: Bool = false
        for food in foods {
            result = fridgeContent.contains(food)
        }
        return result
    }
    
    func send(job: Int, toPrinter printerName: String) throws -> String {
        if printerName == "Never Has Toner" {
            throw PrinterError.noToner
        }
        return "Job sent"
    }
    

    
    func generateRandomName() -> String {
        /*
           int 转string：    String(arc4random_uniform(100))
           double 转string： String(stringInterpolationSegment: number)
         */
        return "Random-" + String((arc4random_uniform(1000)))
    }
    
    @IBAction func jumpTotest1VC(_ sender: Any) {
//        let toVC = VCArry.first!
        let toVC = test1VC()
        toVC.interfaceVar = "一级 --> 二级"
        
        toVC.interfaceClosure =  { (num: Int) -> Void in
            print("一级 <--- 二级，属性回调值：" , num)
        }
        
        /*  swift的循环引用，（这里self并有持有toVC，仅仅是例子而已  */
        toVC.setString(for: nil) {[weak self] (callbackNum) in
            self?.title = "swift grammar"
            print("一级 <-- 二级，方法回调值：", callbackNum)
        }
        
        if toVC.isKind(of: UIViewController.classForCoder()) {
            self.navigationController?.pushViewController(toVC, animated:true) ??
                self.present(toVC, animated: true) { }
        }
        
    }
    @objc func jumpToVC(_ btn: UIButton) -> () {
//        if btn is UIButton {
//        }
        if btn.isKind(of: UIButton.classForCoder()) {
            for (index,item) in btnArry.enumerated() {
                if item === btn {
                    let toVC = VCArry[index+1]
                    if toVC.isKind(of: UIViewController.classForCoder()) {
                        self.navigationController?.pushViewController(toVC, animated:true) ??
                            self.present(toVC, animated: true) { }
                    }
                    break
                }
            }
        }
        
        
        
    }
    
//MARK: ----------------------------- private Methods     -----------------------------

//MARK: ----------------------------- HTTP    Server      -----------------------------

//MARK: ----------------------------- getter and setter   -----------------------------
    func setSubProperty() -> () {
       
//        swift 遍历 - 1
        let     x       = self.test1VC_btn.frame.minX,
                y       = self.test1VC_btn.frame.maxY,
                width   = self.test1VC_btn.frame.width + CGFloat(100),
                height  = self.test1VC_btn.frame.height,
                space   = 25
        for i in 0..<VCArry.count{
            if i == 0 {
                continue
            }
        }
//        swift 遍历 - 2 - 元组遍历
        for (index,item) in VCArry.enumerated() {
            if index == 0 {
                continue
            }
            let btn: UIButton = UIButton.init(frame: CGRect(x: x,
                                                            y: (y + CGFloat(index) * (height + CGFloat(space))),
                                                            width: width,
                                                            height: height))
   
            print("use extension get centerX \(btn.getCenterX())  centerY \(btn.getCenterY())")
            btn.setTitle(getClassName(item), for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.backgroundColor = UIColor.gray
            self.view.addSubview(btn)
            btn.addTarget(self, action: #selector(ViewController.jumpToVC(_:)), for: UIControlEvents.touchUpInside)
            
            btnArry.append(btn)
        }
    }
    
    func getClassName(_ name: Any) -> String {
        return (NSStringFromClass(object_getClass(name)!) )
    }
}

//3 指定构造器 和 便利构造器
class Food {
    var name: String
    init(name: String) {
        self.name = name
    }
    //便利构造器
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

