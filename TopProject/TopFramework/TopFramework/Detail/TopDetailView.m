//
//  TopDetailView.m
//  TopFramework
//
//  Created by Jacopo Pappalettera on 12/04/17.
//  Copyright © 2017 Jacopo Pappalettera. All rights reserved.
//

#import "TopDetailView.h"
@interface TopDetailView (){
    TopObject *_tObject;
}
@property (nonatomic,strong) UIImage *photo;
@end

@implementation TopDetailView

-(void)photoWithUrl:(NSURL *)photoUrl completion:(void(^)(UIImage* image))photoBlock{
    if (self.photo != nil) {
        photoBlock(self.photo);
        return;
    }
    
    dispatch_queue_t callerQueue = dispatch_get_current_queue();
    dispatch_queue_t downloadQueue = dispatch_queue_create("top.process_images", NULL);
    
    dispatch_async(downloadQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:photoUrl];
        dispatch_async(callerQueue, ^{
            self.photo = [UIImage imageWithData:imageData];
            photoBlock(self.photo);
        });
    });
}
+ (id)detailViewWithIdentifier:(NSString *)identifier {
    UINib *nib = [UINib nibWithNibName:identifier
                                bundle:[NSBundle bundleForClass:[self class]]];
    TopDetailView *view = [[nib instantiateWithOwner:self options:nil] objectAtIndex:0];
    [view updateStyle];
    return view;
}
-(void)setTmpImage:(UIImage *)tmpImage{
    _tmpImage = tmpImage;
    self.imageView.image = tmpImage;
}
-(void)updateWithTopObject:(TopObject *)topObject{
    _tObject = topObject;
    /*
     [self photoWithUrl:[NSURL URLWithString:_tObject.image]
            completion:^(UIImage *image) {
//                self.imageView.image = image;
            }];
    */
    self.titleLabel.text = _tObject.title;
    self.descriptionLabel.text = _tObject.desc;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.detailProtocol topDetailView:self askCloseWithData:nil];
}
-(void)layoutIfNeeded{
    [super layoutIfNeeded];
    [self.titleLabel layoutIfNeeded];
    [self.descriptionLabel layoutIfNeeded];
    [self.imageView layoutIfNeeded];
}
#pragma mark - style -
-(void)updateStyle{
    self.imageView.backgroundColor = [UIColor redColor];
//    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.descriptionLabel.numberOfLines = 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
