//
//  ViewController.m
//  Checklists
//
//  Created by august-mba on 14-8-9.
//  Copyright (c) 2014年 hele. All rights reserved.
//

#import "ViewController.h"
#import "ChecklistItem.h"

@interface ViewController ()
            

@end

@implementation ViewController{

    NSMutableArray *_items;
}

- (void) configureCheckmarkForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    
    UILabel *label = (UILabel*)[cell viewWithTag:1001];
    if (item.checked) {
        label.text = @"√";
    } else{
        label.text = @"";
    }
}

- (void) configureTextForCell:(UITableViewCell*)cell withChecklistItem:(ChecklistItem*)item{
    UILabel *label = (UILabel*)[cell viewWithTag: 1000];
    label.text = item.text;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _items = [[NSMutableArray alloc]initWithCapacity:20];
    
    ChecklistItem *item;
    
    item = [[ChecklistItem alloc]init];
    item.text = @"观看嫦娥⻜飞天和⽟玉兔升空的视频观看嫦娥⻜飞天和⽟玉兔升空的视频";
    item.checked = YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.text = @"了解Sony a7和MBP的最新价格";
    item.checked = YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.text = @"观看嫦娥⻜飞天和⽟玉兔升空的视频观看嫦娥⻜飞天和⽟玉兔升空的视频";
    item.checked = YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.text = @"复习苍⽼老师的经典视频教程";
    item.checked = YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.text = @"去电影院看地⼼心引⼒力";
    item.checked = YES;
    [_items addObject:item];
    
    item = [[ChecklistItem alloc]init];
    item.text =@"看⻄西甲巴萨新败的⽐比赛回放";
    item.checked = NO;
    [_items addObject:item];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_items count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"ChecklistItem"];
    
    ChecklistItem *item = _items[indexPath.row];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self configureCheckmarkForCell:cell withChecklistItem:item];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    ChecklistItem *item = _items[indexPath.row];
    
    [item toggleChecked];

    [self configureCheckmarkForCell:cell withChecklistItem:item];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_items removeObjectAtIndex:indexPath.row];
    
    NSArray* indexPaths = @[indexPath];
    
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];

}

//ItemDetailControllerDelegate

- (void)itemDetailController:(ItemDetailViewController *)controller didFinishAddingItem:(ChecklistItem *)item {
    NSInteger newRowIndex = [_items count];
    
    [_items addObject:item];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = @[indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)itemDetailController:(ItemDetailViewController *)controller didFinishEditingItem:(ChecklistItem *)item{
    NSInteger index = [_items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell withChecklistItem:item];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)itemDetailControllerDidCancel:(ItemDetailViewController *)controller{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"AddItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
    } else if([segue.identifier isEqualToString:@"EditItem"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        ItemDetailViewController *controller = (ItemDetailViewController*)navigationController.topViewController;
        controller.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        controller.itemToEdit = _items[indexPath.row];
        
    }
}
@end
