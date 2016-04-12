//
//  FitInfoView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class FitInfoView: UIView {

    var tightFit : String = "0"
    var regularFit : String = "0"
    var overFit : String = "0"
    
    var tightExplain : String = "..."
    var regularExplain : String = "..."
    var overExplain : String = "..."
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        drawFitInfo(frame: bounds)
        
    }
    
    
    func drawFitInfo(frame frame: CGRect = CGRect(x: 0, y: 0, width: 414, height: 92)) {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()
        
        //// Color Declarations
        let strokeColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 1.000)
        let color = UIColor(red: 0.600, green: 0.600, blue: 0.600, alpha: 1.000)
        let fillColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 1.000)
        let fillColor2 = UIColor(red: 0.756, green: 0.756, blue: 0.756, alpha: 1.000)
        let strokeColor2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let textForeground = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let textForeground3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        
        
        //// Subframes
        let page3: CGRect = CGRect(x: frame.minX + floor((frame.width - 402) * 0.41667 + 0.5), y: frame.minY + floor((frame.height - 86) * 0.41667) + 0.5, width: 402, height: 86)
        
        
        //// Page-3
        //// j1.옷-보기
        //// Group 4
        //// Oval-50-+-Oval-50-Copy-+-Oval-50-Copy-2
        //// Oval-50 Drawing
        let oval50Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 116, y: page3.minY + 55.5, width: 5, height: 5))
        fillColor.setFill()
        oval50Path.fill()
        
        
        //// Oval-50-Copy Drawing
        let oval50CopyPath = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 134, y: page3.minY + 55.5, width: 5, height: 5))
        fillColor.setFill()
        oval50CopyPath.fill()
        
        
        //// Oval-50-Copy-2 Drawing
        let oval50Copy2Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 152, y: page3.minY + 55.5, width: 5, height: 5))
        fillColor.setFill()
        oval50Copy2Path.fill()
        
        
        
        
        //// Oval-50-+-Oval-50-Copy-+-Oval-50-Copy-2-Copy-Copy
        //// Oval-50-Copy 3 Drawing
        let oval50Copy3Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 17.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval50Copy3Path.fill()
        
        
        //// Oval-50-Copy- 4 Drawing
        let oval50Copy4Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 35.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval50Copy4Path.fill()
        
        
        //// Oval-50-Copy 8 Drawing
        let oval50Copy8Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval50Copy8Path.fill()
        
        
        
        
        //// Oval-50-+-Oval-50-Copy-+-Oval-50-Copy-2-Copy
        //// Oval- 7 Drawing
        let oval7Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 244.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor.setFill()
        oval7Path.fill()
        
        
        //// Oval-50-Copy 5 Drawing
        let oval50Copy5Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 262.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor.setFill()
        oval50Copy5Path.fill()
        
        
        //// Oval-50-Copy- 6 Drawing
        let oval50Copy6Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 280.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor.setFill()
        oval50Copy6Path.fill()
        
        
        
        
        //// Oval-50-+-Oval-50-Copy-+-Oval-50-Copy-2-Copy-Copy-Copy
        //// Oval- 11 Drawing
        let oval11Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 360.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval11Path.fill()
        
        
        //// Oval-50-Copy 7 Drawing
        let oval50Copy7Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 378.5, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval50Copy7Path.fill()
        
        
        //// Oval-50-Copy 9 Drawing
        let oval50Copy9Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 397, y: page3.minY + 55, width: 5, height: 5))
        fillColor2.setFill()
        oval50Copy9Path.fill()
        
        
        
        
        //// Oval-47-+-105
        //// Oval-47 Drawing
        let oval47Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 171.7, y: page3.minY + 29, width: 57, height: 57))
        fillColor3.setFill()
        oval47Path.fill()
        strokeColor2.setStroke()
        oval47Path.lineWidth = 1
        oval47Path.stroke()
        
        
        
        
        //// Oval-47-Copy-+-110
        //// Oval-47-Copy Drawing
        let oval47CopyPath = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 300.5, y: page3.minY + 35, width: 45, height: 45))
        strokeColor.setStroke()
        oval47CopyPath.lineWidth = 1
        oval47CopyPath.stroke()
        
        
        
        
        //// Oval-47-Copy-2-+-95
        //// Oval-47-Copy-2 Drawing
        let oval47Copy2Path = UIBezierPath(ovalInRect: CGRect(x: page3.minX + 55.5, y: page3.minY + 35, width: 45, height: 45))
        strokeColor.setStroke()
        oval47Copy2Path.lineWidth = 1
        oval47Copy2Path.stroke()
        
        
        
        
        //// Label 7 Drawing
        let label7Rect = CGRect(x: page3.minX + 176.56, y: page3.minY, width: 49.46, height: 13)
        let label7Style = NSMutableParagraphStyle()
        label7Style.alignment = .Left
        
        let label7FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label7Style]
        
        "REGULAR ".drawInRect(label7Rect, withAttributes: label7FontAttributes)
        
        
        //// Label 8 Drawing
        let label8Rect = CGRect(x: page3.minX + 192.88, y: page3.minY + 12, width: 13.9, height: 13)
        let label8Style = NSMutableParagraphStyle()
        label8Style.alignment = .Left
        
        let label8FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label8Style]
        
        "FIT".drawInRect(label8Rect, withAttributes: label8FontAttributes)
        
        
        //// Label 9 Drawing
        let label9Rect = CGRect(x: page3.minX + 310.63, y: page3.minY, width: 29.45, height: 13)
        let label9Style = NSMutableParagraphStyle()
        label9Style.alignment = .Left
        
        let label9FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label9Style]
        
        "OVER ".drawInRect(label9Rect, withAttributes: label9FontAttributes)
        
        
        //// Label 10 Drawing
        let label10Rect = CGRect(x: page3.minX + 316.38, y: page3.minY + 12, width: 13.9, height: 13)
        let label10Style = NSMutableParagraphStyle()
        label10Style.alignment = .Left
        
        let label10FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label10Style]
        
        "FIT".drawInRect(label10Rect, withAttributes: label10FontAttributes)
        
        
        //// Label 11 Drawing
        let label11Rect = CGRect(x: page3.minX + 63.94, y: page3.minY, width: 31.68, height: 13)
        let label11Style = NSMutableParagraphStyle()
        label11Style.alignment = .Left
        
        let label11FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label11Style]
        
        "TIGHT ".drawInRect(label11Rect, withAttributes: label11FontAttributes)
        
        
        //// Label 12 Drawing
        let label12Rect = CGRect(x: page3.minX + 71.38, y: page3.minY + 12, width: 13.9, height: 13)
        let label12Style = NSMutableParagraphStyle()
        label12Style.alignment = .Left
        
        let label12FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 10)!, NSForegroundColorAttributeName: textForeground3, NSParagraphStyleAttributeName: label12Style]
        
        "FIT".drawInRect(label12Rect, withAttributes: label12FontAttributes)
        
        
        //// Text Drawing
        let textRect = CGRect(x: page3.minX + 171, y: page3.minY + 44.5, width: 58, height: 26)
        let textTextContent = NSString(string: regularFit)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .Center
        
        let textFontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 16)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: textStyle]
        
        let textTextHeight: CGFloat = textTextContent.boundingRectWithSize(CGSize(width: textRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, textRect)
        textTextContent.drawInRect(CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Text 2 Drawing
        let text2Rect = CGRect(x: page3.minX + 298, y: page3.minY + 44.5, width: 49, height: 26)
        let text2TextContent = NSString(string: overFit)
        let text2Style = NSMutableParagraphStyle()
        text2Style.alignment = .Center
        
        let text2FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 16)!, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: text2Style]
        
        let text2TextHeight: CGFloat = text2TextContent.boundingRectWithSize(CGSize(width: text2Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text2FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text2Rect)
        text2TextContent.drawInRect(CGRect(x: text2Rect.minX, y: text2Rect.minY + (text2Rect.height - text2TextHeight) / 2, width: text2Rect.width, height: text2TextHeight), withAttributes: text2FontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Text 3 Drawing
        let text3Rect = CGRect(x: page3.minX + 53.5, y: page3.minY + 45, width: 49, height: 26)
        let text3TextContent = NSString(string: tightFit)
        let text3Style = NSMutableParagraphStyle()
        text3Style.alignment = .Center
        
        let text3FontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Bold", size: 16)!, NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: text3Style]
        
        let text3TextHeight: CGFloat = text3TextContent.boundingRectWithSize(CGSize(width: text3Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text3Rect)
        text3TextContent.drawInRect(CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
        CGContextRestoreGState(context)
        
        //// Text 4 Drawing
        let text4Rect = CGRect(x: page3.minX + 36, y: page3.minY + 100.5, width: 85, height: 38)
        let text4TextContent = NSString(string: tightExplain)
        let text4Style = NSMutableParagraphStyle()
        text4Style.alignment = .Center
        
        let text4FontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: text4Style]
        
        let text4TextHeight: CGFloat = text4TextContent.boundingRectWithSize(CGSize(width: text4Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text4FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text4Rect)
        text4TextContent.drawInRect(CGRect(x: text4Rect.minX, y: text4Rect.minY + (text4Rect.height - text4TextHeight) / 2, width: text4Rect.width, height: text4TextHeight), withAttributes: text4FontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Text 5 Drawing
        let text5Rect = CGRect(x: page3.minX + 157.5, y: page3.minY + 100.5, width: 85, height: 38)
        let text5TextContent = NSString(string: regularExplain)
        let text5Style = NSMutableParagraphStyle()
        text5Style.alignment = .Center
        
        let text5FontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: UIColor.blackColor(), NSParagraphStyleAttributeName: text5Style]
        
        let text5TextHeight: CGFloat = text5TextContent.boundingRectWithSize(CGSize(width: text5Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text5FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text5Rect)
        text5TextContent.drawInRect(CGRect(x: text5Rect.minX, y: text5Rect.minY + (text5Rect.height - text5TextHeight) / 2, width: text5Rect.width, height: text5TextHeight), withAttributes: text5FontAttributes)
        CGContextRestoreGState(context)
        
        
        //// Text 6 Drawing
        let text6Rect = CGRect(x: page3.minX + 281, y: page3.minY + 100.5, width: 85, height: 38)
        let text6TextContent = NSString(string: overExplain)
        let text6Style = NSMutableParagraphStyle()
        text6Style.alignment = .Center
        
        let text6FontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: text6Style]
        
        let text6TextHeight: CGFloat = text6TextContent.boundingRectWithSize(CGSize(width: text6Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text6FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text6Rect)
        text6TextContent.drawInRect(CGRect(x: text6Rect.minX, y: text6Rect.minY + (text6Rect.height - text6TextHeight) / 2, width: text6Rect.width, height: text6TextHeight), withAttributes: text6FontAttributes)
        CGContextRestoreGState(context)
    }

}
