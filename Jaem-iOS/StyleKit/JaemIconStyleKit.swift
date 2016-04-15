//
//  JaemIconStyleKit.swift
//  jaem
//
//  Created by limtaegeun on 2016. 4. 15..
//  Copyright (c) 2016 whataday. All rights reserved.
//
//  Generated by PaintCode (www.paintcodeapp.com)
//



import UIKit

public class JaemIconStyleKit : NSObject {

    //// Cache

    private struct Cache {
        static var imageOfExitButton: UIImage?
        static var exitButtonTargets: [AnyObject]?
        static var imageOfGraphIcon: UIImage?
        static var graphIconTargets: [AnyObject]?
        static var imageOfMeasureButton: UIImage?
        static var measureButtonTargets: [AnyObject]?
    }

    //// Drawing Methods

    public class func drawCardStackIcon() {
        //// Color Declarations
        let strokeColor = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)

        //// Line-+-Line-Copy-3-+-Line-Copy-4
        //// Line Drawing
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 1, y: 1))
        linePath.addLineToPoint(CGPoint(x: 12.82, y: 1))
        linePath.miterLimit = 4;

        linePath.lineCapStyle = .Square;

        linePath.usesEvenOddFillRule = true;

        strokeColor.setStroke()
        linePath.lineWidth = 1
        linePath.stroke()


        //// Line-Copy-3 Drawing
        let lineCopy3Path = UIBezierPath()
        lineCopy3Path.moveToPoint(CGPoint(x: 1, y: 3))
        lineCopy3Path.addLineToPoint(CGPoint(x: 12.82, y: 3))
        lineCopy3Path.miterLimit = 4;

        lineCopy3Path.lineCapStyle = .Square;

        lineCopy3Path.usesEvenOddFillRule = true;

        strokeColor.setStroke()
        lineCopy3Path.lineWidth = 1
        lineCopy3Path.stroke()


        //// Line-Copy-4 Drawing
        let lineCopy4Path = UIBezierPath()
        lineCopy4Path.moveToPoint(CGPoint(x: 1, y: 5))
        lineCopy4Path.addLineToPoint(CGPoint(x: 12.82, y: 5))
        lineCopy4Path.miterLimit = 4;

        lineCopy4Path.lineCapStyle = .Square;

        lineCopy4Path.usesEvenOddFillRule = true;

        strokeColor.setStroke()
        lineCopy4Path.lineWidth = 1
        lineCopy4Path.stroke()
    }

    public class func drawExitButton() {
        //// General Declarations
        let context = UIGraphicsGetCurrentContext()

        //// Color Declarations
        let fillColor = UIColor(red: 0.907, green: 0.907, blue: 0.907, alpha: 1.000)

        //// exit_black-copy
        //// Fill-16 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 9, 9)
        CGContextRotateCTM(context, -44.95 * CGFloat(M_PI) / 180)

        let fill16Path = UIBezierPath(rect: CGRect(x: -11.83, y: -0.6, width: 23.65, height: 1.2))
        fillColor.setFill()
        fill16Path.fill()

        CGContextRestoreGState(context)


        //// Fill-17 Drawing
        CGContextSaveGState(context)
        CGContextTranslateCTM(context, 9, 9)
        CGContextRotateCTM(context, 44.95 * CGFloat(M_PI) / 180)

        let fill17Path = UIBezierPath(rect: CGRect(x: -11.83, y: -0.6, width: 23.65, height: 1.2))
        fillColor.setFill()
        fill17Path.fill()

        CGContextRestoreGState(context)
    }

    public class func drawAddButton(frame frame: CGRect = CGRect(x: 0, y: 0, width: 27, height: 27)) {
        //// Color Declarations
        let fillColor2 = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.000)


        //// Subframes
        let pluscopy2: CGRect = CGRect(x: frame.minX + floor((frame.width - 24.9) * 0.47552 + 0.5), y: frame.minY + floor((frame.height - 24.9) * 0.47552 + 0.4) + 0.1, width: 24.9, height: 24.9)


        //// plus-copy-2
        //// Fill-38 Drawing
        let fill38Path = UIBezierPath()
        fill38Path.moveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 5.58, y: pluscopy2.minY + 24.9), controlPoint2: CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 19.31))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY), controlPoint1: CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 5.58), controlPoint2: CGPoint(x: pluscopy2.minX + 5.58, y: pluscopy2.minY))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 19.31, y: pluscopy2.minY), controlPoint2: CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 5.58))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9), controlPoint1: CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 19.31), controlPoint2: CGPoint(x: pluscopy2.minX + 19.31, y: pluscopy2.minY + 24.9))
        fill38Path.addLineToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9))
        fill38Path.closePath()
        fill38Path.moveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 6.34, y: pluscopy2.minY + 1.37), controlPoint2: CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 6.34))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 23.53), controlPoint1: CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 18.56), controlPoint2: CGPoint(x: pluscopy2.minX + 6.34, y: pluscopy2.minY + 23.53))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 18.56, y: pluscopy2.minY + 23.53), controlPoint2: CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 18.56))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37), controlPoint1: CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 6.34), controlPoint2: CGPoint(x: pluscopy2.minX + 18.56, y: pluscopy2.minY + 1.37))
        fill38Path.addLineToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37))
        fill38Path.closePath()
        fill38Path.miterLimit = 4;

        fill38Path.usesEvenOddFillRule = true;

        fillColor2.setFill()
        fill38Path.fill()


        //// Fill-39 Drawing
        let fill39Path = UIBezierPath(rect: CGRect(x: pluscopy2.minX + 5.82, y: pluscopy2.minY + 11.72, width: 13.25, height: 1.45))
        fillColor2.setFill()
        fill39Path.fill()


        //// Fill-40 Drawing
        let fill40Path = UIBezierPath(rect: CGRect(x: pluscopy2.minX + 11.72, y: pluscopy2.minY + 5.82, width: 1.45, height: 13.25))
        fillColor2.setFill()
        fill40Path.fill()
    }

    public class func drawAddButton2(frame frame: CGRect = CGRect(x: 0, y: 0, width: 27, height: 27)) {
        //// Color Declarations
        let gray204 = UIColor(red: 0.800, green: 0.800, blue: 0.800, alpha: 1.000)


        //// Subframes
        let pluscopy2: CGRect = CGRect(x: frame.minX + floor((frame.width - 24.9) * 0.47552 + 0.5), y: frame.minY + floor((frame.height - 24.9) * 0.47552 + 0.4) + 0.1, width: 24.9, height: 24.9)


        //// plus-copy-2
        //// Fill-38 Drawing
        let fill38Path = UIBezierPath()
        fill38Path.moveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 5.58, y: pluscopy2.minY + 24.9), controlPoint2: CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 19.31))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY), controlPoint1: CGPoint(x: pluscopy2.minX, y: pluscopy2.minY + 5.58), controlPoint2: CGPoint(x: pluscopy2.minX + 5.58, y: pluscopy2.minY))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 19.31, y: pluscopy2.minY), controlPoint2: CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 5.58))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9), controlPoint1: CGPoint(x: pluscopy2.minX + 24.9, y: pluscopy2.minY + 19.31), controlPoint2: CGPoint(x: pluscopy2.minX + 19.31, y: pluscopy2.minY + 24.9))
        fill38Path.addLineToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 24.9))
        fill38Path.closePath()
        fill38Path.moveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 6.34, y: pluscopy2.minY + 1.37), controlPoint2: CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 6.34))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 23.53), controlPoint1: CGPoint(x: pluscopy2.minX + 1.37, y: pluscopy2.minY + 18.56), controlPoint2: CGPoint(x: pluscopy2.minX + 6.34, y: pluscopy2.minY + 23.53))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 12.45), controlPoint1: CGPoint(x: pluscopy2.minX + 18.56, y: pluscopy2.minY + 23.53), controlPoint2: CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 18.56))
        fill38Path.addCurveToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37), controlPoint1: CGPoint(x: pluscopy2.minX + 23.53, y: pluscopy2.minY + 6.34), controlPoint2: CGPoint(x: pluscopy2.minX + 18.56, y: pluscopy2.minY + 1.37))
        fill38Path.addLineToPoint(CGPoint(x: pluscopy2.minX + 12.45, y: pluscopy2.minY + 1.37))
        fill38Path.closePath()
        fill38Path.miterLimit = 4;

        fill38Path.usesEvenOddFillRule = true;

        gray204.setFill()
        fill38Path.fill()


        //// Fill-39 Drawing
        let fill39Path = UIBezierPath(rect: CGRect(x: pluscopy2.minX + 5.82, y: pluscopy2.minY + 11.17, width: 13.25, height: 1))
        gray204.setFill()
        fill39Path.fill()


        //// Fill-40 Drawing
        let fill40Path = UIBezierPath(rect: CGRect(x: pluscopy2.minX + 11.72, y: pluscopy2.minY + 5.82, width: 1.45, height: 13.25))
        gray204.setFill()
        fill40Path.fill()
    }

    public class func drawGraphIcon() {
        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)
        let strokeColor2 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Page-2
        //// b1.시작화면
        //// plus-copy-3-+-Group-+-Group
        //// Group-+-Group
        //// Group 6
        //// plus-copy-4
        //// Fill-38 Drawing
        let fill38Path = UIBezierPath()
        fill38Path.moveToPoint(CGPoint(x: 13.45, y: 25.9))
        fill38Path.addCurveToPoint(CGPoint(x: 1, y: 13.45), controlPoint1: CGPoint(x: 6.58, y: 25.9), controlPoint2: CGPoint(x: 1, y: 20.31))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 1), controlPoint1: CGPoint(x: 1, y: 6.58), controlPoint2: CGPoint(x: 6.58, y: 1))
        fill38Path.addCurveToPoint(CGPoint(x: 25.9, y: 13.45), controlPoint1: CGPoint(x: 20.31, y: 1), controlPoint2: CGPoint(x: 25.9, y: 6.58))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 25.9), controlPoint1: CGPoint(x: 25.9, y: 20.31), controlPoint2: CGPoint(x: 20.31, y: 25.9))
        fill38Path.addLineToPoint(CGPoint(x: 13.45, y: 25.9))
        fill38Path.closePath()
        fill38Path.moveToPoint(CGPoint(x: 13.45, y: 2.37))
        fill38Path.addCurveToPoint(CGPoint(x: 2.37, y: 13.45), controlPoint1: CGPoint(x: 7.34, y: 2.37), controlPoint2: CGPoint(x: 2.37, y: 7.34))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 24.53), controlPoint1: CGPoint(x: 2.37, y: 19.56), controlPoint2: CGPoint(x: 7.34, y: 24.53))
        fill38Path.addCurveToPoint(CGPoint(x: 24.53, y: 13.45), controlPoint1: CGPoint(x: 19.56, y: 24.53), controlPoint2: CGPoint(x: 24.53, y: 19.56))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 2.37), controlPoint1: CGPoint(x: 24.53, y: 7.34), controlPoint2: CGPoint(x: 19.56, y: 2.37))
        fill38Path.addLineToPoint(CGPoint(x: 13.45, y: 2.37))
        fill38Path.closePath()
        fill38Path.miterLimit = 4;

        fill38Path.usesEvenOddFillRule = true;

        fillColor3.setFill()
        fill38Path.fill()






        //// Group 9
        //// Line Drawing
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: 8.18, y: 8.07))
        linePath.addLineToPoint(CGPoint(x: 8.18, y: 19))
        linePath.miterLimit = 4;

        linePath.lineCapStyle = .Square;

        linePath.usesEvenOddFillRule = true;

        strokeColor2.setStroke()
        linePath.lineWidth = 1.5
        linePath.stroke()


        //// Line-Copy-6 Drawing
        let lineCopy6Path = UIBezierPath()
        lineCopy6Path.moveToPoint(CGPoint(x: 13.81, y: 11.76))
        lineCopy6Path.addLineToPoint(CGPoint(x: 13.81, y: 19))
        lineCopy6Path.miterLimit = 4;

        lineCopy6Path.lineCapStyle = .Square;

        lineCopy6Path.usesEvenOddFillRule = true;

        strokeColor2.setStroke()
        lineCopy6Path.lineWidth = 1.5
        lineCopy6Path.stroke()


        //// Line-Copy-7 Drawing
        let lineCopy7Path = UIBezierPath()
        lineCopy7Path.moveToPoint(CGPoint(x: 19.02, y: 15.27))
        lineCopy7Path.addLineToPoint(CGPoint(x: 19.02, y: 19))
        lineCopy7Path.miterLimit = 4;

        lineCopy7Path.lineCapStyle = .Square;

        lineCopy7Path.usesEvenOddFillRule = true;

        strokeColor2.setStroke()
        lineCopy7Path.lineWidth = 1.5
        lineCopy7Path.stroke()
    }

    public class func drawMeasureButton() {
        //// Color Declarations
        let fillColor3 = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.000)

        //// Page-2
        //// b1.시작화면
        //// plus-copy-3-+-Group-+-Group
        //// plus-copy-3
        //// Fill-38 Drawing
        let fill38Path = UIBezierPath()
        fill38Path.moveToPoint(CGPoint(x: 13.45, y: 25.9))
        fill38Path.addCurveToPoint(CGPoint(x: 1, y: 13.45), controlPoint1: CGPoint(x: 6.58, y: 25.9), controlPoint2: CGPoint(x: 1, y: 20.31))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 1), controlPoint1: CGPoint(x: 1, y: 6.58), controlPoint2: CGPoint(x: 6.58, y: 1))
        fill38Path.addCurveToPoint(CGPoint(x: 25.9, y: 13.45), controlPoint1: CGPoint(x: 20.31, y: 1), controlPoint2: CGPoint(x: 25.9, y: 6.58))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 25.9), controlPoint1: CGPoint(x: 25.9, y: 20.31), controlPoint2: CGPoint(x: 20.31, y: 25.9))
        fill38Path.addLineToPoint(CGPoint(x: 13.45, y: 25.9))
        fill38Path.closePath()
        fill38Path.moveToPoint(CGPoint(x: 13.45, y: 2.37))
        fill38Path.addCurveToPoint(CGPoint(x: 2.37, y: 13.45), controlPoint1: CGPoint(x: 7.34, y: 2.37), controlPoint2: CGPoint(x: 2.37, y: 7.34))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 24.53), controlPoint1: CGPoint(x: 2.37, y: 19.56), controlPoint2: CGPoint(x: 7.34, y: 24.53))
        fill38Path.addCurveToPoint(CGPoint(x: 24.53, y: 13.45), controlPoint1: CGPoint(x: 19.56, y: 24.53), controlPoint2: CGPoint(x: 24.53, y: 19.56))
        fill38Path.addCurveToPoint(CGPoint(x: 13.45, y: 2.37), controlPoint1: CGPoint(x: 24.53, y: 7.34), controlPoint2: CGPoint(x: 19.56, y: 2.37))
        fill38Path.addLineToPoint(CGPoint(x: 13.45, y: 2.37))
        fill38Path.closePath()
        fill38Path.miterLimit = 4;

        fill38Path.usesEvenOddFillRule = true;

        fillColor3.setFill()
        fill38Path.fill()


        //// Fill-39 Drawing
        let fill39Path = UIBezierPath(rect: CGRect(x: 6.82, y: 12.72, width: 13.25, height: 1.45))
        fillColor3.setFill()
        fill39Path.fill()


        //// Fill-40 Drawing
        let fill40Path = UIBezierPath(rect: CGRect(x: 12.72, y: 6.82, width: 1.45, height: 13.25))
        fillColor3.setFill()
        fill40Path.fill()
    }

    //// Generated Images

    public class var imageOfExitButton: UIImage {
        if Cache.imageOfExitButton != nil {
            return Cache.imageOfExitButton!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 18, height: 18), false, 0)
            JaemIconStyleKit.drawExitButton()

        Cache.imageOfExitButton = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfExitButton!
    }

    public class var imageOfGraphIcon: UIImage {
        if Cache.imageOfGraphIcon != nil {
            return Cache.imageOfGraphIcon!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 27, height: 27), false, 0)
            JaemIconStyleKit.drawGraphIcon()

        Cache.imageOfGraphIcon = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfGraphIcon!
    }

    public class var imageOfMeasureButton: UIImage {
        if Cache.imageOfMeasureButton != nil {
            return Cache.imageOfMeasureButton!
        }

        UIGraphicsBeginImageContextWithOptions(CGSize(width: 27, height: 27), false, 0)
            JaemIconStyleKit.drawMeasureButton()

        Cache.imageOfMeasureButton = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return Cache.imageOfMeasureButton!
    }

    //// Customization Infrastructure

    @IBOutlet var exitButtonTargets: [AnyObject]! {
        get { return Cache.exitButtonTargets }
        set {
            Cache.exitButtonTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: JaemIconStyleKit.imageOfExitButton)
            }
        }
    }

    @IBOutlet var graphIconTargets: [AnyObject]! {
        get { return Cache.graphIconTargets }
        set {
            Cache.graphIconTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: JaemIconStyleKit.imageOfGraphIcon)
            }
        }
    }

    @IBOutlet var measureButtonTargets: [AnyObject]! {
        get { return Cache.measureButtonTargets }
        set {
            Cache.measureButtonTargets = newValue
            for target: AnyObject in newValue {
                target.performSelector(NSSelectorFromString("setImage:"), withObject: JaemIconStyleKit.imageOfMeasureButton)
            }
        }
    }

}
