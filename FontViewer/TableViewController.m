//
//  TableViewController.m
//  FontViewer
//
//  Created by Victor Wibisono on 22/09/13.
//  Copyright (c) 2013 Victor Wibisono. All rights reserved.
//

#import "TableViewController.h"
#import "SettingsViewController.h"

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray * fontNames;

@end

@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    // Set property which will become the data source of the TableViewController.
    self.fontNames = [[UIFont familyNames] mutableCopy];
    
    // Setting the title in the navigation controller
    // Adding the edit button
    // Adding the settings button
    [self setupEditButton];
    [self setupSettingsButton];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.fontNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = [self.fontNames objectAtIndex:indexPath.row];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.fontNames removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

#pragma mark - Actions

- (void) setupEditButton {
    if ([self numberOfItemsInTable] > 0) {
        UIBarButtonSystemItem rightButtonType;
        if (self.tableView.isEditing) {
            rightButtonType = UIBarButtonSystemItemDone;
        } else {
            rightButtonType = UIBarButtonSystemItemEdit;
        }
        
        UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:rightButtonType target:self action:@selector(editTable:)];
        [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:YES];
        [self.tableView setEditing:NO];
    }
}

- (void)editTable:(id)sender {
    [self.tableView setEditing:!self.tableView.editing animated:YES];
    [self setupEditButton];
}

- (void)setupSettingsButton {
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(displaySettingsScreen)];
    [self.navigationItem setLeftBarButtonItem:settingsButton];
    
}

- (NSInteger)numberOfItemsInTable {
    NSInteger items = 0;
    
    for (int i = 0; i < [self.tableView numberOfSections]; i++) {
        items = items + [self.tableView numberOfRowsInSection:i];
    }
    
    return items;
}

- (void)deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - Selectors

- (void)displaySettingsScreen {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    settingsViewController.title = @"Settings";
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end
