//
//  test2VC.swift
//  swifttest
//
//  Created by admin on 2018/4/4.
//  Copyright © 2018年 xmt. All rights reserved.
//

import UIKit

class test2VC: UIViewController {

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
    deinit {
        print("释放了test2VC")
    }
    //MARK: ----------------------------- System Delegate     -----------------------------
    
    //MARK: ----------------------------- Custom Delegate     -----------------------------
    
    //MARK: ----------------------------- event  Response     -----------------------------
    
    //MARK: ----------------------------- private Methods     -----------------------------
    
    //MARK: ----------------------------- HTTP    Server      -----------------------------
    
    //MARK: ----------------------------- getter and setter   -----------------------------
    func setSubProperty() -> () {
        self.view.backgroundColor = UIColor.white
        self.title = NSStringFromClass(self.classForCoder)
        
//        subStringAndSort()
        
        let layer = CAShapeLayer()
        let bounds = CGRect(x: 50, y: 100, width: 100, height: 100)
        layer.path = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 20, height: 20)).cgPath
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = nil
        layer.lineDashPattern = [8, 6]
        view.layer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        animation.autoreverses = true
        animation.repeatCount = .infinity
        layer.add(animation, forKey: "line")
        
        
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100))
            
            let img = renderer.image { ctx in
                ctx.cgContext.setFillColor(Color.init(red: 222, green: 222, blue: 222)!.cgColor)
                ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
                ctx.cgContext.setLineWidth(3)
                
                let rectangle = CGRect(x: 0, y: 0, width: 100, height: 100)
                ctx.cgContext.addEllipse(in: rectangle)
                ctx.cgContext.drawPath(using: .fillStroke)
            }
            let imageView = UIImageView.init(image: img)
            imageView.frame = CGRect(x: 50, y: 300, width: img.size.width, height: img.size.height)
            view.addSubview(imageView)
        } else {
            // Fallback on earlier versions
        }
      
        createParticles()
    }
    
    // 粒子动画：
    func createParticles() {
        let particleEmitter = CAEmitterLayer()
        
        particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: 100)
        particleEmitter.emitterShape = kCAEmitterLayerLine
        particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let red = makeEmitterCell(color: UIColor.red)
        let green = makeEmitterCell(color: UIColor.green)
        let blue = makeEmitterCell(color: UIColor.blue)
        
        particleEmitter.emitterCells = [red, green, blue]
        
        view.layer.addSublayer(particleEmitter)
    }
    
    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.birthRate = 1
        cell.lifetime = 7.0
        cell.lifetimeRange = 0
        cell.color = color.cgColor
        cell.velocity = 500
        cell.velocityRange = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 2
        cell.spinRange = 3
        cell.scaleRange = 0.5
        cell.scaleSpeed = -0.05
        
        cell.contents = UIImage(named: "Image")?.cgImage
        return cell
    }
    
    
    
    
    func subStringAndSort() -> Void {
        let arr : [String] = [
            "abusaidm.html-snippets-0.2.1",
            "akamud.vscode-javascript-snippet-pack-0.1.5",
            "arturiapendragon.px2rem-0.0.3",
            "christian-kohler.path-intellisense-1.4.2",
            "dbaeumer.vscode-eslint-1.4.8",
            "donjayamanne.jquerysnippets-0.0.1",
            "ecmel.vscode-html-css-0.2.0",
            "formulahendry.auto-close-tag-0.5.6",
            "formulahendry.auto-rename-tag-0.0.15",
            "hbenl.vscode-firefox-debug-1.2.1",
            "hdg.live-html-previewer-0.3.0",
            "hollowtree.vue-snippets-0.1.5",
            "HookyQR.beautify-1.3.0",
            "HookyQR.minify-0.3.0",
            "hridoy.jquery-snippets-1.0.0",
            "joshpeng.theme-onedark-sublime-0.3.6",
            "mkaufman.htmlhint-0.5.0",
            "mrmlnc.vscode-postcss-sorting-3.0.1",
            "msjsdiag.debugger-for-chrome-4.0.0",
            "octref.vetur-0.11.7",
            "qinjia.view-in-browser-0.0.5",
            "robertohuertasm.vscode-icons-7.22.0",
            "robertohuertasm.vscode-icons-7.23.0",
            "sdras.vue-vscode-snippets-1.3.0",
            "sysoev.language-stylus-1.9.1",
            "tanato.vscode-gulp-0.0.4",
            "Zignd.html-css-class-completion-1.17.1",
            ]
        
        var subArr: [String] = []
        for string in arr {
            let index  = string.index(of: ".")
            if let index = index {
                let indexx  = string.index(after: index)
                //print("<--- . --->cout\(arr.count):\(arr.index(of: string) ?? -1)\n",string.suffix(from: indexx))
                let subString  = string.suffix(from: indexx)  // 获取第一个.后面的字符串
                // print(subString)
                
                let endIndex = subString.index(subString.endIndex, offsetBy: -6)
                let subString2 = subString.prefix(upTo: endIndex)
                
                subArr.append(String(subString2))
                print(subString2)
            }
        }
        print("---------", arr,arr.count)
        
        subArr = subArr.sorted()
        for index in 0..<subArr.count {
            print(subArr[index])
        }
        
    }
}



