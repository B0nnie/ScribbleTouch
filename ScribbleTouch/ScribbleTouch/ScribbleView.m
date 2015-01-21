//
//  ScribbleView.m
//  ScribbleTouch
//
//  Created by Jo Albright on 1/14/15.
//  Copyright (c) 2015 Jo Albright. All rights reserved.
//

#import "ScribbleView.h"

@implementation ScribbleView

//    @[
//
//        @{
//            @"type":@"path",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"points":@[CGPoint,CGPoint,CGPoint]
//        },
//
//        @{
//            @"type":@"circle",
//            @"fillColor":[UIColor greenColor],
//            @"strokeColor":[UIColor blackColor],
//            @"strokeWidth":@2,
//            @"frame":CGRect
//        }
//
//    ];



- (NSMutableArray *)scribbles {
    
    if (_scribbles == nil) { _scribbles = [@[] mutableCopy]; }
    return _scribbles;
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (NSDictionary * scribble in self.scribbles) {
        
//       ***** STROKE COLOR & WIDTH *****
        
        CGContextSetLineWidth(context, [scribble[@"strokeWidth"] floatValue]);
        
        UIColor * strokeColor = scribble[@"strokeColor"];
        [strokeColor set];
       
//       ******* BUILD STROKE PATH *****
        
        BOOL typeIsScribble = [scribble[@"type"] isEqualToString:@"Scribble"];
        BOOL typeIsLine = [scribble[@"type"] isEqualToString:@"Line"];
    
        if(typeIsScribble || typeIsLine) {
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            
            for (NSValue * pointValue in scribble[@"points"]) {
                
                CGPoint point = [pointValue CGPointValue];
                CGContextAddLineToPoint(context, point.x, point.y);
            
        }
            }
        
        /////Draw rectangle
        if ([scribble[@"type"] isEqualToString:@"Rectangle"]){
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            
            //code from shapes app goes here, code for rectangle below; make more if statements for triangle and ellipse
            
            CGContextAddRect(context, rect);
            
        }
        /////draw ellipse
        
        NSArray * points = scribble[@"points"];
        
        if ([scribble[@"type"] isEqualToString:@"Ellipse"] && points.count >1){
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            
            //code from shapes app goes here, code for rectangle below; make more if statements for triangle and ellipse
            
            CGContextAddEllipseInRect (context, rect); }
        
        ///Draw triangle
        
        if ([scribble[@"type"] isEqualToString:@"Triangle"]){
            
            CGPoint firstPoint = [scribble[@"points"][0] CGPointValue];
            CGPoint secondPoint = [scribble[@"points"][1] CGPointValue];
            CGFloat width = secondPoint.x - firstPoint.x;
            CGFloat height = secondPoint.y - firstPoint.y;
            
            CGRect rect = CGRectMake(firstPoint.x, firstPoint.y, width, height);
            
         
            CGContextMoveToPoint(context, firstPoint.x + rect.size.width/2, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, firstPoint.x, secondPoint.y);
            CGContextAddLineToPoint(context, firstPoint.x + rect.size.width/2, firstPoint.y);

            
        }
        
           //code from shapes app goes here, code for rectangle below; make more if statements for triangle and ellipse
    
            
            
        }
        
        CGContextStrokePath(context);
        
    
    
}



//This line of code has to do with trying to to fill path: -(void) addToContext:(CGContextRef) context withScribble: (NSDictionary *)scribbleandType

@end
