//
//  ViewController.m
//  KidozAdmobSample
//
//  Created by Ori Kam on 24/10/2018.
//  Copyright © 2018 Kidoz. All rights reserved.
//

#import "ViewController.h"
@import GoogleMobileAds;

#define BANNER_ADUNIT_ID @"ca-app-pub-5967470543517808/7349947267"
#define INTERSTITIAL_ADUNIT_ID @"ca-app-pub-5967470543517808/9897640434"
#define REWARDED_ADUNIT_ID @"ca-app-pub-5967470543517808/7581935456"

@interface ViewController () <GADInterstitialDelegate,GADBannerViewDelegate,GADRewardBasedVideoAdDelegate>

@property (weak, nonatomic) IBOutlet UITextView *logText;

@property(nonatomic, strong) GADRewardBasedVideoAd *rewarded;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(nonatomic, strong) GADBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBorder];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@synthesize logText;

-(void)setBorder{
    [[self.logText layer] setBorderColor:[[UIColor orangeColor] CGColor]];
    [[self.logText layer] setBorderWidth:2.3];
    [[self.logText layer] setCornerRadius:15];
}

-(void)logOut:(NSString*)message withUITextView:(UITextView*)textView withTimestamp:(NSString*)timestamp{
    textView.text = [textView.text stringByAppendingString:timestamp];
    textView.text = [textView.text stringByAppendingString:@" - "];
    textView.text = [textView.text stringByAppendingString:message];
    textView.text = [textView.text stringByAppendingString:@"\n"];
    NSRange bottom = NSMakeRange(logText.text.length -1, 1);
    [textView scrollRangeToVisible:bottom];
}

-(NSString*)getTimestamp{
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"HHmmssSSS"];
    NSString *timestamp = [objDateformat stringFromDate:[NSDate date]];
    return timestamp;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}



////////// Interstitial //////////
- (IBAction)loadInterstitial:(id)sender {
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:INTERSTITIAL_ADUNIT_ID];
    self.interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
    
    [self logOut:@"Load Interstitial" withUITextView:logText withTimestamp:[self getTimestamp]];

    
}

- (IBAction)showInterstitial:(id)sender {
    if(self.interstitial.isReady){
        [self.interstitial presentFromRootViewController:self];
        [self logOut:@"Show Interstitial" withUITextView:logText withTimestamp:[self getTimestamp]];
    }else
        [self logOut:@"Interstitial is not ready" withUITextView:logText withTimestamp:[self getTimestamp]];

}


- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    [self logOut:@"Interstitial Did Receive Ad" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    [self logOut:[NSString stringWithFormat:@"%@/%@",@"Interstitial Did Fail ToReceive Ad With Error", [error localizedDescription]] withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
    [self logOut:@"Interstitial Will Present Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
    [self logOut:@"Interstitial Will Dismiss Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
    
}

// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
    [self logOut:@"Interstitial Did Dismiss Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
    [self logOut:@"Interstitial Will Leave Application" withUITextView:logText withTimestamp:[self getTimestamp]];
}


////////// Rewarded //////////////
- (IBAction)loadRewarded:(id)sender {
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request] withAdUnitID:REWARDED_ADUNIT_ID];
    
    [self logOut:@"Load Rewarded" withUITextView:logText withTimestamp:[self getTimestamp]];
}


- (IBAction)showRewarded:(id)sender {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
        [self logOut:@"Show Rewarded" withUITextView:logText withTimestamp:[self getTimestamp]];
    }else{
        [self logOut:@"Rewarded is not ready" withUITextView:logText withTimestamp:[self getTimestamp]];
    }
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage = [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",reward.type,[reward.amount doubleValue]];
    NSLog(rewardMessage);
    [self logOut:rewardMessage withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdDidReceiveAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is received.");
    [self logOut:@"Reward based video ad is received." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdDidOpen:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Opened reward based video ad.");
    [self logOut:@"Opened reward based video ad." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdDidStartPlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad started playing.");
    [self logOut:@"Reward based video ad started playing." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdDidCompletePlaying:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad has completed.");
    [self logOut:@"Reward based video ad has completed." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdDidClose:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad is closed.");
    [self logOut:@"Reward based video ad is closed." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAdWillLeaveApplication:(GADRewardBasedVideoAd *)rewardBasedVideoAd {
    NSLog(@"Reward based video ad will leave application.");
    [self logOut:@"Reward based video ad will leave application." withUITextView:logText withTimestamp:[self getTimestamp]];
}

- (void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd didFailToLoadWithError:(NSError *)error {
    NSLog(@"Reward based video ad failed to load.");
    [self logOut:@"Reward based video ad failed to load." withUITextView:logText withTimestamp:[self getTimestamp]];
}


////////// Banner //////////
- (IBAction)loadBanner:(id)sender {
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    [self addBannerViewToView:self.bannerView];
    self.bannerView.adUnitID = BANNER_ADUNIT_ID;
    self.bannerView.rootViewController = self;
    self.bannerView.delegate = self;
    [self.bannerView loadRequest:[GADRequest request]];
    
    [self logOut:@"Load Banner" withUITextView:logText withTimestamp:[self getTimestamp]];

}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}


/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
    [self logOut:@"Banner adView Did Receive Ad" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
    [self logOut:@"Banner adView did Fail To Receive Ad With Error" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
    [self logOut:@"Banner adView Will Present Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
    [self logOut:@"Banner adView Will Dismiss Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
    [self logOut:@"Banner adView Did Dismiss Screen" withUITextView:logText withTimestamp:[self getTimestamp]];
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
    [self logOut:@"Banner adView WillLeave Application" withUITextView:logText withTimestamp:[self getTimestamp]];

}


@end
