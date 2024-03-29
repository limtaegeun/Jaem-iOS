//
//  JaemViewStyleKit.swift
//  jaem
//
//  Created by limtaegeun on 2016. 4. 15..
//  Copyright (c) 2016 whataday. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class JaemViewStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfEmptyAvatar: UIImage?
        static var emptyAvatarTargets: [AnyObject]?
    }

    //// Drawing Methods

    public class func drawRectangle(frame frame: CGRect = CGRect(x: 0, y: 0, width: 306, height: 46)) {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 1.000)

        //// Rectangle-15-Copy-11 Drawing
        let rectangle15Copy11Path = UIBezierPath(roundedRect: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: frame.width - 2, height: frame.height - 2), cornerRadius: 10)
        strokeColor.setStroke()
        rectangle15Copy11Path.lineWidth = 1
        rectangle15Copy11Path.stroke()
    }

    public class func drawUnderLine(frame frame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 39)) {
        //// Color Declarations
        let color = UIColor(red: 0.600, green: 0.600, blue: 0.600, alpha: 1.000)

        //// Bezier Drawing
        let bezierPath = UIBezierPath()
        bezierPath.moveToPoint(CGPoint(x: frame.maxX - 180, y: frame.maxY - 1.5))
        bezierPath.addLineToPoint(CGPoint(x: frame.maxX, y: frame.maxY - 1.5))
        bezierPath.lineCapStyle = .Round;

        color.setStroke()
        bezierPath.lineWidth = 1
        bezierPath.stroke()
    }

    public class func drawFitInfo(frame frame: CGRect = CGRect(x: 0, y: 0, width: 414, height: 141)) {
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
        let page3: CGRect = CGRect(x: frame.minX + floor((frame.width - 402) * 0.41667 + 0.5), y: frame.minY + floor((frame.height - 138.5) * 1.00000 + 0.5), width: 402, height: 138.5)


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
        let textTextContent = NSString(string: "106")
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
        let text2TextContent = NSString(string: "104")
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
        let text3TextContent = NSString(string: "104")
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
        let text4TextContent = NSString(string: "가슴이 답답할 수 있어요")
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
        let text5TextContent = NSString(string: "적당해요\n")
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
        let text6TextContent = NSString(string: "허리 품이 많이 남아요")
        let text6Style = NSMutableParagraphStyle()
        text6Style.alignment = .Center

        let text6FontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(13), NSForegroundColorAttributeName: color, NSParagraphStyleAttributeName: text6Style]

        let text6TextHeight: CGFloat = text6TextContent.boundingRectWithSize(CGSize(width: text6Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: text6FontAttributes, context: nil).size.height
        CGContextSaveGState(context)
        CGContextClipToRect(context, text6Rect)
        text6TextContent.drawInRect(CGRect(x: text6Rect.minX, y: text6Rect.minY + (text6Rect.height - text6TextHeight) / 2, width: text6Rect.width, height: text6TextHeight), withAttributes: text6FontAttributes)
        CGContextRestoreGState(context)
    }

    public class func drawGoStore(frame frame: CGRect = CGRect(x: 0, y: 0, width: 368, height: 60)) {
        //// Color Declarations
        let textForeground = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)
        let fillColor4 = UIColor(red: 0.243, green: 0.528, blue: 0.250, alpha: 1.000)
        let fillColor5 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)


        //// Subframes
        let page3: CGRect = CGRect(x: frame.minX + 1, y: frame.minY + 1, width: frame.width - 3, height: frame.height - 3)


        //// Page-3
        //// j1.옷-보기
        //// Group-Copy
        //// 카드_mybody-+-exit_black-copy-2
        //// 카드_mybody
        //// Rectangle-11 Drawing
        let rectangle11Path = UIBezierPath(roundedRect: CGRect(x: page3.minX + floor(page3.width * 0.00000 + 0.5), y: page3.minY + floor(page3.height * 0.00000 + 0.5), width: floor(page3.width * 1.00000 + 0.5) - floor(page3.width * 0.00000 + 0.5), height: floor(page3.height * 1.00000 + 0.5) - floor(page3.height * 0.00000 + 0.5)), cornerRadius: 10)
        fillColor4.setFill()
        rectangle11Path.fill()


        //// Label Drawing
        let labelRect = CGRect(x: page3.minX + floor(page3.width * 0.41096 + 0.5), y: page3.minY + floor(page3.height * 0.21053 + 0.5), width: floor(page3.width * 0.59178 + 0.5) - floor(page3.width * 0.41096 + 0.5), height: floor(page3.height * 0.49123 + 0.5) - floor(page3.height * 0.21053 + 0.5))
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .Left

        let labelFontAttributes = [NSFontAttributeName: UIFont(name: "Helvetica-Light", size: 11)!, NSForegroundColorAttributeName: textForeground, NSParagraphStyleAttributeName: labelStyle]

        "GO STORE\n".drawInRect(labelRect, withAttributes: labelFontAttributes)




        //// exit_black-copy-2
        //// Fill-26 Drawing
        let fill26Path = UIBezierPath()
        fill26Path.moveToPoint(CGPoint(x: page3.minX + 0.63989 * page3.width, y: page3.minY + 0.48962 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.65683 * page3.width, y: page3.minY + 0.35478 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.63989 * page3.width, y: page3.minY + 0.21993 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.63758 * page3.width, y: page3.minY + 0.23830 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.65222 * page3.width, y: page3.minY + 0.35478 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.63758 * page3.width, y: page3.minY + 0.47125 * page3.height))
        fill26Path.addLineToPoint(CGPoint(x: page3.minX + 0.63989 * page3.width, y: page3.minY + 0.48962 * page3.height))
        fill26Path.closePath()
        fill26Path.miterLimit = 4;

        fill26Path.usesEvenOddFillRule = true;

        fillColor5.setFill()
        fill26Path.fill()


        //// Fill-27 Drawing
        let fill27Path = UIBezierPath(rect: CGRect(x: page3.minX + floor(page3.width * 0.61918 + 0.5), y: page3.minY + floor(page3.height * 0.33421 - 0.15) + 0.65, width: floor(page3.width * 0.65452 - 0.4) - floor(page3.width * 0.61918 + 0.5) + 0.9, height: floor(page3.height * 0.37456 - 0.45) - floor(page3.height * 0.33421 - 0.15) + 0.3))
        fillColor5.setFill()
        fill27Path.fill()
    }

    public class func drawEmptyAvatar() {
        //// Color Declarations
        let fillColor2 = UIColor(red: 0.756, green: 0.756, blue: 0.756, alpha: 1.000)
        let textForeground4 = UIColor(red: 0.756, green: 0.756, blue: 0.756, alpha: 1.000)

        //// Page-2
        //// b1.시작화면
        //// HELLO-Copy-+-plus-copy-3
        //// Label Drawing
        let labelRect = CGRect(x: 6, y: 87, width: 139, height: 18)
        let labelStyle = NSMutableParagraphStyle()
        labelStyle.alignment = .Left

        let labelFontAttributes = [NSFontAttributeName: UIFont.systemFontOfSize(UIFont.systemFontSize()), NSForegroundColorAttributeName: textForeground4, NSParagraphStyleAttributeName: labelStyle]

        "MEASURE MY BODY".drawInRect(labelRect, withAttributes: labelFontAttributes)


        //// plus-copy-3
        //// Fill-38 Drawing
        let fill38Path = UIBezierPath()
        fill38Path.moveToPoint(CGPoint(x: 75.39, y: 63.74))
        fill38Path.addCurveToPoint(CGPoint(x: 44.02, y: 32.37), controlPoint1: CGPoint(x: 58.09, y: 63.74), controlPoint2: CGPoint(x: 44.02, y: 49.67))
        fill38Path.addCurveToPoint(CGPoint(x: 75.39, y: 1), controlPoint1: CGPoint(x: 44.02, y: 15.07), controlPoint2: CGPoint(x: 58.09, y: 1))
        fill38Path.addCurveToPoint(CGPoint(x: 106.76, y: 32.37), controlPoint1: CGPoint(x: 92.68, y: 1), controlPoint2: CGPoint(x: 106.76, y: 15.07))
        fill38Path.addCurveToPoint(CGPoint(x: 75.39, y: 63.74), controlPoint1: CGPoint(x: 106.76, y: 49.67), controlPoint2: CGPoint(x: 92.68, y: 63.74))
        fill38Path.addLineToPoint(CGPoint(x: 75.39, y: 63.74))
        fill38Path.closePath()
        fill38Path.moveToPoint(CGPoint(x: 75.39, y: 4.45))
        fill38Path.addCurveToPoint(CGPoint(x: 47.46, y: 32.37), controlPoint1: CGPoint(x: 59.99, y: 4.45), controlPoint2: CGPoint(x: 47.46, y: 16.97))
        fill38Path.addCurveToPoint(CGPoint(x: 75.39, y: 60.29), controlPoint1: CGPoint(x: 47.46, y: 47.77), controlPoint2: CGPoint(x: 59.99, y: 60.29))
        fill38Path.addCurveToPoint(CGPoint(x: 103.31, y: 32.37), controlPoint1: CGPoint(x: 90.79, y: 60.29), controlPoint2: CGPoint(x: 103.31, y: 47.77))
        fill38Path.addCurveToPoint(CGPoint(x: 75.39, y: 4.45), controlPoint1: CGPoint(x: 103.31, y: 16.97), controlPoint2: CGPoint(x: 90.79, y: 4.45))
        fill38Path.addLineToPoint(CGPoint(x: 75.39, y: 4.45))
        fill38Path.closePath()
        fill38Path.miterLimit = 4;

        fill38Path.usesEvenOddFillRule = true;

        fillColor2.setFill()
        fill38Path.fill()


        //// Fill-39 Drawing
        let fill39Path = UIBezierPath(rect: CGRect(x: 58.71, y: 30.52, width: 33.35, height: 3.7))
        fillColor2.setFill()
        fill39Path.fill()


        //// Fill-40 Drawing
        let fill40Path = UIBezierPath(rect: CGRect(x: 73.54, y: 15.7, width: 3.7, height: 33.35))
        fillColor2.setFill()
        fill40Path.fill()
    }

    //// Generated Images

    public class func imageOfUnderLine(frame frame: CGRect = CGRect(x: 0, y: 0, width: 180, height: 39)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0)
            JaemViewStyleKit.drawUnderLine(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))

        let imageOfUnderLine = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return imageOfUnderLine
    }

    public class var imageOfEmptyAvatar: UIImage {
        if Cache.imageOfEmptyAvatar != nil {
            return Cache.imageOfEmptyAvatar!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 150, height: 105), false, 0)
            JaemViewStyleKit.drawEmptyAvatar()

        Cache.imageOfEmptyAvatar = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfEmptyAvatar!
    }

    //// Customization Infrastructure

    @IBOutlet var emptyAvatarTargets: [AnyObject]! {
        get { return Cache.emptyAvatarTargets }
        set {
            Cache.emptyAvatarTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: JaemViewStyleKit.imageOfEmptyAvatar)
            }
        }
    }

}
