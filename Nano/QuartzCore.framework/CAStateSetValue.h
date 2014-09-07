/* Generated by RuntimeBrowser
   Image: /System/Library/Frameworks/QuartzCore.framework/QuartzCore
 */

@class NSString;

@interface CAStateSetValue : CAStateElement {
    NSString *_keyPath;
    id _value;
}

@property(copy) NSString * keyPath;
@property(retain) id value;

- (id)CAMLTypeForKey:(id)arg1;
- (void)apply:(id)arg1;
- (id)copyWithZone:(struct _NSZone { }*)arg1;
- (void)dealloc;
- (id)debugDescription;
- (void)encodeWithCAMLWriter:(id)arg1;
- (void)encodeWithCoder:(id)arg1;
- (void)foreachLayer:(id)arg1;
- (id)initWithCoder:(id)arg1;
- (id)keyPath;
- (BOOL)matches:(id)arg1;
- (void)setKeyPath:(id)arg1;
- (void)setValue:(id)arg1;
- (id)value;

@end
