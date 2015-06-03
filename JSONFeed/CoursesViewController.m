//
//  CoursesViewController.m
//  JSONFeed
//
//  Created by Dennis Nguyen on 6/3/15.
//  Copyright (c) 2015 dnwin. All rights reserved.
//

#import "CoursesViewController.h"

@interface CoursesViewController ()

@property (nonatomic) NSURLSession *session; // API for network requests
@property (nonatomic, copy) NSArray *courses;
@end

@implementation CoursesViewController

#pragma mark - Controller Life Cycle
// Designated init
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Set title for nav controller
        self.navigationItem.title = @"Courses";
        
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        // Pass nil to get defaults, creates a shared NSURLSession
        // Multiple instances of URL sessions can be configured differently
        // (Required header fields, no cellular access, etc)
        _session = [NSURLSession sessionWithConfiguration:config delegate:nil delegateQueue:nil];
        
        // Fetch the data
        [self fetchFeed];
    }
    
    
    return self;
}

#pragma mark View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register table view class
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];

}

#pragma mark - URL Methods

- (void)fetchFeed
{
    NSString *requestString = @"http://bookapi.bignerdranch.com/courses.json";
    NSURL *url = [NSURL URLWithString:requestString];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDataTask *dataTask =
        [self.session dataTaskWithRequest:req completionHandler:
         ^(NSData *data, NSURLResponse *response, NSError *error) {
            // Get json data and serialize it into a NSFoundation object (Dict, array, etc)
             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             // Get array from the dictionary then save to property
             self.courses = jsonObject[@"courses"];
             
             NSLog(@"%@", self.courses);
             
             // Data is loaded on a background thread, reload the table on the main thread when done
             dispatch_async(dispatch_get_main_queue(), ^{
                 // Refreshes the data and table
                 [self.tableView reloadData];
             });

         }];
    
    // Resume task (Start the web service request)
    [dataTask resume];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.[self.courses count];
                        
    return [self.courses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // Pass the current row into the courses array and get back the dictionary
    NSDictionary *course = self.courses[indexPath.row];
    cell.textLabel.text = course[@"title"];
    
    return cell;
}



@end
