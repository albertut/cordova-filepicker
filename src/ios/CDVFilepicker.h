#import <FPPicker/FPPicker.h>
#import <Cordova/CDVPlugin.h>

@interface CDVFilepicker : CDVPlugin <FPPickerDelegate, FPSaveDelegate> {

}

@property (nonatomic, retain) NSMutableDictionary *callbackIds;

- (void)pick:(CDVInvokedUrlCommand *)command;
- (void)save:(CDVInvokedUrlCommand *) command;
- (void)returnPluginResult:(NSMutableDictionary *)result toCallback:(NSString *)callback withError:(BOOL)error;
- (void)FPPickerController:(FPPickerController *)picker didPickMediaWithInfo:(NSDictionary *)info;
- (void)FPPickerController:(FPPickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)FPPickerControllerDidCancel:(FPPickerController *)picker;
- (void)FPSaveControllerDidSave:(FPSaveController *)picker;
- (void)FPSaveController:(FPSaveController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
- (void)FPSaveControllerDidCancel:(FPSaveController *)picker;
- (void)FPSaveController:(FPSaveController *)picker didError:(NSDictionary *)info;

@end