//
//  GolView.m
//  GameOfLifeIOS
//
//  Created by alexanderbollbach on 9/20/15.
//  Copyright © 2015 alexanderbollbach. All rights reserved.
//

#import "GolView.h"

@interface GolView()
@property (nonatomic,strong) CAShapeLayer *shapeLayer;
@property (nonatomic,assign) CGPathRef path1;
@property (nonatomic,assign) CGPathRef path2;

@end

@implementation GolView

-(instancetype)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
    
      self.shapeLayer = [CAShapeLayer layer];
      [self.layer addSublayer:self.shapeLayer];
      
      self.backgroundColor = [UIColor clearColor];
      
      CGFloat width = self.bounds.size.width;
      CGFloat height = self.bounds.size.height;
      
      UIBezierPath *bezPath1 = [UIBezierPath bezierPath];

      [bezPath1 moveToPoint:CGPointMake(0,0)];
      [bezPath1 addLineToPoint:CGPointMake(width,0)];
      [bezPath1 addLineToPoint:CGPointMake(width/2, height)];
            [bezPath1 addLineToPoint:CGPointMake(0,0)];
   //   [bezPath1 stroke];
  //    [bezPath1 closePath];
      self.path1 = bezPath1.CGPath;

      UIBezierPath *bezPath2 = [UIBezierPath bezierPath];
      [bezPath2 moveToPoint:CGPointMake(width/2, 0)];
      [bezPath2 addLineToPoint:CGPointMake(width, height)];
      [bezPath2 addLineToPoint:CGPointMake(0, height)];
      [bezPath2 addLineToPoint:CGPointMake(width/2, 0)];

      [bezPath2 closePath];
      [bezPath2 stroke];
      self.path2 = bezPath2.CGPath;

      self.shapeLayer.fillColor = [UIColor redColor].CGColor;
      self.shapeLayer.strokeColor = [UIColor whiteColor].CGColor;

      self.shapeLayer.path = self.path1;
      self.alive = YES;

   }
   return self;
}



- (void)setAlive:(BOOL)alive {
   _alive = alive;
   CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"path"];

   if (_alive) {
      basicAni.fromValue = (__bridge id _Nullable)(self.path1);
      basicAni.toValue = (__bridge id _Nullable)(self.path2);
   } else {
      basicAni.fromValue = (__bridge id _Nullable)(self.path2);
      basicAni.toValue = (__bridge id _Nullable)(self.path1);
   }
      basicAni.duration = 0.5;
      basicAni.removedOnCompletion = NO;
      basicAni.fillMode = kCAFillModeForwards;
      [self.shapeLayer addAnimation:basicAni forKey:nil];
   
   
}





@end
