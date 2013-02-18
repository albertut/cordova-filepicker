#import "CDVFilepicker.h"

@implementation CDVFilepicker

@synthesize callbackIds = _callbackIds;

- (NSMutableDictionary *)callbackIds {
    if (_callbackIds == nil) {
        _callbackIds = [[NSMutableDictionary alloc] init];
    }
    return _callbackIds;
}

- (void)pick:(CDVInvokedUrlCommand *)command
{
    [self.callbackIds setValue:command.callbackId forKey:@"pick"];
    
    FPPickerController *fpController = [[FPPickerController alloc] init];
    fpController.fpdelegate = self;
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    
    if ([options objectForKey:@"dataTypes"] != nil) {
        NSArray *dataTypes = [options objectForKey:@"dataTypes"];
        fpController.dataTypes = dataTypes;
    }
    
    if ([options objectForKey:@"sourceNames"] != nil) {
        NSArray *optSources = [options objectForKey:@"sourceNames"];
        NSMutableArray *sourceNames = [[NSMutableArray alloc] initWithObjects:nil];

        for (NSString *source in optSources) {
            NSString *addSource = nil;
            if ([source isEqualToString:@"FPSourceCamera"])
                addSource = FPSourceCamera;
            else if ([source isEqualToString:@"FPSourceCameraRoll"])
                addSource = FPSourceCameraRoll;
            else if ([source isEqualToString:@"FPSourceDropbox"])
                addSource = FPSourceDropbox;
            else if ([source isEqualToString:@"FPSourceFacebook"])
                addSource = FPSourceFacebook;
            else if ([source isEqualToString:@"FPSourceFlickr"])
                addSource = FPSourceFlickr;
            else if ([source isEqualToString:@"FPSourceGithub"])
                addSource = FPSourceGithub;
            else if ([source isEqualToString:@"FPSourceGmail"])
                addSource = FPSourceGmail;
            else if ([source isEqualToString:@"FPSourceGoogleDrive"])
                addSource = FPSourceGoogleDrive;
            else if ([source isEqualToString:@"FPSourceImagesearch"])
                addSource = FPSourceImagesearch;
            else if ([source isEqualToString:@"FPSourceInstagram"])
                addSource = FPSourceInstagram;
            else if ([source isEqualToString:@"FPSourcePicasa"])
                addSource = FPSourcePicasa;
            
            if (addSource)
                [sourceNames addObject:addSource];
        }
        
        fpController.sourceNames = sourceNames;
    }
    
    if ([options objectForKey:@"allowsEditing"] != nil) {
        fpController.allowsEditing = [[options objectForKey:@"allowsEditing"] boolValue];
    }
    
    if ([options objectForKey:@"shouldUpload"] != nil) {
        fpController.shouldUpload = [[options valueForKey:@"shouldUpload"] boolValue];
    }
    
    if ([options objectForKey:@"shouldDownload"] != nil) {
        fpController.shouldDownload = [[options objectForKey:@"shouldDownload"] boolValue];
    }
    
    // Display it!
    [self.viewController presentModalViewController:fpController animated:YES];
}

- (void)save:(CDVInvokedUrlCommand *)command
{
    [self.callbackIds setValue:command.callbackId forKey:@"save"];
    
    FPSaveController *fpSave = [[FPSaveController alloc] init];
    fpSave.fpdelegate = self;
    
    NSDictionary *options = [command.arguments objectAtIndex:0];
    
    fpSave.data = [[NSData alloc] init];
    
    if ([options objectForKey:@"dataType"] != nil) {
        fpSave.dataType = [options objectForKey:@"dataType"];
    }
    
    if ([options objectForKey:@"dataExtension"] != nil) {
        fpSave.dataExtension = [[options objectForKey:@"dataExtension"] stringValue];
    }
    
    if ([options objectForKey:@"proposedFilename"] != nil) {
        fpSave.proposedFilename = [[options objectForKey:@"proposedFilename"] stringValue];
    }
    
    if ([options objectForKey:@"sourceNames"] != nil) {
        NSArray *optSources = [options objectForKey:@"sourceNames"];
        NSMutableArray *sourceNames = [[NSMutableArray alloc] initWithObjects:nil];
        
        for (NSString *source in optSources) {
            NSString *addSource = nil;
            if ([source isEqualToString:@"FPSourceCamera"])
                addSource = FPSourceCamera;
            else if ([source isEqualToString:@"FPSourceCameraRoll"])
                addSource = FPSourceCameraRoll;
            else if ([source isEqualToString:@"FPSourceDropbox"])
                addSource = FPSourceDropbox;
            else if ([source isEqualToString:@"FPSourceFacebook"])
                addSource = FPSourceFacebook;
            else if ([source isEqualToString:@"FPSourceFlickr"])
                addSource = FPSourceFlickr;
            else if ([source isEqualToString:@"FPSourceGithub"])
                addSource = FPSourceGithub;
            else if ([source isEqualToString:@"FPSourceGmail"])
                addSource = FPSourceGmail;
            else if ([source isEqualToString:@"FPSourceGoogleDrive"])
                addSource = FPSourceGoogleDrive;
            else if ([source isEqualToString:@"FPSourceImagesearch"])
                addSource = FPSourceImagesearch;
            else if ([source isEqualToString:@"FPSourceInstagram"])
                addSource = FPSourceInstagram;
            else if ([source isEqualToString:@"FPSourcePicasa"])
                addSource = FPSourcePicasa;
            
            if (addSource)
                [sourceNames addObject:addSource];
        }
        
        fpSave.sourceNames = sourceNames;
    }
    
    [self.viewController presentModalViewController:fpSave animated:YES];
}

- (void)returnPluginResult:(NSMutableDictionary *)result toCallback:(NSString *)callback withError:(BOOL)error
{
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
    if (!error) {
        [self writeJavascript:[pluginResult toSuccessCallbackString:[self.callbackIds valueForKey:callback]]];
    }
    else {
        [self writeJavascript:[pluginResult toErrorCallbackString:[self.callbackIds valueForKey:callback]]];
    }
}

#pragma mark - FPPickerControllerDelegate Methods

- (void)FPPickerController:(FPPickerController *)picker didPickMediaWithInfo:(NSDictionary *)info {
}

- (void)FPPickerController:(FPPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

    // Send result back to the javascript plugin
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:@"didFinishPickingMediaWithInfo" forKey:@"result"];
    
    // Ignoring the non-string values from the returned dictionary info
    NSArray *keys = [[NSArray alloc] initWithArray:[info allKeys]];
    for (NSString *key in keys) {
        id value = [info objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [result setObject:value forKey:key];
        }
        else if ([value isKindOfClass:[NSURL class]]) {
            [result setObject:[value absoluteString] forKey:key];
        }
    }
    
    [self returnPluginResult:result toCallback:@"pick" withError:NO];
}

- (void)FPPickerControllerDidCancel:(FPPickerController *)picker
{
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    // Send result back to the javascript plugin
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:@"didCancel" forKey:@"result"];
    
    [self returnPluginResult:result toCallback:@"pick" withError:NO];
};


#pragma mark - FPSaveControllerDelegate Methods

- (void)FPSaveControllerDidSave:(FPSaveController *)picker {
}

- (void)FPSaveController:(FPSaveController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    // Send success result back to plugin. Note that NSDictionary info is empty.
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:@"didFinishPickingMediaWithInfo" forKey:@"result"];
    
    [self returnPluginResult:result toCallback:@"save" withError:NO];
}

- (void)FPSaveControllerDidCancel:(FPSaveController *)picker {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
    // Send result back to the javascript plugin
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:@"didCancel" forKey:@"result"];
    
    [self returnPluginResult:result toCallback:@"save" withError:NO];
}

- (void)FPSaveController:(FPSaveController *)picker didError:(NSDictionary *)info {
    [self.viewController dismissViewControllerAnimated:YES completion:nil];

    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    [result setObject:@"didError" forKey:@"result"];
    
    // Ignoring the non-string values from the returned dictionary info
    NSArray *keys = [[NSArray alloc] initWithArray:[info allKeys]];
    for (NSString *key in keys) {
        id value = [info objectForKey:key];
        if ([value isKindOfClass:[NSString class]]) {
            [result setObject:value forKey:key];
        }
        else if ([value isKindOfClass:[NSURL class]]) {
            [result setObject:[value absoluteString] forKey:key];
        }
    }
    
    [self returnPluginResult:result toCallback:@"save" withError:YES];
}

@end