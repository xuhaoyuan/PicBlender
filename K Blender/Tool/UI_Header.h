//
//  UI_Header.h
//  DuoDian
//
//  Created by xu on 15/4/16.
//  Copyright (c) 2015年 ASOU. All rights reserved.
//

#ifndef DuoDian_Asou_cn_UI_Header_h
#define DuoDian_Asou_cn_UI_Header_h

#import <UIKit/UIKit.h>

#pragma mark -----------------------------------------------------------------------------------------------------------


#ifdef DEBUG
//#define DEVELOP_MODE 1
#endif

#define IOS_7   ([[[UIDevice currentDevice] systemVersion] intValue] == 7)
#define IOS_8   ([[[UIDevice currentDevice] systemVersion] intValue] == 8)
#define IOS_9   ([[[UIDevice currentDevice] systemVersion] intValue] >= 9)

#define H_DEVICE  [UIScreen mainScreen].bounds.size.height
#define W_DEVICE  [UIScreen mainScreen].bounds.size.width

//#define H_CONTAINER  [UIScreen mainScreen].bounds.size.height
//#define W_CONTAINER  BEST_CONTAINER_WIDTH //ContainerWidth(self)

#define BEST_CONTAINER_WIDTH (IS_IPAD? (MIN(W_DEVICE, H_DEVICE) * 528 / 768) : W_DEVICE)

//NSInteger ContainerWidth(NSObject* obj);

#define H_SCREEN  [UIScreen mainScreen].bounds.size.height
//#define W_SCREEN  [UIScreen mainScreen].bounds.size.width
#define W_SCREEN  BEST_CONTAINER_WIDTH //(ContainerWidth(self))


#define NAVBAR_H         76.0f//64.0f
#define CUSTOM_NAVBAR_H  76.0f

#define STATUS_H         20.0f
#define NAVBAR_STATUS    38.0f //  | 导航栏toolBar高度
#define TABBAR_H         49.0f
#define MINI_H           10.0f
#define NAVBAR_MAX_Y      CGRectGetMaxY(self.navigationController.navigationBar.frame)

#define IS_IPAD              (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE            (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA            ([[UIScreen mainScreen] scale] >= 2.0)


#define SCREEN_MAX_LENGTH    (MAX(W_SCREEN, H_SCREEN))
#define SCREEN_MIN_LENGTH    (MIN(W_SCREEN, H_SCREEN))

#define IS_IPHONE_4_OR_LESS  (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5          (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6          (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P         (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)



#define systemBlue              RGBA(0,118,255,100)
#define PlaceHolderColor        [UIColor colorWithRed:0.949 green:0.949 blue:0.949 alpha:1.0]
#define RGBA(r,g,b,a)           [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define RGB(r,g,b)              RGBA(r,g,b,1.0)
#define RGBA_SINGLE(color,a)    RGBA(color,color,color,a)
#define RGB_SINGLE(color)       RGB(color,color,color)
#define COLOR_R_G_B_            RGB(26,122,246)

#define TITLECOLOUR             [UIColor whiteColor]

#define BACKCOLOR               [UIColor blackColor]

#define BLUE_TEXT_COLOR              COLOR(0x017aff)

#define KEYBOARD_BUTTON_ENABLE              COLOR(0x8F8E94)

#define KEYBOARD_BUTTON_DISABLE              COLOR(0xD0D3D9)

#define GRAY_COLOR              RGB(209, 209, 209)

// CELL 线条颜色
#define CELL_SeparatorColor        RGB(217, 217, 217)
#define TABLE_BackGroundColor      RGB(247, 247, 247)


#define RectMake(x,y,w,h)       CGRectMake(x, y, w, h)


#define COLORA(inColor)         RGBA((unsigned char) (inColor >> 16), (unsigned char) (inColor >> 8), (unsigned char) (inColor), (unsigned char) (inColor >> 24) / 255.0)
#define COLOR(inColor)          RGBA((unsigned char) (inColor >> 16), (unsigned char) (inColor >> 8), (unsigned char) (inColor), 1.0)


#define PIXEL_SIZE              (1.0 / [UIScreen mainScreen].scale)


#define     IntString(value)           [NSString stringWithFormat:@"%d", value]
#define     IntegerString(value)       [NSString stringWithFormat:@"%ld", value]
#define     LongString(value)          [NSString stringWithFormat:@"%ld", value]
#define     LongLongString(value)      [NSString stringWithFormat:@"%lld", (long long)(value) ]
#define     DoubleString(value)        [NSString stringWithFormat:@"%lf", value]
#define     NumberString(number)       [NSString stringWithFormat:@"%@", number]
#define     StringFormat(format, ...)  [NSString stringWithFormat:format, __VA_ARGS__]

#define     CODE_VALUE(jsonInfo,code)   (jsonInfo && jsonInfo[@"code"] && [jsonInfo[@"code"] intValue] == code)

#define     NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define     IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define     StrIsNotEmpty(_ref)    (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && (![(_ref)isEqualToString:@""]))
//数组是否为空
#define     ArrIsNotEmpty(_ref)    (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]) && ([(_ref) count] > 0))

#define     DicSafeValue(_dic,_key)     ([[_dic allKeys]containsObject:_key] ? [_dic objectForKey:_key] : nil)


#define     ConvertNumber(_num)    [Tool conventNumberBriefly:_num]

#define     FontSize(size)          (IS_IPAD ? (size + 2) : size)

#define     templateDefaultScale   1.41f

#define     templateLocationInCacheDir   1   // 模板存储位置

#pragma mark ---------------------------------------- Log ------------------------------------------------------------


//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//重写NSLog,Debug模式下打印日志和当前行数
//#if DEBUG
//#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
//#else
//#define NSLog(FORMAT, ...) nil
//#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


#pragma mark ---------------------------------------- deviceInfo ------------------------------------------------------------



#define SystemVersion       [UIDevice currentDevice].systemVersion
#define PhoneModel          [UIDevice currentDevice].model
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define DeviceIDFV          [[[UIDevice currentDevice] identifierForVendor] UUIDString]
#define BundleVersion       [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#pragma mark ------------------------------ define ----------------------------------------------------------

#define HOMELINK @"hometime"
#define EARLYTIME @"EarlyTime"
#define LOGINTYPE   @"loginType"
#define USERINFOMODEL @"UserInfoModel" //个人信息
#define uploadDeviceInfoOnce @"uploadDeviceInfoOnce" //

#pragma mark ----------------------------------- NSNotification --------------------------------------------------------

#define LOGINSUCCESS   @"LOGINSUCCESS"
#define LOGOUT         @"LOGOUT"

#define LOGIN_NEED_EDIT_USERNAME   @"loginNeedEditUserName"

#define bind_Notification   @"bind__Notification"

#define SUBSCRIBE_ref  @"subScribe_ref"  // 添加或取消订阅后，刷新订阅列表
#define favouriteAuthorAdd(favoriteUserId,isFavorite)  @{@"favoriteUserId":favoriteUserId,@"isFavorite":[NSNumber numberWithBool:isFavorite]}


#define UPDATE_EDITOR_NAV_STATUS   @"update_edit_nav"

#define ARTICLE_FAVOURITE_CHANGE @"article_favourite_change" // 文章收藏

#define RELOAD_CONTRIBUTE_LIST  @"reload_contribute_list" //更新专题数据;

#define GET_WITHDRAW_WECHAT_AUTHID @"get_withDraw_wechat_authid"

#define send_Pay_complete_data  @"SEND_Pay_complete_data"   // 发送支付完成后的数据  (nsstring *)object 

#pragma mark -----------------------------------------------------------------------------------------------------------


#define XIAOJI_templateID  @"0a071e3a-9060-490f-86e7-d82c85012907"

#define UNTITLE_templateID  @"ceb88295-7a27-4057-84c1-f751cb9ed554"

#define MAX_ARTICLE_DES_LENGTH  500

#define USER_DEFAULT_templateID @"user_default_templateID"


#pragma mark --------------------------------------- key --------------------------------------------------------------------


#define UM_APPKEY @"5535f641e0f55ae687001b2d"

// 微信
#define WEIXIN_APPID @"wx8d01a7fcf696855c"

// 微信提现
#define WEIXIN_APPID_transfer @"wx29d43fb181362c85"

#define WEIXIN_SECRET_transfer @"f35d154f331d10bdb1992d0ab2e9084e"


// 微博
#if(DEVELOP_MODE)

    #define WEIBO_APPKEY @"3211980583"
    #define WEIBO_SECRET @"24c80aa328ce0c1eafe85aef612e02d3"
    #define WEIBO_REDIRECT_URL @"http://tapp.zi.com/zi/weibo/callback"

#else

    #define WEIBO_APPKEY @"2070403700"
    #define WEIBO_SECRET @"5a85d5a1650370e026b2b62219aec920"
    #define WEIBO_REDIRECT_URL @"http://zi.com/zi/weibo/callback"

#endif

// mob

#define MOBAPPID @"8effe0f623b8"
#define MOBSECRET @"2f795993a87b28dcc3816d90ef604f92"




#pragma mark ----------------------------------- url --------------------------------------------------------------



#define kCOMPLETE_INTERFACE(baseUrl,restUrl)  [NSString stringWithFormat:@"%@%@",baseUrl,restUrl]


#if(DEVELOP_MODE)
    #define MAINURL      @"https://tapp.zi.com/"    // 测试环境
#else
    #define MAINURL      @"https://app.zi.com/"     // 正式环境
#endif


#define URL(url)                  kCOMPLETE_INTERFACE(MAINURL, url)


//---------------------------------------------- 登录 ----------------------------------------------------


//修改个人信息_重命名状态
#define USERINFO_CHANGE_NEED_EDIT        kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/edit_user")

//判断昵称是否唯一
#define USERINFO_UNIQUE                  kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/is_name_unique")

//获取用户登录信息
#define GET_user_login_info               kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/get_user_info")

//  微信登录上传后台服务器接口
#define WEICHAT_LOGIN                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/register_wechat")

#define WEICHAT_LOGIN_FULL                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/register_wechat_full")

//  微博登录上传后台服务器接口
#define WEIBO_LOGIN                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/register_sina")

//  手机注册
#define REGISTER_                        kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/register_phone")

//  手机注册获取验证码
#define REGISTER_CODE                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/captcha/get_register")

//  手机忘记密码获取验证码
#define REGISTER_CODE_FORGET             kCOMPLETE_INTERFACE(MAINURL,@"/zi/captcha/get_forget_password")

//  手机验证码是否正确
#define REGISTER_CODE_validation         kCOMPLETE_INTERFACE(MAINURL,@"/zi/captcha/check_captcha")


//手机登陆接口
#define PHONE_LOGIN                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/login_phone")

//  更改用户密码
#define PHONE_PASSWORD                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/edit_password")

// 用户退出
#define USER_LOGOUT                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/logout")

// 手机设置
#define GET_APPSTTING_config                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/settings/configure")

//默认分类tag
#define GET_category_defaultTags                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/default_tags")

//绑定微信
#define setting_bind_wechat                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/bind_wechat")

//绑定手机
#define setting_bind_phone                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/bind_phone")

//绑定微博
#define setting_bind_weibo                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/bind_sina")

//解除绑定
#define setting_unbind                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/unbind")

//第三方绑定手机号获取验证码 OLD_PHONE 获取旧手机的验证码     NEW_PHONE 获取新手机号的验证码  BIND_PHONE绑定手机

#define setting_get_phone_captcha         kCOMPLETE_INTERFACE(MAINURL,@"/zi/captcha/get_phone_captcha")

//验证三方绑定手机号验证码
#define setting_check_phone_captcha         kCOMPLETE_INTERFACE(MAINURL,@"/zi/captcha/check_phone_captcha")


//更换手机号获取验证码
#define setting_replace_phone         kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/replace_phone")


//---------------------------------------------- 创作中心 ----------------------------------------------------

//文章的访问限制
/**
 * 文章的访问限制
 * 0 ： 正常
 * 1 :  自己可见
 */

//#define ARTICLE_self_visible              kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/self_visible")
//
//#define ARTICLE_self_unself_visible       kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/unself_visible")

#define ARTICLE_CHANGE_visible           kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/change_self_visible")

//保存文章
#define SAVE_ARTICLE                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/save_draft")

//草稿回滚
#define ROLLBACK_ARTICLE                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/roll_back")

//取模板
#define GET_TEMPLATE                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/template/get")

//取我的创作
//#define GET_MY_ARTICLE                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/creation")
#define GET_MY_CREATION_ARTICLE          kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/creation_article") // 弃用
#define GET_MY_CREATION_ARTICLE_V2       kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/creation_article_v2") // >= 2.2.3

#define GET_MY_CREATION_PICTURE          kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/creation_pic")

//获取用户文章的阅读量
#define GET_ARTICLE_READ                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/creation_article_read")

//取文章详情
#define GET_ARTICLE                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/get_app")

//删除文章
#define DELETE_ARTICLE                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/delete")

//删除草稿
#define DELETE_DRAFT                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/delete_draft")

//文章喜爱列表
//#define ARTICLE_FAVORITE_LIST            kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_article/list")

//图片喜爱列表
#define PICTURE_FAVORITE_LIST            kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_pic/list")

//作者喜爱列表
//#define USER_FAVORITE_LIST             kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_user/list")

//作者喜爱/取消喜爱
#define FAVORITE_USER                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_user/favorite")

// 排行榜阅读量
#define LIST_READING                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/rank")

// 排行榜转发量
//#define LIST_FORWORD                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/rank_share")

// 排行榜作者精品
#define LIST_RANK                        kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/rank?")

// 文章详情
#define DETAIL_ARTICLE                   kCOMPLETE_INTERFACE(MAINURL,@"/w/a/")

// 图片中心画作
#define PIC_IMAGE                        kCOMPLETE_INTERFACE(MAINURL,@"/zi/picture/list")

//#define PIC_SEARCH                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/picture/search")

//图片投稿
#define PIC_SUBMIT                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/picture/contribute")

#define PIC_EDIT                         kCOMPLETE_INTERFACE(MAINURL,@"/zi/picture/edit")

// 图片中心作者排行
//#define PIC_AUTHOR                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/best_artist")
//#define PIC_AUTHOR                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/rank_picture")

////  文章收藏列表
//#define SHOUCANG                       kCOMPLETE_INTERFACE(MAINURL,@"zi/favorites/list?")

//  文章是否收藏
#define SHOUCANG_IF                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_article/isFavorite?")


//文章喜爱/取消喜爱
#define SHOUCANG_ADD                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_article/favorite")

//  图片收藏/取消
#define PICTURE_ADD                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_pic/favorite")

//  图片是否喜爱
//#define PICTURE_IF                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_pic/isFavorite?")

// 取投稿列表
#define CONTRIBUTION_LIST                kCOMPLETE_INTERFACE(MAINURL,@"/zi/contribution/list")

// 投稿
#define CONTRIBUTION_TOPIC               kCOMPLETE_INTERFACE(MAINURL,@"/zi/contribution/topic")

// 获取文章已投稿过的专题列表
#define CONTRIBUTION_submission          kCOMPLETE_INTERFACE(MAINURL,@"/zi/contribution/submission")

// 选取图片分类
#define GET_PIC_CATEGORY                kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/pic_category")

// tag 模糊提示
#define GET_CATEGORY_TAG                kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/select")

//-------------------------------------------------搜索-------------------------------------------------

//  搜索_ 热词列表
#define SEARCH_HOTLIST                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/search/hot")

// 搜索_主页
#define SEARCH_LIST                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/search")

//搜索后  更多图片
#define SEARCH_MORE_PIC                  kCOMPLETE_INTERFACE(MAINURL,@"/zi/search/morePic")

//搜索后  更多作者
#define SEARCH_MORE_AUTHOR               kCOMPLETE_INTERFACE(MAINURL,@"/zi/search/moreUser")

//搜索后  更多文章
#define SEARCH_MORE_ARTICLE              kCOMPLETE_INTERFACE(MAINURL,@"/zi/search/moreArticles")


//-------------------------------------------------个人中心-------------------------------------------------


//取个人主页数据 文章 读者 图片数量
#define GET_USER_HOME                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/personal_user")

//#define GET_USER_CREATION                kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/personal_creation")  //   customerId  otherId   type   //   type 0 文章 1 图片

//取用户文章
#define GET_USER_ARTICLE                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/personal_creation_new") 

//自己的个人主页-个人文章
#define GET_SELF_ARTICLE                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/personal_creation_self")


//用户喜爱的文章
#define GET_USER_FAVOURITE_ARTICLE       kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_article/articles")

//个人主页 我关注的作者
#define GET_USER_FOCUS                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_user/my_collect")

//个人主页 关注我的用户
#define GET_USER_FOCUS_ME                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/favorites_user/favorite_me")


//取阅读历史
#define GET_READ_HISTORY                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/read/get_read_history")

//删除阅读历史
#define DELETE_READ_HISTORY              kCOMPLETE_INTERFACE(MAINURL,@"/zi/read/delete")

//取分类列表
//#define GET_CATEGORY                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/list")
//#define GET_CATEGORY_ALL                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/list_all")

//投稿(提交类型)
#define PUBLISH_ARTICLE                  kCOMPLETE_INTERFACE(MAINURL,@"/zi/article/publish")


//通知中心 获取通知中心list
#define NOTIFICATION_CENTER              kCOMPLETE_INTERFACE(MAINURL,@"/zi/notice/center")

//获取通知状态
#define NOTIFICATION_CENTER_GET          kCOMPLETE_INTERFACE(MAINURL,@"/zi/settings/get")


//修改通知状态
#define NOTIFICATION_CENTER_CHANGE       kCOMPLETE_INTERFACE(MAINURL,@"/zi/settings/save")


//-------------------------------------------------精品推荐-------------------------------------------------

//发现
#define GET_Find                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/recommend/topics_v2")

//精品推荐
#define GET_RECOMMENT                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/recommend") // <2.2.2 旧版发现接口

//优秀新文章
#define GOOD_ARTICLE                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/good_article/get")

//优秀新作者
#define GOOD_AUTHOR                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/good_user/get")

//热门文章列表
#define HOT_ARTICLE                      kCOMPLETE_INTERFACE(MAINURL,@"/zi/hot_article/get")

//热门作者列表
#define HOT_AUTHOR                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/hot_user/get")

//  精品推荐 热门图片
#define RECOMMEND_HOTPIC                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/hot_pic/get")

//  精品推荐取 优秀新图片
#define RECOMMEND_EXCELLENTPIC           kCOMPLETE_INTERFACE(MAINURL,@"/zi/good_pic/get")


//discovery 专题页面
#define GET_RECOMMENT_TOPIC              kCOMPLETE_INTERFACE(MAINURL,@"/zi/recommend/topics")

//discovery 专题页面详情页
#define GET_RECOMMENT_TOPIC_DETAIL       kCOMPLETE_INTERFACE(MAINURL,@"/zi/special/content")



//-------------------------------------------------统计数据-------------------------------------------------
//统计总览
#define GET_STATS                        kCOMPLETE_INTERFACE(MAINURL,@"/zi/statistics/allCountStatistic")

//统计类型详情
#define GET_STATS_DETAIL                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/statistics/countStatisticByType")

//排行
#define GET_RANK                         kCOMPLETE_INTERFACE(MAINURL,@"/zi/statistics/countRankByType")

//上传设备信息
#define UPLOAD_DEVICE                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/device")

//文章详细数据
#define GET_CONTENT_STAT                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/statistics/contentCountByRankType")

//文章来源
#define GET_ARTICLE_STAT_SOURCE          kCOMPLETE_INTERFACE(MAINURL,@"/zi/statistics/articleFromStatistic")


//-------------------------------------------------分享回调-------------------------------------------------
#define SHARE_ARTICLE_CALL               kCOMPLETE_INTERFACE(MAINURL,@"/zi/share/call_article") // 0 好友 1朋友圈 2 微博 

#define SHARE_USER_CALL                  kCOMPLETE_INTERFACE(MAINURL,@"/zi/share/call_user")

#define SHARE_TOPIC_CALL                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/share/call_topic")


//------------------------------------------------- HOME 订阅 选荐 -------------------------------------------------

#define SUBSCRBEL_HOME                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/my_subscribe")

//v2.1.2
#define SUBSCRBEL_HOME_V2                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/my_subscribe_v2")


//#define SUBSCRBEL_USER                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/my_subscribe_user")

#define HAS_SUBSCRIBE                    kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/has_subscribe")

#define SELECTION_HOME                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/selection/article/get") // 弃用
#define SELECTION_HOME_V2                kCOMPLETE_INTERFACE(MAINURL,@"/zi/selection/article/get_v2")// > 2.2.3


#define HOME_NOLOGIN                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/recommend/for_you_nologin")

//-------------------------------------------------举报-------------------------------------------------

#define REPORT_URL                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/report/add")

//-------------------------------------------------兑换码-------------------------------------------------


#define CHECK_SAFETY_TEMPLATE            kCOMPLETE_INTERFACE(MAINURL,@"/zi/template/check_safety_template")

#define GET_SAFETY_TEMPLATE              kCOMPLETE_INTERFACE(MAINURL,@"/zi/template/get_safety_template")


//-------------------------------------------------反馈-------------------------------------------------
#define FEED_BACK                        kCOMPLETE_INTERFACE(MAINURL,@"/zi/feedback")

//-------------------------------------------------评论-------------------------------------------------

#define COMMENT_ADD_NEW                  kCOMPLETE_INTERFACE(MAINURL,@"/zi/comment/addComments")

#define COMMENT_ADD_LOVE                 kCOMPLETE_INTERFACE(MAINURL,@"/zi/comment/addLove")

#define COMMENT_DELETE                   kCOMPLETE_INTERFACE(MAINURL,@"/zi/comment/delete")

#define COMMENT_LIST                     kCOMPLETE_INTERFACE(MAINURL,@"/zi/comment/list")

#define COMMENT_USER_COMMENT_LIST        kCOMPLETE_INTERFACE(MAINURL,@"/zi/comment/userCommentList")

//--------------------------------------------------------------------------------------------------

#define VIDEO_INFO                       kCOMPLETE_INTERFACE(MAINURL,@"/zi/v/getVideo")

//------------------------------------------------discover --------------------------------------------------

#define DISCOVER_CATEGORY        kCOMPLETE_INTERFACE(MAINURL,@"/zi/category/tags")


//----------------------------------------------支付----------------------------------------------------


#define PAY        kCOMPLETE_INTERFACE(MAINURL,@"/zi/pingpay/reward")

// 我的钱包 时间
#define MyWallet_timeList   kCOMPLETE_INTERFACE(MAINURL,@"/zi/pingpay/my_pay_time")

// 我的钱包 文章
#define MyWallet_articleList   kCOMPLETE_INTERFACE(MAINURL,@"/zi/pingpay/my_pay_article")

// 打赏记录
#define MyWallet_my_pay_list   kCOMPLETE_INTERFACE(MAINURL,@"/zi/pingpay/my_pay_list")


// 提现
#define MyWallet_ping_transfer   kCOMPLETE_INTERFACE(MAINURL,@"/zi/ping_transfer")

// 金额汇总
#define MyWallet_ping_total   kCOMPLETE_INTERFACE(MAINURL,@"/zi/ping_transfer/total")

// 提现记录
#define MyWallet_ping_transfer_list  kCOMPLETE_INTERFACE(MAINURL,@"/zi/ping_transfer/list")

//单篇文章打赏list
#define MyWallet_paylist_by_id     kCOMPLETE_INTERFACE(MAINURL,@"/zi/pingpay/paylist_by_id")

//从服务器获取支付Openid
#define PAY_zi_user_transfer     kCOMPLETE_INTERFACE(MAINURL,@"/zi/user/transfer")

//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------





#ifdef DEVELOP_MODE
    #define JS_CODE_METADATA_URL            @"https://tweb.zi.com"
#else
    #define JS_CODE_METADATA_URL            @"https://zi.com"
#endif









//#define SHARE_USER_CALL               kCOMPLETE_INTERFACE(MAINURL,@"/zi/share/call_user")
//
//#define SHARE_TOPIC_CALL               kCOMPLETE_INTERFACE(MAINURL,@"/zi/share/call_topic")



////  公众号收藏列表
//#define PUBLIC_COLLECT_LIST       kCOMPLETE_INTERFACE(MAINURL,@"zi/favorites_ac/list?")
//
////  公众号按照分类id查询list
//#define PUBLIC_ID_LIST            kCOMPLETE_INTERFACE(MAINURL,@"zi/accounts/getAccountsByt?")
//
////  新关注公众号后首页数据刷新
//#define HOME_PUB_LIST_RE          kCOMPLETE_INTERFACE(MAINURL,@"zi/zi_info/acinfo_n?")
//
////  获取公众号类别列表
//#define PUBLIC_CLASS_LIST         kCOMPLETE_INTERFACE(MAINURL,@"zi/tp/act?")
//

//
////  微信回调接口
//#define WEHUIDIAO                 kCOMPLETE_INTERFACE(MAINURL,@"zi/zi_info/share_back?")
//
////  关于我们
//#define ABOUTUS                   kCOMPLETE_INTERFACE(MAINURL,@"about.html?")
//
////  投诉建议
//#define ADVICE                   kCOMPLETE_INTERFACE(MAINURL,@"feedback.html?")
//
//// choose
//#define CHOOSE      kCOMPLETE_INTERFACE(MAINURL,@"guide.html?")
//
////  分类公众号下 推荐文章列表
//#define RECOMMEND   kCOMPLETE_INTERFACE(MAINURL,@"zi/zi_info/list?")
//
//// 获取开屏页头像信息
//#define FRIENDICON   kCOMPLETE_INTERFACE(MAINURL,@"zi/zi_info/friend_read?")





//
//  defines.h
//  TestWebView
//
//  Created by Mkoo on 15/12/14.
//  Copyright © 2015年 zlhj. All rights reserved.
//

//-------------------------------------------------事件定义-------------------------------------------------

#define EVENT_PICTURE_UPDATE  @"picture.update"

#define EVENT_DRAFT_UPDATE  @"draft.update"

#define EVENT_PUBLISH_ARTICLE_UPDATE  @"article.update"

#define EVENT_TEMPLATE_UPDATE  @"template.update"

#define EVENT_TEMPLATE_DOWNLOADING  @"template.downloading"

#define EVENT_EDITOR_CONTENT_UPDATE  @"editor.content.update"

#define EVENT_ARTICLE_SAVESTATUS_UPDATE  @"article.savestate.update"

#define EVENT_HAS_NEW_SUBSCRIBE  @"subscribe.update"

#define EVENT_FAV_OR_COMMENT_CHANGE @"article.fav.update"

#define EVENT_NETWORK_CONNECTED @"networkconnected"

#endif
