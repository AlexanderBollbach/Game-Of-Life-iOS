//
//  ViewController.m
//  GameOfLifeIOS
//
//  Created by alexanderbollbach on 9/20/15.
//  Copyright © 2015 alexanderbollbach. All rights reserved.
//

#import "ViewController.h"
#import "GolView.h"
@interface ViewController ()
@property (nonatomic,strong) IBOutlet UIView *golBoardView;
@property(nonatomic,strong)NSTimer *timer;
//@property (nonatomic,strong) NSMutableArray *golArray;

@end

@implementation ViewController {
   int rowLength;
   int columnLength;
   int size;
}
-(void)viewDidAppear:(BOOL)animated {
   [self createGameView];
   [self colorBoardStatic];


}
- (void)viewDidLoad {
   [super viewDidLoad];
   
   size = 256;
   rowLength = 16;
   columnLength = 16;
   
   
   // self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(tickGameView) userInfo:nil repeats:YES];
   //   [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:UITrackingRunLoopMode];
   
   
   // self.golArray = [NSMutableArray arrayWithObjects:
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @YES, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @YES, @YES, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    @NO, @NO, @NO, @NO, @NO, @NO, @NO, @NO,
   //                    nil];
   
   
   
   
   
   
   
   
   
}


//-(void)colorBoard {
//   int counter = 0;
//   for (UIView* view in self.golView.subviews) {
//      if ([[self.golArray objectAtIndex:counter] boolValue]) {
//         view.backgroundColor = [UIColor darkGrayColor]; // ON
//      } else {
//         view.backgroundColor = [UIColor lightGrayColor]; // OFF
//      }
//      counter++;
//   }
//}


- (IBAction)tickOnce:(UIButton *)sender {
   [self tickGolView];
}

-(void)tickGolView {
   
   NSMutableArray *killArray = [NSMutableArray array];
   NSMutableArray *resurrectArray = [NSMutableArray array];
   for (int x = 1; x < size+1; x++) {
      
      GolView* currentView = (GolView*)[self.golBoardView viewWithTag:x];
      
      // inspect current grid
      int tempCount = 0;
      
      // left
      int left = x-1;
      if (left > 0 && left < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:left];
         if (someView.alive) {
            tempCount++;
         }
      }
      // right
      int right = x+1;
      if (right > 0  && right < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:right];
         if (someView.alive) {
            tempCount++;
         }
      }
      // top
      int top = x-rowLength;
      if (top > 0  && top < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:top];
         if (someView.alive) {
            tempCount++;
         }
      }
      // bottom
      int bottom = x+rowLength;
      if (bottom > 0  && bottom < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:bottom];
         if (someView.alive) {
            tempCount++;
         }
      }
      // topLeft
      int topLeft = x-rowLength-1;
      if (topLeft > 0  && topLeft < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:topLeft];
         if (someView.alive) {
            tempCount++;
         }
      }
      // topRight
      int topRight = x-rowLength+1;
      if (topRight > 0  && topRight < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:topRight];
         if (someView.alive) {
            tempCount++;
         }
      }
      // bottomLeft
      int bottomLeft = x+rowLength-1;
      if (bottomLeft > 0  && bottomLeft < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:bottomLeft];
         if (someView.alive) {
            tempCount++;
         }
      }
      // bottomRight
      int bottomRight = x+rowLength+1;
      if (bottomRight > 0  && bottomRight < size+1) {
         GolView* someView = (GolView*)[self.golBoardView viewWithTag:bottomRight];
         if (someView.alive) {
            tempCount++;
         }
      }
      
      // color current grid
      if (currentView.alive) {
         switch (tempCount) {
            case 0:
               [killArray addObject:currentView];
               break;
            case 1:
               [killArray addObject:currentView];
               break;
            case 2:
               [resurrectArray addObject:currentView];
               break;
            case 3:
               [resurrectArray addObject:currentView];
               break;
            case 4 ... 10:
               [killArray addObject:currentView];
               break;
            default:
               break;
         }
      } else {
         if (tempCount == 3) {
            [resurrectArray addObject:currentView];
         }
      }
   }
   
   for (GolView* view in killArray) {
      view.alive = NO;
      view.backgroundColor = [UIColor lightGrayColor];
   }
   for (GolView* view in resurrectArray) {
      view.alive = YES;
      view.backgroundColor = [UIColor darkGrayColor];
   }
  // [self colorBoardStatic];
}


-(void)createGameView {
   
   int countX = 0;
   int countY = 0;
   int tagg = 1;
   
   for (int x = 1; x < size+1; x++) {
      GolView* oneGridView = [[GolView alloc]
                              initWithFrame:CGRectMake(countX,
                                                       countY,
                                                       self.golBoardView.frame.size.width/rowLength - 2,
                                                       self.golBoardView.frame.size.height/columnLength - 2)];
      oneGridView.tag = tagg;
      oneGridView.alive = NO;
      
      [self.golBoardView addSubview:oneGridView];
      
      countX += self.golBoardView.frame.size.width/rowLength;
      
      if (x % rowLength == 0) {
         countX = 0;
         countY += self.golBoardView.frame.size.height/columnLength;
      }
      
      tagg++;
   }
   
   
}



// program sequencer
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
   UITouch *touch = [[event allTouches] anyObject];
   if (touch.view.tag > 0) {
      GolView* golView = (GolView*)touch.view;
      golView.alive = !golView.alive;
   }
   [self colorBoardStatic];
}


-(void)colorBoardStatic {
   int counter = 0;
   for (GolView* view in self.golBoardView.subviews) {
      if (view.alive) {
         view.backgroundColor = [UIColor darkGrayColor]; // ON
      } else {
         view.backgroundColor = [UIColor lightGrayColor]; // OFF
      }
      counter++;
   }
}

@end
