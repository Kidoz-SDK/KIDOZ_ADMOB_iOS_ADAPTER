//
//  AppDelegate.h
//  KidozAdmobSample
//
//  Created by Ori Kam on 24/10/2018.
//  Copyright © 2018 Kidoz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@import GoogleMobileAds;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

