//
//  MapHeaderTableViewCell.h
//  UITableView_With_UIMapView
//
//  Created by Irvin Geovani Chan Canche on 08/07/16.
//  Copyright © 2016 Irvin Geovani Chan Canche. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MapHeaderTableViewCell;

@protocol MapHeaderTableDelegate <NSObject>

- (void) HeaderFooter:(MapHeaderTableViewCell *)Header upTableView:(BOOL)isUp;

@end

@interface MapHeaderTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *arrowIconUILabel;

@property (weak, nonatomic) id <MapHeaderTableDelegate> delegate;

+ (CGFloat)height;
@end
