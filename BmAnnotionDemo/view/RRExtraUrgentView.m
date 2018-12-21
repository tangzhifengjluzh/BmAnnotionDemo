//
//  RRExtraUrgentView.m
//  RRSTCOURIER
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 YANGGQ. All rights reserved.
//
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0
#import "RRExtraUrgentView.h"
@interface RRExtraUrgentView()


@property (strong, nonatomic) UIImageView *imagebg;
@property (strong, nonatomic) UIImageView *imageavtar;

@end
@implementation RRExtraUrgentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initUI];
        
    }
    return self;
}
- (void)initUI{
     [self setBounds:CGRectMake(0.f, 0.f,46, 51)];
    self.imagebg = [UIImageView new];
    [self addSubview:self.imagebg];
    self.imagebg.image = [UIImage imageNamed:@"txbj_07"];// kGetImage(@"txbj_07");
    self.imagebg.sd_layout.centerYEqualToView(self).centerXEqualToView(self).widthIs(46).heightIs(51);
    
    self.imageavtar = [UIImageView new];
    [self addSubview:self.imageavtar];
    self.imageavtar.sd_layout.topSpaceToView(self, 6.5).centerXEqualToView(self).widthIs(33).heightEqualToWidth();
    self.imageavtar.sd_cornerRadiusFromHeightRatio = @0.5;
    self.imagebg.userInteractionEnabled = YES;
    self.imageavtar.userInteractionEnabled = YES;

//    [self addSubview:self.calloutView];
}

- (void)setModel:(RRExtraUrgentModel *)model
{
    _model = model;
    [self.imageavtar sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage: [UIImage imageNamed:@"touxiang_07"]];
    
    self.calloutView = [[RRExtraUrentPointAnnotation alloc]initWithFrame:CGRectMake(0, 0, 300, 80)];
    BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc]initWithCustomView:self.calloutView];
    self.calloutView.model = model;
    self.paopaoView = paopao;
}
@end
