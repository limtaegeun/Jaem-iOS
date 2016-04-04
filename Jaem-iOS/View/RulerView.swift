//
//  RulerView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 30..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class RulerView: UIView {

    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        drawCanvas1(frame: CGRect(x: (bounds.width - 510 ) / 2 + 8, y: 0, width: 510, height: 55))
    }
    
    func drawCanvas1(frame frame: CGRect = CGRect(x: 0, y: 0, width: 510, height: 55)) {
        //// Color Declarations
        let strokeColor = UIColor(red: 0.920, green: 0.331, blue: 0.117, alpha: 1.000)
        let strokeColor2 = UIColor(red: 0.812, green: 0.812, blue: 0.812, alpha: 1.000)
        
        //// Group 5
        //// Line Drawing
        let linePath = UIBezierPath()
        linePath.moveToPoint(CGPoint(x: frame.minX + 255, y: frame.minY + 0.5))
        linePath.addLineToPoint(CGPoint(x: frame.minX + 255, y: frame.minY + 9.5))
        linePath.miterLimit = 4;
        
        linePath.lineCapStyle = .Square;
        
        linePath.usesEvenOddFillRule = true;
        
        strokeColor.setStroke()
        linePath.lineWidth = 1
        linePath.stroke()
        
        /*
        //// Line-Copy-3 Drawing
        let lineCopy3Path = UIBezierPath()
        lineCopy3Path.moveToPoint(CGPoint(x: frame.minX + 174, y: frame.minY + 0.5))
        lineCopy3Path.addLineToPoint(CGPoint(x: frame.minX + 174, y: frame.minY + 7.5))
        lineCopy3Path.miterLimit = 4;
        
        lineCopy3Path.lineCapStyle = .Square;
        
        lineCopy3Path.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopy3Path.lineWidth = 1
        lineCopy3Path.stroke()
        
        
        //// Line-Copy-4 Drawing
        let lineCopy4Path = UIBezierPath()
        lineCopy4Path.moveToPoint(CGPoint(x: frame.minX + 12, y: frame.minY + 0.5))
        lineCopy4Path.addLineToPoint(CGPoint(x: frame.minX + 12, y: frame.minY + 7.5))
        lineCopy4Path.miterLimit = 4;
        
        lineCopy4Path.lineCapStyle = .Square;
        
        lineCopy4Path.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopy4Path.lineWidth = 1
        lineCopy4Path.stroke()
        
        
        //// Line-Copy Drawing
        let lineCopyPath = UIBezierPath()
        lineCopyPath.moveToPoint(CGPoint(x: frame.minX + 336, y: frame.minY + 0.5))
        lineCopyPath.addLineToPoint(CGPoint(x: frame.minX + 336, y: frame.minY + 7.5))
        lineCopyPath.miterLimit = 4;
        
        lineCopyPath.lineCapStyle = .Square;
        
        lineCopyPath.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopyPath.lineWidth = 1
        lineCopyPath.stroke()
        
        
        //// Line-Copy-2 Drawing
        let lineCopy2Path = UIBezierPath()
        lineCopy2Path.moveToPoint(CGPoint(x: frame.minX + 417, y: frame.minY + 0.5))
        lineCopy2Path.addLineToPoint(CGPoint(x: frame.minX + 417, y: frame.minY + 7.5))
        lineCopy2Path.miterLimit = 4;
        
        lineCopy2Path.lineCapStyle = .Square;
        
        lineCopy2Path.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopy2Path.lineWidth = 1
        lineCopy2Path.stroke()
        
        
        //// Line-Copy- 5 Drawing
        let lineCopy5Path = UIBezierPath()
        lineCopy5Path.moveToPoint(CGPoint(x: frame.minX + 498, y: frame.minY + 0.5))
        lineCopy5Path.addLineToPoint(CGPoint(x: frame.minX + 498, y: frame.minY + 7.5))
        lineCopy5Path.miterLimit = 4;
        
        lineCopy5Path.lineCapStyle = .Square;
        
        lineCopy5Path.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopy5Path.lineWidth = 1
        lineCopy5Path.stroke()
        
        
        //// Line-Copy- 6 Drawing
        let lineCopy6Path = UIBezierPath()
        lineCopy6Path.moveToPoint(CGPoint(x: frame.minX + 93, y: frame.minY + 0.5))
        lineCopy6Path.addLineToPoint(CGPoint(x: frame.minX + 93, y: frame.minY + 7.5))
        lineCopy6Path.miterLimit = 4;
        
        lineCopy6Path.lineCapStyle = .Square;
        
        lineCopy6Path.usesEvenOddFillRule = true;
        
        strokeColor2.setStroke()
        lineCopy6Path.lineWidth = 1
        lineCopy6Path.stroke()
        */
        
    }


}
