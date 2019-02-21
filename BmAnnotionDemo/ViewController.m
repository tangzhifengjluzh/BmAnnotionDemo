//
//  ViewController.m
//  BmAnnotionDemo
//
//  Created by mac on 2018/12/20.
//  Copyright © 2018 mac. All rights reserved.
//

#import "ViewController.h"

//
//  RRExtraUrgentViewController.m
//  RRSTCOURIER
//
//  Created by mac on 2018/12/6.
//  Copyright © 2018 YANGGQ. All rights reserved.
//
/*百度地图*/
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import "ViewController.h"
#import "RRExtraUrgentView.h"
#import "RRMyPointAnnotation.h"
#import "RRExtraUrgentModel.h"
@interface ViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ViewController
{
    BMKPointAnnotation* lockedScreenAnnotation;
    BMKLocationService* _locService;
    BMKMapView* _mapView;
}
//测试
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"百度地图添加，删除标注及气泡显示";

    [self initmap];
    [self initUI];
    [self initbindRAC];
}
- (void)initbindRAC
{
        [self addPointAnnotation];
}

- (void)initUI{
    self.view.backgroundColor = [UIColor whiteColor];
    [self startLocation];
}

-(void)startLocation
{
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    _mapView.zoomLevel = 18;
    _locService.delegate = self;
    _locService.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    
    //启动LocationService
    [_locService startUserLocationService];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
//    KMLog(@"heading is %@",userLocation.heading);
    _mapView.centerCoordinate = userLocation.location.coordinate;
//    self.viewModel.coordinate = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
    [_locService stopUserLocationService];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    
//    KMLog(@"heading is %@",userLocation.heading);
    _mapView.centerCoordinate = userLocation.location.coordinate;
//    self.viewModel.coordinate = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
//    [self.viewModel.getNearbyExpressComand execute:nil];
    [_locService stopUserLocationService];
}


- (void)initmap{
    //百度地图
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 88, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height )];
    //    [self.rrMapView insertSubview:_mapView belowSubview:_rrAnnotionView];
    [self.view addSubview:_mapView];
    
    //    [_mapView addSubview:_labelNoti];
    //    [_mapView addSubview:_locationimage];
    BMKLocationViewDisplayParam *displayParam = [[BMKLocationViewDisplayParam alloc]init];
    //    displayParam.isRotateAngleValid = false;//跟随态旋转角度是否生效
    displayParam.isAccuracyCircleShow = false;//精度圈是否显示
    //    displayParam.locationViewImgName= @"icon";//定位图标名称
    //    displayParam.locationViewOffsetX = 0;//定位偏移量(经度)
    //    displayParam.locationViewOffsetY = 0;//定位偏移量（纬度）
    [_mapView updateLocationViewWithParam:displayParam];
    _mapView.delegate = self;
    _mapView.showsUserLocation = YES;
    //初始化BMKLocationService
    [_mapView setZoomEnabled:YES];
    [_mapView setZoomLevel:18];
    _mapView.showMapScaleBar = YES;//比例尺
    _mapView.mapScaleBarPosition = CGPointMake(10,_mapView.frame.size.height-190);//比例尺的位置
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//定位跟随模式
    UIButton *buttonlocation = [UIButton buttonWithType:UIButtonTypeCustom];
    [buttonlocation setImage:[UIImage imageNamed:@"ic_map_location"] forState:UIControlStateNormal];
    [self.view addSubview:buttonlocation];
    buttonlocation.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5);
    buttonlocation.frame = CGRectMake(5, 500, 30, 30);
//    buttonlocation.sd_layout.leftSpaceToView(self.view, 5).bottomSpaceToView(self.viewbottom, 35).widthIs(30).heightEqualToWidth();
//    [[buttonlocation rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//
//    }];
    [buttonlocation addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
}
//刷新定位或刷新网络数据
- (void)location{

    [_locService startUserLocationService];
    [self addPointAnnotation];

}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}



//添加标注 或刷新标注
- (void)addPointAnnotation
{

    [_mapView removeAnnotations:_mapView.annotations];
    for (int i = 0; i < self.dataSource.count; i++) {
        RRExtraUrgentModel *model = self.dataSource[i];
        RRMyPointAnnotation * pointAnnotation = [[RRMyPointAnnotation alloc]init];
        CLLocationCoordinate2D coor;
        coor.latitude = [model.lat floatValue];// 39.915;
        coor.longitude = [model.lng floatValue]; //116.404;
        pointAnnotation.coordinate = coor;
        //        pointAnnotation.title = @" ";
        //        pointAnnotation.subtitle = @"此Annotation可拖拽!";
        pointAnnotation.model = model;
        //        [array addObject:pointAnnotation];
        [_mapView addAnnotation:pointAnnotation];
    }
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
        RRExtraUrgentModel *model1 = [[RRExtraUrgentModel alloc]init];
        
        model1.avatar = @"http://win2.qbt99.com/qmks/Public/userinfo/9837/images/2018-07-30/5b5f19672a919.jpg";
        model1.lat = @"22.569865";
        model1.lng = @"114.065077";
        model1.location = @"深圳市福田区梅华路";
        model1.user_name = @"小张";
        model1.user_phone = @"13726202029";
        [_dataSource addObject:model1];
        
        RRExtraUrgentModel *model2 = [[RRExtraUrgentModel alloc]init];
        model2.avatar = @"http://win2.qbt99.com/qmks/Public/userinfo/9837/images/2018-07-30/5b5f19672a919.jpg";
        model2.lat = @"22.565409006347952";
        model2.lng = @"114.06359073952271";
        model2.location = @"深圳市福田区梅华路";
        model2.user_name = @"小陈";
        model2.user_phone = @"13726202022";
        [_dataSource addObject:model2];
        int i = arc4random() % 2;
        if (i == 0) {
            RRExtraUrgentModel *model3 = [[RRExtraUrgentModel alloc]init];
            model3.avatar = @"http://win2.qbt99.com/qmks/Public/userinfo/9837/images/2018-07-30/5b5f19672a919.jpg";
            model3.lat = @"22.569021";
            model3.lng = @"114.062164";
            model3.location = @"广东省深圳市福田区红荔路6030号莲花山公园";
            model3.user_name = @"小王";
            model3.user_phone = @"13726202023";
            [_dataSource addObject:model3];
        }
    }

    
    return _dataSource;
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate



// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{

    //普通annotation
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        RRExtraUrgentView *annotationView = (RRExtraUrgentView*) [mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        //        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[RRExtraUrgentView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            if (annotation == lockedScreenAnnotation) {
                // 设置颜色
                //                annotationView.pinColor = BMKPinAnnotationColorGreen;
//                annotationView.image = kGetImage(@"");
                // 设置可拖拽
                annotationView.draggable = NO;
            } else {
                // 设置可拖拽
                annotationView.draggable = YES;
            }
            // 从天上掉下效果
            //                        annotationView.animatesDrop = YES;
        }
        //            自定义内容气泡
        //            BMKActionPaopaoView *paopao=[[BMKActionPaopaoView alloc]initWithCustomView:areaPaoView];
        //            annotationView.paopaoView=paopao;
        annotationView.model = ((RRExtraUrentPointAnnotation*)annotation).model;
        return annotationView;
    }
    return nil;
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    NSLog(@"paopaoclick");
}
//点击标注回调
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSLog(@"23423");
}

@end
