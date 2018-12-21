//
//  RRExtraUrgentView.h
//  RRSTCOURIER
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 YANGGQ. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>

#import "RRExtraUrgentModel.h"
#import "RRExtraUrentPointAnnotation.h"
NS_ASSUME_NONNULL_BEGIN
@interface RRExtraUrgentView : BMKAnnotationView
@property (strong, nonatomic) RRExtraUrentPointAnnotation *calloutView;
@property (strong, nonatomic) RRExtraUrgentModel *model;

@end

NS_ASSUME_NONNULL_END
