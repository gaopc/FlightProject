//
//  DIDITaxiViewController.h
//  FlightProject
//
//  Created by 张晓婷 on 14-12-5.
//
//

#import <UIKit/UIKit.h>

@interface DIDITaxiViewController : RootViewController<UIWebViewDelegate>
{
    UIWebView *webView;
    UIActivityIndicatorView *activityIV;
}


@end
