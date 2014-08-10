//
//  ChecklistItem.h
//  Checklists
//
//  Created by august-mba on 14-8-10.
//  Copyright (c) 2014年 hele. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChecklistItem : NSObject

@property(nonatomic,copy)NSString *text;
@property(nonatomic,assign)BOOL checked;

- (void)toggleChecked;

@end
