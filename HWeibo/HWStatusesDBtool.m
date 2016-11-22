//
//  HWStatusesDBtool.m
//  HWeibo
//
//  Created by devzkn on 21/11/2016.
//  Copyright © 2016 DevKevin. All rights reserved.
//

#import "HWStatusesDBtool.h"
/** 负责存贮和读取数据*/
@implementation HWStatusesDBtool

/** 
 since_id	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
 max_id	false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
 count	false	int	单页返回的记录条数，最大不超过100，默认为20。
 page	false	int	返回结果的页码，默认为1。
 
 */
+ (NSArray*)statusesWithparameters:(NSDictionary*)parameters{
    NSMutableArray *tmparray = [NSMutableArray arrayWithCapacity:2];
    
    //执行SQL
    NSString *sql = [self sqlWithparameters:parameters];
   FMResultSet *set =  [_db executeQuery:sql];
    while (set.next) {
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"status"]];
        [tmparray addObject:dict];
    }
    return tmparray;
}

+ (NSString*) sqlWithparameters:(NSDictionary*)parameters{
    NSString *sql ;
    NSString *count = parameters[@"count"];
    
    NSString *page = parameters[@"page"];
    
    if (page == nil || [page isEqualToString:@""]) {
        page = @"1";
    }
    if (count == nil || [count isEqualToString:@""]) {
        page = @"20";
    }
    NSString *since_id = parameters[@"since_id"];
    NSString *max_id = parameters[@"max_id"];
    
    if (since_id && ![since_id isEqualToString:@""]) {
//        sql = [NSString stringWithFormat:@"SELECT * FROM t_status WHERE idstr > %@ ORDER BY idstr DESC LIMIT 20;", params[@"since_id"]];

        //查询则返回ID比since_id大的微博
        sql = [NSString stringWithFormat:@"select status from t_status where idstr >%@  order by idstr desc limit 20;",since_id];//asc
    }else if(max_id && ![since_id isEqualToString:@""]){
        //查询返回ID小于或等于max_id的微博
        sql = [NSString stringWithFormat:@"select status from t_status where idstr <=%@  order by idstr desc limit 20;",max_id];//asc
    }else{
        since_id = @"0";
        sql = [NSString stringWithFormat:@"select status from t_status  where idstr >%@  order by idstr desc limit 20;",since_id];//asc
    }
    return sql;

}

+ (void)initialize{
    [super initialize];
    //打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"statuses.sqlite"];//数据库文件
    NSLog(@"%@",path);
    path = @"/Users/devzkn/Desktop/statuses.sqlite";
    _db = [FMDatabase databaseWithPath:path];
//    [_db open];
    if (![_db open]) {
        NSLog(@"Could not open db.");
        return ;
    }
    //创建表
//    NSString *sql = @"Create table If Not Exists t_status (id integer Primary key , status blob Not null , idstr text Not null );";//bolb 存贮二进制
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_status (id integer PRIMARY KEY, status blob NOT NULL, idstr text NOT NULL);"];
    
//     [_db executeUpdate:sql];
    
}
static FMDatabase *_db;

+(void)savestatusesWithStatuses:(NSArray *)statuses{
    if (statuses.count <= 0) {
        return;
    }
//    [_db open];
    // 插入数据
    
    for (NSDictionary *obj in statuses) {
        //先查询
        BOOL isExistsStatus = [self isExistsStatus:obj[@"idstr"]];
        NSError *error;
        NSData *data = [NSKeyedArchiver  archivedDataWithRootObject:obj];//以2进制
        if (isExistsStatus) {
            //更新
             [_db executeUpdateWithFormat:@"update   t_status set status= %@ where idStr=%@ ;",data,obj[@"idstr"]];//不能自己使用//        [NSString stringWithFormat:(nonnull NSString *), ...] 拼写sql
        }else{
            //插入
            [_db executeUpdateWithFormat:@"INSERT  into   t_status (status , idStr) VALUES (%@,%@);",data,obj[@"idstr"]];//不能自己使用//        [NSString stringWithFormat:(nonnull NSString *), ...] 拼写sql
        }
        if (error) {
            NSLog(@"%@",error);
        }
     
    }
    [_db commit];
//    [_db close];
    
   

}

+ (BOOL)isExistsStatus:(NSString*)idstr{
  NSString   *sql = [NSString stringWithFormat:@"select * from t_status  where idstr =%@  ",idstr];
    FMResultSet *set = [_db executeQuery:sql];
    return set.next;
}

@end
