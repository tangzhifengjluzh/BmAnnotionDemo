//
//  RRExtraUrentPointAnnotation.h
//  RRSTCOURIER
//
//  Created by mac on 2018/12/14.
//  Copyright © 2018 YANGGQ. All rights reserved.
//

//#import <BaiduMapAPI_Map/BaiduMapAPI_Map.h>
#import "RRExtraUrgentModel.h"
/*百度地图*/
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
NS_ASSUME_NONNULL_BEGIN

@interface RRExtraUrentPointAnnotation : UIView
@property (strong, nonatomic) RRExtraUrgentModel *model;

@end

NS_ASSUME_NONNULL_END
