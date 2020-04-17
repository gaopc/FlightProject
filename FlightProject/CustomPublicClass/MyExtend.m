//
//  MyExtend.m
//  MyMobileBank
//
//  Created by  on 12-2-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyExtend.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation MyExtend

@end

@implementation UIButton (constructor) 
+(UIButton *)buttonWithType:(UIButtonType)buttonType tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame backImage:(UIImage*) image target:(id)target action:(SEL)action
{

    UIButton * button = [UIButton buttonWithType:buttonType];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    return button;
}
+(UIButton *)roundedRectButtonTitle:(NSString *)title frame:(CGRect)frame target:(id)target action:(SEL)action
{
    UIButton * _button=[self buttonWithType:UIButtonTypeRoundedRect tag:0 title:title frame:frame backImage:nil target:target action:action];
    
    return _button;
}
+(UIButton *)customButtonTitle:(NSString *)title  image:(UIImage *)image frame:(CGRect)frame target:(id)target action:(SEL)action
{
    UIButton * _button=[self buttonWithType:UIButtonTypeCustom tag:0 title:title frame:frame backImage:nil target:target action:action];
    [_button setImage:image forState:UIControlStateNormal];
    
    return _button;
}
+(UIButton *)buttonWithType:(UIButtonType)buttonType  tag:(NSInteger)tag title:(NSString *)title frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:buttonType];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
//    button.layer.borderColor = [UIColor grayColor].CGColor;
//    button.layer.borderWidth = 1;
//    button.layer.cornerRadius = 3;
    return button;
}
+(UIButton *)buttonWithType:(UIButtonType)buttonType  tag:(NSInteger)tag title:(NSString *)title backImage:(UIImage *)image frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:buttonType];
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+(UIButton *) buttonWithTag:(NSInteger)tag image:(UIImage*)image title:(NSString *)title imageEdge:(UIEdgeInsets) imageEdge frame:(CGRect)frame font:(UIFont*) font  color:(UIColor*) color target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    [button setImage:image forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = font;
    button.imageEdgeInsets = imageEdge;
    button.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 0);
    return button;
}

+(UIButton *) buttonWithTag:(NSInteger)tag  frame:(CGRect)frame  target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    //button.titleEdgeInsets = UIEdgeInsetsMake(2, 0, 2, 0);
    return button;
}

@end

@implementation UILabel (constructor)

+(id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[[self class] alloc] initWithFrame:frame];
    [label setText:title];
    [label setTextAlignment:alignment];
    [label setBackgroundColor:[UIColor clearColor]];
    label.font = font;
    label.numberOfLines = 0;
   // label.highlightedTextColor = [UIColor whiteColor];
    return [label autorelease];
}
+(id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font  color:(UIColor *)color alignment:(NSTextAlignment)alignment
{
    UILabel * label = [[[self class] alloc] initWithFrame:frame];
    [label setText:title];
    [label setTextAlignment:alignment];
    [label setBackgroundColor:[UIColor clearColor]];
    label.font = font;
    label.textColor = color;
    label.numberOfLines = 0;
    //label.highlightedTextColor = [UIColor whiteColor];
    
//    CGSize suggestedSize = [title sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, FLT_MAX) lineBreakMode:UILineBreakModeWordWrap];
//    CGRect rect = frame;
//    rect.size.height = suggestedSize.height;
//    label.frame = rect;
    
    return [label autorelease];
}

+ (id)labelWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font  color:(UIColor *)color alignment:(NSTextAlignment)alignment autoSize:(BOOL)autosize
{
    UILabel * label = [[[self class] alloc] initWithFrame:frame];
    [label setText:title];
    [label setTextAlignment:alignment];
    [label setBackgroundColor:[UIColor clearColor]];
    label.font = font;
    label.textColor = color;
    label.numberOfLines = 0;
    //label.highlightedTextColor = [UIColor whiteColor];
    
    if (autosize) {
        CGSize suggestedSize = [title sizeWithFont:font constrainedToSize:CGSizeMake(frame.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
        CGRect rect = frame;
        rect.size.height = suggestedSize.height;
        label.frame = rect;
    }
    
    return [label autorelease];
}

+(id)labelWithframe:(CGRect)frame backgroundColor:(UIColor *)color
{
    UILabel * label = [[[self class] alloc] initWithFrame:frame];
    label.backgroundColor = color;
    return [label autorelease];
}
//-(void)setTitle:(NSString *)title
//{    
//    
//    NSString * str = title;
//    CGSize size = [str sizeWithFont:self.font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    self.numberOfLines = 0;
//    
//    //    self.frame=CGRectMake(0, 0, size.width, size.height);
//    CGRect newRect=self.frame;
//    newRect.size.height=size.height;
//    self.frame=newRect;
//    
//    self.text = title;
//}
@end

@implementation UITextView (constructor)  

+(id) TextViewWithFrame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color
{
    UITextView * textV = [[[self class] alloc] init];
    textV.frame = frame;
    textV.font = font;
    textV.textColor = color;
    textV.editable = NO;
    [textV setBackgroundColor:[UIColor clearColor]];
    return [textV autorelease];
}

@end

@implementation UITextField (constructor)

+(id) TextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment placeholder:(NSString*)placeholder
{
    UITextField *textF = [[[self class] alloc] init];
    textF.frame = frame;
    textF.borderStyle = borderStyle;
    textF.textAlignment = textAlignment;
    textF.placeholder = placeholder;
    return [textF autorelease];
}

+(id) TextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment placeholder:(NSString*)placeholder font:(UIFont *)font
{
    UITextField *textF = [self TextFieldWithFrame:frame borderStyle:borderStyle textAlignment:textAlignment placeholder:placeholder];
    textF.font = font;
    return textF;
}
+(id) TextFieldWithFrame:(CGRect)frame borderStyle:(UITextBorderStyle)borderStyle textAlignment:(NSTextAlignment)textAlignment placeholder:(NSString*)placeholder font:(UIFont *)font fontColor:(UIColor *)fontColor
{
    UITextField *textF = [self TextFieldWithFrame:frame borderStyle:borderStyle textAlignment:textAlignment placeholder:placeholder];
    textF.font = font;
    textF.textColor = fontColor;
    return textF;
}

@end

@implementation UIAlertView (constructor)  

+(void)alertViewWithMessage:(NSString *)massage
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:massage
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}
+(void)alertViewWithMessage:(NSString *)massage tag:(NSInteger)tag delegate:(id)delegate
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:massage
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    alert.tag = tag;
    alert.delegate = delegate;
    [alert show];
    [alert release];
}
+(void)alertViewWithMessage:(NSString *)massage :(NSString *)title
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:title
                                                   message:massage
                                                  delegate:nil
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil, nil];
    
    for (UILabel * label in [alert subviews]) {
        if ([label isKindOfClass:[UILabel class]]) {
            if (label.text.length > 20) {
                label.textAlignment = NSTextAlignmentLeft;
		label.lineBreakMode = NSLineBreakByWordWrapping; //去掉结尾... ios7不支持左对齐。为使段落的短文字居左对齐，后面加空格补位。
            }
        }
    }

    [alert show];
    [alert release];
}
+(UIAlertView *)alertViewWithMessage:(NSString *)massage addSure:(NSString *)sure addCancle:(NSString *)cancle 
{
    UIAlertView * alert=[[UIAlertView alloc] initWithTitle:nil
                                                   message:massage
                                                  delegate:nil
                                         cancelButtonTitle:cancle
                                         otherButtonTitles:sure, nil];
    [alert show];
    return [alert autorelease];

}
@end

@implementation  UIImageView  (constructor) 

+(UIImageView *)ImageViewWithFrame:(CGRect )frame
{
    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.frame = frame;
    return [imageV autorelease];
}
+(UIImageView *)ImageViewWithFrame:(CGRect )frame image:(UIImage *)image
{
    UIImageView * imageV = [[UIImageView alloc] init];
    imageV.frame = frame;
    imageV.image = image;
//    imageV.highlightedImage = image;
//    imageV.alpha = 1;
//    if (imageV.highlighted) {
//        imageV.alpha = 0.5;
//    }
    return [imageV autorelease];
}

@end

@implementation UINavigationBar (constructor)

-(void)drawRect:(CGRect)rect
{
    NSLog(@"%s",__FUNCTION__);
    [super drawRect:rect];
    UIImage * image = [UIImage imageNamed:@"navigationBar.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
} 
-(void)setNeedsDisplay1
{
    if ([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] >= 0) {
        UIImage * image = [UIImage imageNamed:@"navigationBar.png"];
        image = [image stretchableImageWithLeftCapWidth:1 topCapHeight:1];
        [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault] ;
        NSDictionary *dict = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[UIColor colorWithRed:200 green:200 blue:200 alpha:1],[UIFont boldSystemFontOfSize:20.0f],[UIColor colorWithWhite:0.0 alpha:1], nil] forKeys:[NSArray arrayWithObjects:UITextAttributeTextColor,UITextAttributeFont,UITextAttributeTextShadowColor, nil]];
        self.titleTextAttributes = dict;
    }
    [super setNeedsDisplay];
}

@end

@implementation TerminalId
static const char kKeychainUDIDItemIdentifier[]  = "com.longchangda.LCDFlight.Idenfifier";
static const char kKeyChainUDIDAccessGroup[] = "34LH4DCSSS.com.longchangda.LCDFlight";
+ (BOOL)removeUDIDFromKeyChain
{
    NSMutableDictionary *dictToDelete = [[NSMutableDictionary alloc] init];
    [dictToDelete setValue:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData *keyChainItemID = [NSData dataWithBytes:kKeychainUDIDItemIdentifier length:strlen(kKeychainUDIDItemIdentifier)];
    [dictToDelete setValue:keyChainItemID forKey:(id)kSecAttrGeneric];
    OSStatus deleteErr = noErr;
    deleteErr = SecItemDelete((CFDictionaryRef)dictToDelete);
    if (deleteErr != errSecSuccess) {
        NSLog(@"delete UUID from KeyChain Error!!! Error code:%ld", deleteErr);
        [dictToDelete release];
        return NO;
    }
    else {
        NSLog(@"delete success!!!");
    }
    [dictToDelete release];
    return YES;
}


+ (BOOL)updateUDIDInKeyChain:(NSString*)newUDID
{
    NSMutableDictionary *dictForQuery = [[NSMutableDictionary alloc] init];
    [dictForQuery setValue:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainUDIDItemIdentifier length:strlen(kKeychainUDIDItemIdentifier)];
    [dictForQuery setValue:keychainItemID forKey:(id)kSecAttrGeneric];
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(id)kSecMatchCaseInsensitive];
    [dictForQuery setValue:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    NSDictionary *queryResult = nil;
    SecItemCopyMatching((CFDictionaryRef)dictForQuery, (CFTypeRef*)&queryResult);
    if (queryResult) {
        NSMutableDictionary *dictForUpdate = [[NSMutableDictionary alloc] init];
        [dictForUpdate setValue:[NSString stringWithUTF8String:kKeychainUDIDItemIdentifier] forKey:kSecAttrDescription];
        [dictForUpdate setValue:keychainItemID forKey:(id)kSecAttrGeneric];
        const char *udidStr = [newUDID UTF8String];
        NSData *keyChainItemValue = [NSData dataWithBytes:udidStr length:strlen(udidStr)];
        [dictForUpdate setValue:keyChainItemValue forKey:(id)kSecValueData];
        OSStatus updateErr = noErr;
        // First we need the attributes from the Keychain.
        NSMutableDictionary *updateItem = [NSMutableDictionary dictionaryWithDictionary:queryResult];
        // Second we need to add the appropriate search key/values.
        // set kSecClass is Very important
        [updateItem setObject:(id)kSecClassGenericPassword forKey:(id)kSecClass];
        updateErr = SecItemUpdate((CFDictionaryRef)updateItem, (CFDictionaryRef)dictForUpdate);
        if (updateErr != errSecSuccess) {
            NSLog(@"Update KeyChain Item Error!!! Error Code:%ld", updateErr);
            [dictForQuery release];
            [dictForUpdate release];
            return NO;
        }
        else {
            NSLog(@"Update KeyChain Item Success!!!");
            [dictForQuery release];
            [dictForUpdate release];
            return YES;
        }
    }
    [dictForQuery release];
    return NO;
}
+ (BOOL)setUDIDToKeyChain:(NSString*)udid
{
    NSMutableDictionary *dictForAdd = [[NSMutableDictionary alloc] init];
    [dictForAdd setValue:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    [dictForAdd setValue:[NSString stringWithUTF8String:kKeychainUDIDItemIdentifier] forKey:kSecAttrDescription];
    
   // [dictForAdd setValue:@"UUID" forKey:(id)kSecAttrGeneric];
    
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainUDIDItemIdentifier
                                            length:strlen(kKeychainUDIDItemIdentifier)];
     [dictForAdd setObject:keychainItemID forKey:(id)kSecAttrGeneric];
      [dictForAdd setObject:@"MYOBJECT" forKey:(id)kSecAttrService];
    
    // Default attributes for keychain item.
    [dictForAdd setObject:@"" forKey:(id)kSecAttrAccount];
    [dictForAdd setObject:@"" forKey:(id)kSecAttrLabel];
    // The keychain access group attribute determines if this item can be shared
    // amongst multiple apps whose code signing entitlements contain the same keychain access group.
    NSString *accessGroup = [NSString stringWithUTF8String:kKeyChainUDIDAccessGroup];
    if (accessGroup != nil)
    {
#if TARGET_IPHONE_SIMULATOR
        // Ignore the access group if running on the iPhone simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
#else
        [dictForAdd setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
#endif
    }
    
    const char *udidStr = [udid UTF8String];
    NSData *keyChainItemValue = [NSData dataWithBytes:udidStr length:strlen(udidStr)];
    [dictForAdd setValue:keyChainItemValue forKey:(id)kSecValueData];
    
    OSStatus writeErr = noErr;
//    if ([TerminalId getUDIDFromKeyChain]) {        // there is item in keychain
//        [TerminalId updateUDIDInKeyChain:udid];
//        [dictForAdd release];
//        return YES;
//    }
//    else {          // add item to keychain
    {
        writeErr = SecItemAdd((CFDictionaryRef)dictForAdd, NULL);
        if (writeErr != errSecSuccess) {
            NSLog(@"Add KeyChain Item Error!!! Error Code:%ld", writeErr);
            [dictForAdd release];
            return NO;
        }
        else {
            NSLog(@"Add KeyChain Item Success!!!");
            [dictForAdd release];
            return YES;
        }
    }
    
    [dictForAdd release];
    return NO;
}
+ (NSString*)getUDIDFromKeyChain
{

    NSMutableDictionary *dictForQuery = [[NSMutableDictionary alloc] init];
    [dictForQuery setValue:(id)kSecClassGenericPassword forKey:(id)kSecClass];
    
    // set Attr Description for query
    [dictForQuery setValue:[NSString stringWithUTF8String:kKeychainUDIDItemIdentifier]
                    forKey:kSecAttrDescription];
    
    // set Attr Identity for query
    NSData *keychainItemID = [NSData dataWithBytes:kKeychainUDIDItemIdentifier
                                            length:strlen(kKeychainUDIDItemIdentifier)];
    [dictForQuery setObject:keychainItemID forKey:(id)kSecAttrGeneric];
    [dictForQuery setObject:@"MYOBJECT" forKey:(id)kSecAttrService];
    // The keychain access group attribute determines if this item can be shared
    // amongst multiple apps whose code signing entitlements contain the same keychain access group.
    NSString *accessGroup = [NSString stringWithUTF8String:kKeyChainUDIDAccessGroup];
    if (accessGroup != nil)
    {
#if TARGET_IPHONE_SIMULATOR
        // Ignore the access group if running on the iPhone simulator.
        //
        // Apps that are built for the simulator aren't signed, so there's no keychain access group
        // for the simulator to check. This means that all apps can see all keychain items when run
        // on the simulator.
        //
        // If a SecItem contains an access group attribute, SecItemAdd and SecItemUpdate on the
        // simulator will return -25243 (errSecNoAccessForItem).
#else
        [dictForQuery setObject:accessGroup forKey:(id)kSecAttrAccessGroup];
#endif
    }
    
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(id)kSecMatchCaseInsensitive];
    [dictForQuery setValue:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    
    OSStatus queryErr   = noErr;
    NSData   *udidValue = nil;
    NSString *udid      = nil;
    queryErr = SecItemCopyMatching((CFDictionaryRef)dictForQuery, (CFTypeRef*)&udidValue);
    
    NSMutableDictionary *dict = nil;
    [dictForQuery setValue:(id)kCFBooleanTrue forKey:(id)kSecReturnAttributes];
    queryErr = SecItemCopyMatching((CFDictionaryRef)dictForQuery, (CFTypeRef*)&dict);
    
    if (queryErr == errSecItemNotFound) {
        NSLog(@"KeyChain Item: %@ not found!!!", [NSString stringWithUTF8String:kKeychainUDIDItemIdentifier]);
    }
    else if (queryErr != errSecSuccess) {
        NSLog(@"KeyChain Item query Error!!! Error code:%ld", queryErr);
    }
    if (queryErr == errSecSuccess) {
        NSLog(@"KeyChain Item: %@", udidValue);
        
        if (udidValue) {
            udid = [NSString stringWithUTF8String:udidValue.bytes];
        }
    }
    
    [dictForQuery release];
    return udid;
}
+ (NSString *) md5:(NSString *)str {
	const char *cStr = [str UTF8String];
	unsigned char result[16];
	CC_MD5( cStr, strlen(cStr), result );
	return [NSString stringWithFormat:
			@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
			result[0], result[1], result[2], result[3], 
			result[4], result[5], result[6], result[7],
			result[8], result[9], result[10], result[11],
			result[12], result[13], result[14], result[15]
			]; 
}
+(NSString*) UUID {
    //[[UIDevice currentDevice] identifierForVendor]; // 该值每次删除应用后都会生成新值出来
    // 当前方法每次删除应用后也都生成新值出来
    // 将这些值保存到系统中，系统升级也会得到相同的值，系统还原就很难保证
    /*
     //    else
     //    {
     //        CFUUIDRef puuid = CFUUIDCreate( nil );
     //        CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
     //        result = (NSString *)CFStringCreateCopy( NULL, uuidString);
     //        [self setUDIDToKeyChain:result];
     //        CFRelease(puuid);
     //        CFRelease(uuidString);
     //        return [result autorelease];
     //    }
     */
    NSString* result ;

    result = [self getUDIDFromKeyChain];
    if (result  && ![result isEqualToString:@""]) {
        return result;
    }
    NSString *sysVersion = [UIDevice currentDevice].systemVersion;
    CGFloat version = [sysVersion floatValue];
    if (version >= 7.0) {
        NSString * uuid = [[UIDevice currentDevice].identifierForVendor UUIDString];
        result =[self md5:uuid] ;
    }
    else {
        result = [self MacAddress];
    }
    [self setUDIDToKeyChain:result];
    return result;

}
+ (NSString *)MacAddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [self md5:outstring];
}
+ (NSString *)randomHex
{
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:FIRSTINALERT_UUID];
    if(uid){
        return uid;
    }

    NSString *endtmp = @"";
    NSString *addtmp = @"";
    for (int i = 0; i < 20; i ++) {
        int randNum = arc4random() % 256;
        addtmp = [self ToHex:randNum];
        endtmp = [NSString stringWithFormat:@"%@%@", endtmp, addtmp];
    }
    [[NSUserDefaults standardUserDefaults] setObject:endtmp forKey:FIRSTINALERT_UUID];
    return endtmp;
}

+ (NSString *)ToHex:(int)tmpid {
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)     {
        case 10:
            nLetterValue =@"a";
            break;
        case 11:
            nLetterValue =@"b";
            break;
        case 12:
            nLetterValue =@"c";
            break;
        case 13:
            nLetterValue =@"d";
            break;
        case 14:
            nLetterValue =@"e";
            break;
        case 15:
            nLetterValue =@"f";
            break;
        default:
            nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
    }
    switch (tmp)     {
        case 10:
            nStrat =@"a";
            break;
        case 11:
            nStrat =@"b";
            break;
        case 12:
            nStrat =@"c";
            break;
        case 13:
            nStrat =@"d";
            break;
        case 14:
            nStrat =@"e";
            break;
        case 15:
            nStrat =@"f";
            break;
        default:
            nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

+(NSString *)TerminalId
{
    //    if ([[UIDevice currentDevice] respondsToSelector:@selector(uniqueIdentifier)]) {
    //        uid = [NSString stringWithString:[[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)]];
    //    }
    //    if (!uid) {
    //        uid = [self UUID];
    //    }
    //    if (!uid) {
    //        uid = [self MacAddress];
    //    }
    //    if (!uid) {
    //        uid = [self randomHex];
    //    }
    
    NSString *uid=nil;
//    if ([MyVersion isEqualToString:@"3.4"]) {
//        if ([[UIDevice currentDevice] respondsToSelector:@selector(uniqueIdentifier)]) {
//            uid = [NSString stringWithString:[[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)]];
//        }
//        if (!uid) {
//            uid = [self randomHex];
//        }
//        uid = [NSString stringWithFormat:@"%@-%@",uid,[self MacAddress]];
//    }
//    else
    {
//        uid = [self MacAddress];
//        if (!uid) {
//            uid = [self randomHex];
//        }
        uid = [self UUID];
        if (!uid) {
            uid = [self randomHex];
        }
    }
    NSLog(@"%@",uid);//B7C9A9673A355125EC0F0A86F6FF237E
                                     //8A6A742F-8AFB-4B0E-A247-9085CFE7BEFD
                                     //88A15C1D-E2CF-477B-871D-67925CB58026
                                     //DF3ECDE9F5EE6089FF2802FCA3B98C9F
    NSString *huid = [NSString stringWithFormat:@"%@;%@%@", uid, channelNo,@"phone001"];
    NSString *hd = [NSString stringWithFormat:@"%@;%@:%@", uid, channelNo,[self md5:huid]];
    return hd;
}

@end

@implementation UIView (constructorAnimation)
-(void) insertSubview: (UIView  *)view atIndex:(NSInteger)index animated : (BOOL)animated
{
    if (animated) {
        CGRect originalRect = view.frame;
        
        CGRect afterRect = view.frame;
        afterRect.origin.y += afterRect.size.height;
        view.frame = afterRect;
        [self insertSubview:view atIndex:index];
        /*
         添加动画效果
         */
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5f];
        [view setFrame:originalRect];
        [UIView commitAnimations];
    }
    else
    {
        [self insertSubview:view atIndex:index];
    }

}

-(void) addSubview: (UIView  *)view animated : (BOOL)animated
{
    if (animated) {
        CGRect originalRect = view.frame;
        
        CGRect afterRect = view.frame;
        afterRect.origin.y -= afterRect.size.height;
        view.frame = afterRect;
        [self addSubview:view];
        /*
         添加动画效果
         */
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.7f];
        [view setFrame:originalRect];
        [UIView commitAnimations];
    }
    else
    {
        [self addSubview:view];
    }
    
}
-(void) removeFromSuperviewWithAnimated : (BOOL) animated;
{
    if (animated) {
        /*
         添加动画效果
         */
        CGRect afterRect = self.frame;
        afterRect.origin.y += afterRect.size.height;
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.7f];
        [UIView setAnimationDidStopSelector:@selector(removeFromSuperview)];
         self.frame = afterRect;
        [UIView commitAnimations];

    }
    else
    {
        [self removeFromSuperview];
    }
    
}


@end

@implementation UISubLabel

-(void)setText:(NSString *)text
{
    if ([text isKindOfClass:[NSNull class]]) {
        text = @"";
    }
    else
    {
//        NSString * tempText = [text lowercaseString];
//        if ([tempText rangeOfString:@"null"].length==4) {
//            text = @"";
//        }
        text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"null" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"<NULL>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"NULL" withString:@""];
    }
    [super setText:text];
}

@end

@implementation UISubTextField
//- (CGRect)borderRectForBounds:(CGRect)bounds
//{
//    [super textRectForBounds:bounds];
//    if (self.background) {
//        return CGRectMake(10, 0, bounds.size.width-20, bounds.size.height);
//    }
//    return bounds;
//}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    [super textRectForBounds:bounds];
    if (self.background) {
        return CGRectMake(10, 0, bounds.size.width-20, bounds.size.height);
    }
    return bounds;
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    [super placeholderRectForBounds:bounds];
    if (self.background) {
        return CGRectMake(10, 0, bounds.size.width-20, bounds.size.height);
    }
    return bounds;
}
- (CGRect)rightViewRectForBounds:(CGRect)bounds
{
    [super rightViewRectForBounds:bounds];
    if (self.background) {
        return CGRectMake(bounds.size.width-15, (bounds.size.height-10)/2, 7, 10);
    }
    return bounds;
}
-(void)setText:(NSString *)text
{
    if ([text isKindOfClass:[NSNull class]]) {
        text = @"";
    }
    else
    {
//        NSString * tempText = [text lowercaseString];
//        if ([tempText rangeOfString:@"null"].length==4) {
//            text = @"";
//        }
        text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"null" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"<NULL>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"NULL" withString:@""];
    }
    [super setText:text];
}

@end

@implementation UISubTextView

-(void)setText:(NSString *)text
{
    if ([text isKindOfClass:[NSNull class]]) {
        text = @"";
    }
    else
    {
//        NSString * tempText = [text lowercaseString];
//        if ([tempText rangeOfString:@"null"].length==4) {
//            text = @"";
//        }
        text = [text stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"null" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"<NULL>" withString:@""];
        text = [text stringByReplacingOccurrencesOfString:@"NULL" withString:@""];
    }
    [super setText:text];}

@end

