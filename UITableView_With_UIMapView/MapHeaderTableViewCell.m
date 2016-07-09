//
//  MapHeaderTableViewCell.m
//  UITableView_With_UIMapView
//
//  Created by Irvin Geovani Chan Canche on 08/07/16.
//  Copyright © 2016 Irvin Geovani Chan Canche. All rights reserved.
//

#import "MapHeaderTableViewCell.h"

@interface MapHeaderTableViewCell() <UIGestureRecognizerDelegate>
@property (nonatomic, getter=isUpTableView) BOOL upTableview;
@end

CGFloat const MapHeaderCellTableViewCellHeight = 52.f;

@implementation MapHeaderTableViewCell

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self configure];
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style
             reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self configure];
    }
    
    return self;
}

+(CGFloat)height {
    return MapHeaderCellTableViewCellHeight;
}

-(void)configure {
    _upTableview = NO;
    
    UIColor *pinkColor = [UIColor colorWithRed:233/255.0
                                         green:30/255.0
                                          blue:99/255.0
                                         alpha:1.0];
    
    self.contentView.backgroundColor = pinkColor;
    
    UISwipeGestureRecognizer *swipeUpGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                          initWithTarget:self
                                                          action:@selector(handleSwipeUpFrom:)];
    swipeUpGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp;
    swipeUpGestureRecognizer.cancelsTouchesInView = YES;
    swipeUpGestureRecognizer.delaysTouchesBegan = YES;
    swipeUpGestureRecognizer.numberOfTouchesRequired = 1;
    swipeUpGestureRecognizer.delegate = self;
    [self addGestureRecognizer:swipeUpGestureRecognizer];
    
    
    UISwipeGestureRecognizer *swipeDownGestureRecognizer = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self
                                                            action:@selector(handleSwipeDownFrom:)];
    swipeDownGestureRecognizer.direction = UISwipeGestureRecognizerDirectionDown;
    swipeDownGestureRecognizer.cancelsTouchesInView = YES;
    swipeDownGestureRecognizer.delaysTouchesBegan = YES;
    swipeDownGestureRecognizer.numberOfTouchesRequired = 1;
    swipeDownGestureRecognizer.delegate = self;
    [self addGestureRecognizer:swipeDownGestureRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
                                                    initWithTarget:self
                                                    action:@selector(handleTapFrom:)];
    tapGestureRecognizer.cancelsTouchesInView = YES;
    tapGestureRecognizer.delaysTouchesBegan = YES;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.delegate = self;
    [self addGestureRecognizer:tapGestureRecognizer];
    
}

-(void)handleSwipeUpFrom:(id)sender {
    if (!self.isUpTableView) {
        [self.delegate HeaderFooter:self upTableView:NO];
        self.arrowIconUILabel.text = @"";
        _upTableview = YES;
    }
}

-(void)handleSwipeDownFrom:(id)sender {
    if (self.isUpTableView) {
        [self.delegate HeaderFooter:self upTableView:YES];
        self.arrowIconUILabel.text = @"";
        _upTableview = NO;
    }
}

-(void)handleTapFrom:(id)sender {
    if (!self.isUpTableView) {
        [self.delegate HeaderFooter:self upTableView:NO];
        self.arrowIconUILabel.text = @"";
        _upTableview = YES;
    } else {
        [self.delegate HeaderFooter:self upTableView:YES];
        self.arrowIconUILabel.text = @"";
        _upTableview = NO;
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)
otherGestureRecognizer {
    return YES;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}




@end
