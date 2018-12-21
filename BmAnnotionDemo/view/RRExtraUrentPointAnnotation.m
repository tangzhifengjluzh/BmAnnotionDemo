//
//  RRExtraUrentPointAnnotation.m
//  RRSTCOURIER
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 YANGGQ. All rights reserved.
//

#import "RRExtraUrentPointAnnotation.h"
@interface RRExtraUrentPointAnnotation()
@property (strong, nonatomic) UIImageView *imageicon;
@property (strong, nonatomic) UILabel *lableaddres;
@property (strong, nonatomic) UILabel *lablename;
@property (strong, nonatomic) UILabel *lablephone;
@end
@implementation RRExtraUrentPointAnnotation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setUpView];
    }
    return self;
}

- (void)setUpView{
    self.backgroundColor = [UIColor whiteColor];
    [self setBounds:CGRectMake(0.f, 0.f,310, 115)];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    UIView *imageline = [UIView new];
    imageline.backgroundColor = [UIColor orangeColor];
    [self addSubview:imageline];
    imageline.sd_layout.topSpaceToView(self, 0).leftSpaceToView(self, 0).rightSpaceToView(self, 0).heightIs(3);
//    imageline.sd_cornerRadius = @3;
    self.imageicon = [UIImageView new];
    [self addSubview:self.imageicon];
    self.imageicon.sd_layout.centerYEqualToView(self).leftSpaceToView(self, 10).widthIs(75).heightEqualToWidth();
    self.imageicon.sd_cornerRadiusFromHeightRatio = @0.5;

    //
    UIImageView *imagename = [UIImageView new];
    [self addSubview:imagename];
    imagename.sd_layout.centerYEqualToView(self.imageicon).leftSpaceToView(self.imageicon, 19).widthIs(14).heightEqualToWidth();
    imagename.image = kGetImage(@"xingming_14");
    
    self.lablename = [UILabel new];
    [self addSubview:self.lablename];
//    self.lablename.font = kRRFont(13);

    self.lablename.sd_layout.leftSpaceToView(imagename, 6).centerYEqualToView(imagename).rightSpaceToView(self, 10).heightIs(15);
    
    //
    UIImageView *imagelocation = [UIImageView new];
    [self addSubview:imagelocation];
    imagelocation.sd_layout.bottomSpaceToView(imagename, 8).centerXEqualToView(imagename).widthIs(10.5).heightIs(14.5);
    imagelocation.image = kGetImage(@"dizhi_10");
    
    self.lableaddres = [UILabel new];
    [self addSubview:self.lableaddres];
//    self.lableaddres.font = kRRFont(13);
    self.lableaddres.sd_layout.leftSpaceToView(imagelocation, 6).centerYEqualToView(imagelocation).rightSpaceToView(self, 10).heightIs(15);
    
    //
    UIImageView *imagephone = [UIImageView new];
    [self addSubview:imagephone];
    imagephone.sd_layout.topSpaceToView(imagename, 8).centerXEqualToView(imagename).widthIs(14.5).heightEqualToWidth();
    imagephone.image = kGetImage(@"dianhua_18");
    
    self.lablephone = [UILabel new];
    [self addSubview:self.lablephone];
//    self.lablephone.font = kRRFont(13);

    self.lablephone.sd_layout.leftSpaceToView(imagephone, 6).centerYEqualToView(imagephone).rightSpaceToView(self, 10).heightIs(15);
    
}
- (void)setModel:(RRExtraUrgentModel *)model
{
    _model = model;
    [self.imageicon sd_setImageWithURL:kGetUrl(model.avatar) placeholderImage:kGetImage(@"touxiang_07")];
    self.lableaddres.text = [NSString stringWithFormat:@"楼宇：%@",model.location];
    self.lablename.text = [NSString stringWithFormat:@"姓名：%@",model.user_name];
    self.lablephone.text = [NSString stringWithFormat:@"电话：%@",model.user_phone];
}
@end
