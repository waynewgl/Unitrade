//
//  UTViewController.h
//  Unitrade
//
//  Created by Way on 13-4-21.
//  Copyright (c) 2013年 waynewgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RGMPageControl.h"
#import "RGMPagingScrollView.h"


@class RGMPagingScrollView;
@class RGMPageControl;


@interface UTViewController : UIViewController <RGMPagingScrollViewDatasource,RGMPagingScrollViewDelegate>




@property (nonatomic, strong) IBOutlet RGMPagingScrollView *pagingScrollView;
@property (nonatomic, strong) IBOutlet RGMPageControl *pageIndicator;




@end
