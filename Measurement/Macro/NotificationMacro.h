//
//  NotificationMacro.h
//  MClinicalNursing
//
//  Created by 成勇 on 14-4-4.
//  Copyright (c) 2014年 成勇. All rights reserved.
//
//放的是通知相关的宏定义
#ifndef MClinicalNursing_NotificationMacro_h
#define MClinicalNursing_NotificationMacro_h


#define SHOWERROR                       @"密码或工号出错！"
#define SHOWNOTCONNECTED                @"网络故障！"
#define SHOWTIMEOUTERROR                @"请求超时！"
#define SHOWCANNOTCONNECTERROR          @"网络出错！"
#define SHOWLODING                      @"正在努力加载中..."
#define SHOWDEVICEDATANULL               @"没有医嘱信息!"
#define SHOWPATIENTDATANULL             @"没有患者信息"
#define SHOWDATANULL                    @"后台没有数据!"
#define SHOWDATAPATIENTNULL              @"没有患者信息!"
#define SHOWDATAADVICENULL              @"没有医嘱信息!"

//#define SHOWSUCCESS                     @"数据取到!"   //得到数据

#define SHOWFINSHED                     @"执行成功!"  //执行成功通过后台返回的iStatus值表示是否成功和失败

#define SHOWUNFINSHED                   @"执行失败!"  //执行成功通过后台返回的iStatus值表示是否成功和失败

// TODO: 医嘱执行
#define SHOWSCANERROR                  @"扫描信息错误!" 
#define SHOWWANINGINFO                  @"医嘱与患者不符"     //患者与医嘱信息不符
#define SHOWFORBIDINFO                  @"执行失败!请核对!"
#define SHOWCHECKSUCCESS                 @"核对成功!请继续！"

#define SHOWSCANCSTAFFCODE             @"请扫描工牌"
#define SHOWSCANDOCTORADVICE           @"请扫描医嘱"
#define SHOWSCANPATIENTID              @"请扫描病腕带"
#define SHOWCONTINUESCAN              @"请继续扫描"
#define SHOWDOCTORADVICEHASFINISHED    @"医嘱已执行"


//DaoTongMessageManager


#define DTDIDTESTNETWORKOK                   @"DTDidTestNetWorkOK"             //获取数据失败后

#define DTDIDTESTNETWORK                   @"DTDidTestNetWork"             //获取数据失败后
#define DTDIDGETFAILEDDATA                    @"DTDidGetFailedData"             //获取数据失败后
#define DTDIDGETCPVARIATIONDETAIL             @"DTDidGetCPVariationDetail"         //CP临床路径患者变异明细记录

#define DTDIDGETUPDATESTATUS                         @"DTDidGetUpdateStatus"                      //获取是否更新操作
#define DTDIDISLOGIN                          @"DTDidIsLogin"                      //取得用户登录信息
#define DTDIDGETALLPATIENTBRIEF               @"DTDidGetAllPatientBrief"          //获取病人简要信息 同煤矿总院请传入护理站ID 其他请传入护士ID
#define DTDIDGETPATSLIST                      @"DTDidGetPatsList"         //获取今日输液患者列表
#define DTDIDGETMZYLADVICE                      @"DTDidGetMZYLAdvice"         //根据执行单号获取患者医嘱
#define DTDIDGETMZYLOP                        @"DidGetMZYLOP"            //根据人员工号获取人员基本信息
#define DTDIDGETMZYLPATS                       @"DidGetMZYLPats"            //根据人员病历本号获取患者基本信息
#define DTDIDSETMZYLADVICE                      @"DidSetMZYLAdvice"            //执行门诊输液医嘱
#define DTDIDCHECKLOGIN                      @"DidCheckLogin"            //用户登录验证

#define DTDIDGETTPDAYRECORD                      @"DidGetTPDayRecord"            //获取体温记录主表
#define DTDIDSETTPSAVEDAYRECORD                      @"DidSetTPSaveDayRecord"            //保存体温记录主表记录
#define DTDIDGETTPDAYDETAILRECORD                      @"DidGetTPDayDetailRecord"            //获取体温明细记录主表
#define DTDIDSETTPSAVEDAYDETAIL                      @"DidSetTPSaveDayDetail"            //保存体温记录主表记录
#define DTDIDGETTPDAYDETAILBODYHEAT                      @"DidGetTPDayDetailBodyHeat"            //根据就诊ID获取获取原体温
#define DTDIDSETTPDELETEDAYDETAIL                      @"DidSetTPDeleteDayDetail"            //根据就诊ID获取获取原体温
#define DTDIDGETTPATIENTS_ALL                      @"DidGetPatients_ALL"            //获取护理站患者列表
#define DTDIDGETDICTDEPT                      @"DidGetDictDept"            //获取护理站患者列表
#define DTDIDGETTPADDDAYDETAIL                      @"DidGetTPAddDayDetail"            //添加明细记录
#define DTDIDGETADVICE                     @"DidGetAdvice"            //获取医嘱基本信息
#define DTDIDSETADVICE                     @"DidSetAdvice"            //执行医嘱基本信息

#define DTDIDSETSAVEPSRESULT                     @"DidSetSavePsResult"            //执行医嘱基本信息

#define DTDIDGETOPNURSEWORKSTATION                     @"DidGetOPNurseWorkStation"            //切换护理站




#define kIconMaxWidth 144
#define kIconMaxHeight 41
#endif
