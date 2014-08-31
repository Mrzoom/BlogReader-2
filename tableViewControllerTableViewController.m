//
//  tableViewControllerTableViewController.m
//  BlogReader#2
//
//  Created by zoom on 14-3-14.
//  Copyright (c) 2014年 Jiance Tong. All rights reserved.
//

#import "tableViewControllerTableViewController.h"
#import "BlogPost.h"
#import "webViewController.h"

@interface tableViewControllerTableViewController ()

@end

@implementation tableViewControllerTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *data=[NSURL URLWithString:@"http://blog.teamtreehouse.com/api/get_recent_summary/"];
    NSData *jsonData=[NSData dataWithContentsOfURL:data];
    NSError *error;
    NSDictionary *jsonDictionary=[NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    NSArray *blogPostsarray =[jsonDictionary objectForKey:@"posts"];
    self.blogPosts=[NSMutableArray array];  ///没有新建也不会报错
    for (NSDictionary * data in blogPostsarray) {
        BlogPost * blog=[BlogPost blogPostWithTitle:[data objectForKey:@"title"]];
        blog.author = [data objectForKey:@"author"];
        blog.thumbnail=[data objectForKey:@"thumbnail"];
        blog.date=[data objectForKey:@"date"];
        blog.url =[NSURL URLWithString:[data objectForKey:@"url"]];
        [self.blogPosts addObject:blog];
    }
    //NSLog(@"%@",self.blogPosts);
//    self.title = @[@"Blog1",@"Blog2",@"Blog3",@"Blog4",@"Blog5"];
//    self.title2 = @[@"1Blog1",@"Blog2",@"Blog3",@"Blog4",@"Blog5"];
//    self.title3 = @[@"2Blog1",@"Blog2",@"Blog3",@"Blog4",@"Blog5"];
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
//    if (section==0) return self.title.count;
//    else if (section==1) return self.title2.count;
//    else return self.title3.count;
    return self.blogPosts.count;
    
}

//-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if (section==0) {
//        return @"section1";
//    }
//    else if (section==1){
//        return @"section2";
//    }
//    else return @"section3";
//}

//- (UITableViewHeaderFooterView *)headerViewForSection:(NSInteger)section
//{
//    UITableViewHeaderFooterView *name=[UITableViewHeaderFooterView alloc];
//
//    if (section==0) {
//        [name initWithReuseIdentifier:(NSString *)@"section1"];
//        
//    }
//    else if (section==1) [name initWithReuseIdentifier:(NSString *)@"section2"];
//    else [name initWithReuseIdentifier:(NSString *)@"section3"];
//    return name;
//}
//have some problem when try to give the section title

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
//    if (indexPath.section==0) {
//        cell.textLabel.text=self.title[indexPath.row];
//    }
//    else if(indexPath.section==1){
//        cell.textLabel.text=self.title2[indexPath.row];
//
//    }
//    else cell.textLabel.text=self.title3[indexPath.row];
    //cell.textLabel.text=self.blogPosts[indexPath.row].title; //cannot write like this, bc when we push the object into the mutablearray, we didnt declare its type
    BlogPost * blogs=self.blogPosts[indexPath.row];
    if ([blogs.thumbnail isKindOfClass:[NSString class]]) {
        NSData *imageData=[NSData dataWithContentsOfURL:blogs.returnURL];
        UIImage* image=[UIImage imageWithData:imageData];
        cell.imageView.image=image;
    }
    cell.textLabel.text=blogs.title;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"Author:%@ - %@",blogs.author,[blogs returnDate]];
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{ //tagger the touch of the post function
    if ([segue.identifier isEqualToString:@"showBlogPost"]) {
        NSIndexPath *indexPath=[self.tableView indexPathForSelectedRow];
        BlogPost *blogpost=[self.blogPosts objectAtIndex:indexPath.row];
        [segue.destinationViewController setUrl:blogpost.url]; //bc destinationviewController return id type, we cannot use .to access url property of webViewController class.
        //    webViewController * wbc=segue.destinationViewController;//second way to realize the above function
        //    wbc.url=blogpost.url;
    }//this if statement can elimate in this case, bc we only have one segue.
    
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
