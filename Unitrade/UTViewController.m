//
//  UTViewController.m
//  Unitrade
//
//  Created by Way on 13-4-21.
//  Copyright (c) 2013年 waynewgl. All rights reserved.
//

#import "UTViewController.h"
#import "RGMPageView.h"

@interface UTViewController ()



@end


static NSString *reuseIdentifier = @"RGMPageReuseIdentifier";
static NSInteger numberOfPages = 8;


@implementation UTViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.pagingScrollView registerClass:[RGMPageView class] forCellReuseIdentifier:reuseIdentifier];
    
    UIImage *image = [UIImage imageNamed:@"indicator.png"];
    UIImage *imageActive = [UIImage imageNamed:@"indicator-active.png"];
    
    RGMPageControl *indicator = [[RGMPageControl alloc] initWithItemImage:image activeImage:imageActive];
    indicator.numberOfPages = numberOfPages;
    [indicator addTarget:self action:@selector(pageIndicatorValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:indicator];
    self.pageIndicator = indicator;
    
    
    
    // comment out for horizontal scrolling and indicator orientation (defaults)
    self.pagingScrollView.scrollDirection = RGMScrollDirectionHorizontal;
    self.pageIndicator.orientation = RGMPageIndicatorHorizontal;

    
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)pageIndicatorValueChanged:(RGMPageControl *)sender
{
    [self.pagingScrollView setCurrentPage:sender.currentPage animated:YES];
}


- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    
    [self.pageIndicator sizeToFit];
    
    CGRect frame = self.pageIndicator.frame;
    const CGFloat inset = 20.0f;
    
    switch (self.pageIndicator.orientation) {
        case RGMPageIndicatorHorizontal: {
            frame.origin.x = floorf((bounds.size.width - frame.size.width) / 2.0f);
            frame.origin.y = bounds.size.height - frame.size.height - inset;
            frame.size.width = MIN(frame.size.width, bounds.size.width);
            break;
        }
        case RGMPageIndicatorVertical: {
            frame.origin.x = bounds.origin.x + inset;
            frame.origin.y = floorf((bounds.size.height - frame.size.height) / 2.0f);
            frame.size.height = MIN(frame.size.height, bounds.size.height);
            break;
        }
    }
    
    self.pageIndicator.frame = frame;
}


- (NSInteger)pagingScrollViewNumberOfPages:(RGMPagingScrollView *)pagingScrollView
{
    return numberOfPages;
}

- (UIView *)pagingScrollView:(RGMPagingScrollView *)pagingScrollView viewForIndex:(NSInteger)idx
{
    RGMPageView *view = (RGMPageView *)[pagingScrollView dequeueReusablePageWithIdentifer:reuseIdentifier forIndex:idx];
    
    switch (idx % 2) {
        case 0: {
            view.backgroundColor = [UIColor blackColor];
            view.label.textColor = [UIColor whiteColor];
            break;
        }
        case 1: {
            view.backgroundColor = [UIColor whiteColor];
            view.label.textColor = [UIColor blackColor];
            break;
        }
    }
    
    view.label.text = [NSString stringWithFormat:@"%d", idx];
    
    return view;
}

#pragma mark - RGMPagingScrollViewDelegate

- (void)pagingScrollView:(RGMPagingScrollView *)pagingScrollView scrolledToPage:(NSInteger)idx
{
    self.pageIndicator.currentPage = idx;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
