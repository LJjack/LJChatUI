//
//  LDFmdbProvider.h
//  platform
//
//  Created by bujiong on 16/7/2.
//  Copyright © 2016年 bujiong. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface LDFmdbProvider : NSObject

+ (instancetype)sharedInstance;

/**
 * 创建fmdb的数据库名字
 * @param dbName 在沙盒的db文件夹下创建名字对应的数据库
 */
- (void)fmdbWithDbName:(NSString *)dbName;

/**
 * 根据主键值查询
 */
- (id)queryByKey:(Class)modelClass primaryKeyValue:(NSNumber *)keyValue;

/**
 *  查询数据，并返回单个模型,根据主键排序
 *
 *  @param modelClass 模型对应的类
 *  @param sqlDict    字典 推荐使用 NSDictionaryOfVariableBindings
 *
 *  @return NSArray
 */
- (NSArray *)queryByKey:(Class)modelClass sqlDict:(nullable NSDictionary *)sqlDict;

/**
 *  查询数据，并返回多个模型
 *  @param modelClass 模型对应的类
 *  @param sortKeys 根据某几个字段排序, nil 是以主键排序
 */
- (NSArray *)queryMore:(Class)modelClass sqlDict:(nullable NSDictionary *)sqlDict sortKeys:(nullable NSArray *)sortKeys;

/**
 *  查询数据，并返回多个模型
 *
 *  @param modelClass 模型对应的类
 *  @param sql        SQL语句
 *
 *  @return NSArray
 */
- (NSArray *)queryMore:(Class)modelClass sql:(NSString *)sql;

/**
 *  查询数据，并返回单个模型
 *
 *  @param modelClass 模型对应的类
 *  @param sql        SQL语句
 *  @param args       条件
 *
 *  @return 模型
 */
- (id)querySingledModel:(Class)modelClass sql:(NSString *)sql withArgumentsInArray:(nullable NSArray *)args;

/**
 * 保存或更新数据
 * @param models 模型数组，存放一到多个模型
 */
- (NSInteger)save:(NSArray *)models;

/**
 * 根据主键删除指定模型，当deep模式开启后，目前层级只支持到最多二级。
 */
- (BOOL)deleteByKey:(Class)modelClass primaryKeyValue:(NSNumber *)keyValue;

/**
 *  根据字典和指定的模型删除表内容，当deep模式开启后，目前层级只支持到最多二级。
 *
 *  @param modelClass 模型对应的类
 *  @param sqlDict     字典 推荐使用 NSDictionaryOfVariableBindings
 *
 *  @return BOOL
 */
- (BOOL)deleteMoreModel:(Class)modelClass sqlDict:(NSDictionary *)sqlDict;

/**
 根据指定模型 删除表内所有数据

 @param modelClass 模型对应的类

 @return BOOL
 */
- (BOOL)deleteAllModel:(Class)modelClass;

/**
 * 执行sql语句
 */
- (BOOL)executeUpdate:(NSString*)sql;

/**
 * 根据模型类别获得表名
 */
- (NSString *)getTableName:(Class)modelClass;

/**
 * 获取模型对应的主键名称
 */
- (NSString *)getPrimaryKey:(Class)modelClass;

@end

/**
 *  配置数据库模型
 */
@protocol LDFmdbProvider <NSObject>
@required
/**
 * 数据库主键
 */
+ (nonnull NSString *)dbPrimaryKey;

@optional

/**
 *  外键
 */
+ (nonnull NSString *)dbForeignKey;

/**
 * 关联关系，注意实现此方法，对应的需要写外键
 */
+ (nullable NSDictionary<NSString *, Class> *)dbRelationContainerPropertyGenericClass;

/**
 * 忽略字段，不同步到表
 */
+ (nullable NSArray<NSString *> *)dbIgnoreProperty;

@end

NS_ASSUME_NONNULL_END
