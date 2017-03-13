//
//  ToolExtension.swift
//  ZhiHuNewsSwift
//
//  Created by ZJQ on 2017/3/9.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

import UIKit


let screenW = UIScreen.main.bounds.width
let screenH = UIScreen.main.bounds.height


extension UIColor {

    static func rgba(r: CGFloat, g: CGFloat, b: CGFloat,a: CGFloat) -> UIColor {
    
        return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    static func colorFromHex(hex: UInt32) -> UIColor {
    
        return UIColor.init(red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
                            green: CGFloat((hex & 0xFF00) >> 8) / 255.0,
                            blue: CGFloat((hex & 0xFF)) / 255.0,
                            alpha: 1.0)
    }
    
}

extension String {

    static func  getStringSize(text: String, rectSize: CGSize,fontSize: CGFloat) -> CGSize {
    
        let str = text as NSString
        
        let rect = str.boundingRect(with: rectSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: fontSize)], context: nil)
        
        return rect.size
    }

}

extension UIView {

    public var x: CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
    }
    
    public var y: CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
    }
    
    
    public var left: CGFloat{
        
        get {
            return self.frame.origin.x
        }
        set{
            
            var r = self.frame
            r.origin.x = newValue
            self.frame = r
        }
        
    }
    
    
    public var right: CGFloat{
        
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set{
            
            var r = self.frame
            r.origin.x = newValue - r.size.width
            self.frame = r
        }
        
    }
    
    public var top: CGFloat{
        
        get {
            return self.frame.origin.y
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue
            self.frame = r
        }
        
    }
    
    
    public var bottom: CGFloat{
        
        get {
            return self.frame.origin.y+self.frame.size.height
        }
        set{
            
            var r = self.frame
            r.origin.y = newValue - self.frame.size.height
            self.frame = r
        }
        
    }
    
    public var width: CGFloat{
        
        get {
            return self.frame.size.width
        }
        set{
            
            var r = self.frame
            r.size.width = newValue
            self.frame = r
        }
        
    }
    
    public var height: CGFloat{
        
        get {
            return self.frame.size.height
        }
        set{
            
            var r = self.frame
            r.size.height = newValue
            self.frame = r
        }
        
    }
    
    public var zj_origin: CGPoint{
        
        get {
            return self.frame.origin
        }
        set{
            
            var r = self.frame
            r.origin = newValue
            self.frame = r
        }
        
    }
}
