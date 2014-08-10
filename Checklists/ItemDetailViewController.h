//
//  ItemDetailController.h
//  Checklists
//
//  Created by august-mba on 14-8-10.
//  Copyright (c) 2014年 hele. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemDetailViewController;
@class ChecklistItem;

@protocol ItemDetailControllerDelegate <NSObject>

- (void)itemDetailControllerDidCancel:(ItemDetailViewController*)controller;
- (void)itemDetailController:(ItemDetailViewController*)controller didFinishAddingItem:(ChecklistItem*)item;
- (void)itemDetailController:(ItemDetailViewController*)controller didFinishEditingItem:(ChecklistItem*)item;

@end

@interface ItemDetailViewController : UITableViewController<UITextFieldDelegate>

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak,nonatomic)id <ItemDetailControllerDelegate> delegate;
@property (weak,nonatomic)ChecklistItem *itemToEdit;
@end
