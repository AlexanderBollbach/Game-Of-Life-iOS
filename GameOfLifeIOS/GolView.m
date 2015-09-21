//
//  GolView.m
//  GameOfLifeIOS
//
//  Created by alexanderbollbach on 9/20/15.
//  Copyright © 2015 alexanderbollbach. All rights reserved.
//

#import "GolView.h"

@implementation GolView

-(instancetype)initWithFrame:(CGRect)frame {
   if (self = [super initWithFrame:frame]) {
      self.alive = YES;
   }
   return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
