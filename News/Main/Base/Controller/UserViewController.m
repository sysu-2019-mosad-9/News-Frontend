//
//  UserViewController.m
//  News
//
//  Created by tplish on 2019/12/15.
//  Copyright © 2019 Team09. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "UserViewController.h"

#import "../Model/LoginModel.h"

#import "Base/NetRequest.h"
#import "Base/ThemeManager.h"

#import "Masonry.h"



@interface UserViewController()

@property (nonatomic) Boolean isLogin;

@property (nonatomic, strong) UIView * infoPageView;
@property (nonatomic, strong) UIView * signInPageView;
@property (nonatomic, strong) UIView * signUpPageView;

@end


@implementation UserViewController

static UserViewController * instance;

+ (id)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[UserViewController alloc] init];
        }
    });
    return instance;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    if (self.isLogin){
        [self infoPageView];
    } else {
        [self signInPageView];
    }
}

- (UIView *)infoPageView{
    if (_infoPageView == nil){
        _infoPageView = [[UIView alloc] initWithFrame:self.view.frame];
        
//        UIImageView * imageView = [[UIImageView alloc] init];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        
        label.text = self.token;
        
    }
    return _infoPageView;
}

- (UIView *)signInPageView{
    if (_signInPageView == nil){
        _signInPageView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_signInPageView];
        
        UITextField * username = [[UITextField alloc] init];
        UITextField * password = [[UITextField alloc] init];
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.textContentType = UITextContentTypePassword;
        password.secureTextEntry = YES;
        
        UIImageView * usernameIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"user"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * passwordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * eyeIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"eye-close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        username.placeholder = @"用户名";
        password.placeholder = @"密码";
        username.leftView = usernameIcon;
        username.leftViewMode = UITextFieldViewModeAlways;
        password.leftView = passwordIcon;
        password.leftViewMode = UITextFieldViewModeAlways;
        password.rightView = eyeIcon;
        password.rightViewMode = UITextFieldViewModeAlways;
        password.rightView.userInteractionEnabled = YES;
        username.tintColor = UIColor.systemPinkColor;
        username.textColor = UIColor.systemPinkColor;
        password.tintColor = UIColor.systemPinkColor;
        password.textColor = UIColor.systemPinkColor;
        
        username.font = [UIFont systemFontOfSize:20];
        password.font = [UIFont systemFontOfSize:20];
        
        UIGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(blinkEye:)];
        
        objc_setAssociatedObject(tap, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(tap, @"eye", eyeIcon, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [eyeIcon addGestureRecognizer:tap];
        
        [_signInPageView addSubview:username];
        [_signInPageView addSubview:password];
        
        UIButton * signin = [[UIButton alloc] init];
        UIButton * signup = [[UIButton alloc] init];
        
        objc_setAssociatedObject(signin, @"username", username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(signin, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [signin addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
        [signup addTarget:self action:@selector(goToSignUpPageView:) forControlEvents:UIControlEventTouchUpInside];
        
        [signin setTitle:@"登陆" forState:UIControlStateNormal];
        [signup setTitle:@"还没有账号，注册一下" forState:UIControlStateNormal];
        
        signin.titleLabel.font = [UIFont systemFontOfSize:24];
        signup.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [signup setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
        signin.backgroundColor = UIColor.systemPinkColor;
        signin.layer.cornerRadius = 30;
        signin.layer.shadowColor = (__bridge CGColorRef _Nullable)([[ThemeManager shareInstance] shadowColor]);
        signin.layer.shadowRadius = 10;
        
        [_signInPageView addSubview:signin];
        [_signInPageView addSubview:signup];
        
        [@[username, password] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).multipliedBy(0.8);
            make.height.mas_equalTo(80);
        }];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view).mas_offset(-100);
        }];
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(username).offset(70);
        }];
        
        [@[usernameIcon, passwordIcon] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
        }];
        
        [signup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(password);
            make.top.mas_equalTo(password.mas_bottom);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
        
        [signin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
            make.width.mas_equalTo(self.view).multipliedBy(0.6);
            make.height.mas_equalTo(60);
        }];
    }
    return _signInPageView;
}

- (UIView *)signUpPageView{
    if (_signUpPageView == nil){
        _signUpPageView = [[UIView alloc] initWithFrame:self.view.frame];
        [self.view addSubview:_signUpPageView];
        
        UITextField * username = [[UITextField alloc] init];
        UITextField * password = [[UITextField alloc] init];
        UITextField * rePassword = [[UITextField alloc] init];
        username.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.autocapitalizationType = UITextAutocapitalizationTypeNone;
        rePassword.autocapitalizationType = UITextAutocapitalizationTypeNone;
        password.textContentType = UITextContentTypePassword;
        password.secureTextEntry = YES;
        rePassword.textContentType = UITextContentTypePassword;
        rePassword.secureTextEntry = YES;
        
        UIImageView * usernameIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"user"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * passwordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"lock"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        UIImageView * rePasswordIcon = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"key"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        
        username.placeholder = @"用户名";
        password.placeholder = @"密码";
        rePassword.placeholder = @"再次输入密码";
        username.leftView = usernameIcon;
        username.leftViewMode = UITextFieldViewModeAlways;
        password.leftView = passwordIcon;
        password.leftViewMode = UITextFieldViewModeAlways;
        rePassword.leftView = rePasswordIcon;
        rePassword.leftViewMode = UITextFieldViewModeAlways;
        username.tintColor = UIColor.systemPinkColor;
        username.textColor = UIColor.systemPinkColor;
        password.tintColor = UIColor.systemPinkColor;
        password.textColor = UIColor.systemPinkColor;
        rePassword.tintColor = UIColor.systemPinkColor;
        rePassword.textColor = UIColor.systemPinkColor;
        
        username.font = [UIFont systemFontOfSize:20];
        password.font = [UIFont systemFontOfSize:20];
        rePassword.font = [UIFont systemFontOfSize:20];
        
        [_signUpPageView addSubview:username];
        [_signUpPageView addSubview:password];
        [_signUpPageView addSubview:rePassword];
        
        UIButton * signin = [[UIButton alloc] init];
        UIButton * signup = [[UIButton alloc] init];
        
        objc_setAssociatedObject(signup, @"username", username, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(signup, @"password", password, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
        [signin addTarget:self action:@selector(goToSignInPageView:) forControlEvents:UIControlEventTouchUpInside];
        [signup addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [signin setTitle:@"已有账号，登陆一下" forState:UIControlStateNormal];
        [signup setTitle:@"注册" forState:UIControlStateNormal];
        
        signup.titleLabel.font = [UIFont systemFontOfSize:24];
        signin.titleLabel.font = [UIFont systemFontOfSize:12];
        
        [signin setTitleColor:UIColor.systemPinkColor forState:UIControlStateNormal];
        signup.backgroundColor = UIColor.systemPinkColor;
        signup.layer.cornerRadius = 30;
        signin.layer.shadowColor = (__bridge CGColorRef _Nullable)([[ThemeManager shareInstance] shadowColor]);
        signin.layer.shadowRadius = 10;
        
        [_signUpPageView addSubview:signin];
        [_signUpPageView addSubview:signup];
        
        [@[username, password, rePassword] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.width.mas_equalTo(self.view).multipliedBy(0.8);
            make.height.mas_equalTo(70);
        }];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.view).mas_offset(-100);
        }];
        [password mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(username).offset(70);
        }];
        [rePassword mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(password).offset(70);
        }];
        [@[usernameIcon, passwordIcon, rePasswordIcon] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(30);
        }];
        
        [signin mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(rePassword);
            make.top.mas_equalTo(rePassword.mas_bottom);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(30);
        }];
        
        [signup mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.centerY.mas_equalTo(self.view).multipliedBy(1.5);
            make.width.mas_equalTo(self.view).multipliedBy(0.6);
            make.height.mas_equalTo(60);
        }];
    }
    return _signUpPageView;
}

- (void)goToSignInPageView:(UIButton *)button{
    [self.signUpPageView removeFromSuperview];
    self.signUpPageView = nil;
    [self signInPageView];
}

- (void)goToSignUpPageView:(UIButton *)button{
    [self.signInPageView removeFromSuperview];
    self.signInPageView = nil;
    [self signUpPageView];
}

- (void)signIn:(UIButton *)button{
    NSString * url = [NSString string];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    [params setValue:objc_getAssociatedObject(button, @"username") forKey:@"username"];
    [params setValue:objc_getAssociatedObject(button, @"password") forKey:@"password"];
    [[NetRequest shareInstance] POST:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        LoginModel * model = [[LoginModel alloc] initWithDict:responseObject];
        self.token = model.token;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.signInPageView removeFromSuperview];
            self.signInPageView = nil;
            [self infoPageView];
        });
    } failues:^(id error) {
    }];
}

- (void)signUp:(UIButton *)button{
    NSString * url = @"http://localhost:8081/api/v1/users";
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    UITextField * username = objc_getAssociatedObject(button, @"username");
    UITextField * password = objc_getAssociatedObject(button, @"password");
    
    [params setValue:username.text forKey:@"username"];
    [params setValue:password.text forKey:@"password"];
    NSLog(@"%@",url);
    NSLog(@"%@",params);
    [[NetRequest shareInstance] POST:url params:params progress:^(id downloadProgress) {
    } success:^(id responseObject) {
        LoginModel * model = [[LoginModel alloc] initWithDict:responseObject];
        self.token = model.token;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.signUpPageView removeFromSuperview];
            self.signUpPageView = nil;
            [self infoPageView];
        });
        NSLog(@"%@",responseObject);
    } failues:^(id error) {
        NSLog(@"%@",error);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)blinkEye:(UIGestureRecognizer *)tap{
    UITextField * password = objc_getAssociatedObject(tap, @"password");
    UIImageView * imageView = objc_getAssociatedObject(tap, @"eye");
    if (password.isSecureTextEntry){
        password.secureTextEntry = NO;
        imageView.image = [[UIImage imageNamed:@"eye"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    } else {
        password.secureTextEntry = YES;
        imageView.image = [[UIImage imageNamed:@"eye-close"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
}

@end
