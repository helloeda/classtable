//
//  LELoginViewController.m
//  ZJUTHelp
//
//  Created by Eda on 16/2/2.
//  Copyright © 2016年 Eda. All rights reserved.
//

#import "LELoginViewController.h"
#import "MBProgressHUD+MJ.h"
@interface LELoginViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userTel;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewTerm;
@property (atomic,assign) int searchYear;
@property (atomic,assign) int searchTerm;
- (IBAction)courseSearch;
- (IBAction)gradeSearch;

@end

@implementation LELoginViewController
#pragma mark - 加载控制器方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.pickerViewTerm selectRow:3 inComponent:0 animated:NO];
    self.searchYear = 2015;
    self.searchTerm = 1;
    self.title = @"更多";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - 按钮事件
- (IBAction)courseSearch {
    
    // 1.用户名
    NSString *userTelText = self.userTel.text;
    if (userTelText.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    // 2.密码
    NSString *passwordText = self.userPassword.text;
    if (passwordText.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    // 3.增加蒙板
    [MBProgressHUD showMessage:@"正在拼命查询中...."];
    [self courseHttpPost];
}


- (IBAction)gradeSearch{
    // 1.用户名
    NSString *userTelText = self.userTel.text;
    if (userTelText.length == 0) {
        [MBProgressHUD showError:@"请输入用户名"];
        return;
    }
    // 2.密码
    NSString *passwordText = self.userPassword.text;
    if (passwordText.length == 0) {
        [MBProgressHUD showError:@"请输入密码"];
        return;
    }
    // 3.增加蒙板
    [MBProgressHUD showMessage:@"正在拼命查询中...."];
     [self gradeHttpPost];
}
#pragma mark - 课表请求
-(void) courseHttpPost{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn/logon.aspx"];//不需要传递参数
    
    // 2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    
    
    //3. 设置请求体
    NSString *viewstate = @"__VIEWSTATE=dDwtMTU2MDM2OTk5Nzt0PDtsPGk8MT47PjtsPHQ8O2w8aTwzPjtpPDEzPjs%2BO2w8dDw7bDxpPDE%2BO2k8Mz47aTw1PjtpPDc%2BO2k8OT47aTwxMT47aTwxMz47aTwxNT47aTwxNz47PjtsPHQ8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZy5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47Pj47dDx0PDt0PGk8Mz47QDwtLeeUqOaIt%2Bexu%2BWeiy0tO%2BaVmeW4iDvlrabnlJ87PjtAPC0t55So5oi357G75Z6LLS075pWZ5biIO%2BWtpueUnzs%2BPjs%2BOzs%2BOz4%2BOz4%2BO2w8SW1nX0RMOz4%2Bqmizg8nuU1ebhUFzNA%2Fqu71sECk%3D";
    //        NSString *param=[NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&%@&Cbo_LX=学生&Txt_UserName=201326810619&Txt_Password=10364627&Img_DL.x=0&Img_DL.y=0",viewstate];
    //
    
    NSString *param=[NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&%@&Cbo_LX=学生&Txt_UserName=%@&Txt_Password=%@&Img_DL.x=0&Img_DL.y=0",viewstate,self.userTel.text,self.userPassword.text];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:enc];
    
    
    // 设置请求头信息
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
    
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        [MBProgressHUD hideHUD];
        NSString *logData = [[NSString alloc] initWithData:data encoding:enc];
        NSString *usernameOrPwdWrong = @"<script language=javascript>alert('登陆失败!忘记密码请到院办初始化!'); </script>";
        NSRange wrongObj=[logData rangeOfString:usernameOrPwdWrong options:NSCaseInsensitiveSearch];
        NSString *loginSuccess = @"学生密码修改";
        NSRange successObj=[logData rangeOfString:loginSuccess options:NSCaseInsensitiveSearch];
        
        if (connectionError || data == nil|| successObj.length<=0)
        { //一般请求超时就会来到这
            if(wrongObj.length>0) {
                NSString *error =@"学号密码不正确！";
                [MBProgressHUD showError:error];
            }
            else
                [MBProgressHUD showError:@"网络错误！"];
            return;
        }
        
        else {
            // 1.设置请求路径
            NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn//stdgl/cxxt/Web_Std_XQKB.aspx"];//不需要传递参数
            
            // 2.创建请求对象
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
            request.timeoutInterval=5.0;//设置请求超时为5秒
            request.HTTPMethod=@"POST";//设置请求方法
            
            
            // NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSString *viewstate = [NSString stringWithFormat: @"__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=dDw5NjExNjI1OTE7dDw7bDxpPDE%%2BOz47bDx0PDtsPGk8NT47aTw3PjtpPDk%%2BO2k8MTU%%2BO2k8MTk%%2BO2k8MjE%%2BOz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w85a2m55Sf566h55CGXD7mn6Xor6Lns7vnu59cPuWtpueUn%%2BivvuihqOafpeivojs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8cDxwPGw8VGV4dDs%%2BO2w8MjAxNS0xMi0yMiAwMjozOToyMjs%%2BPjs%%2BOzs%%2BO3Q8dDw7dDxpPDQxPjtAPDE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDEzLzIwMTQoMSk7MjAxMy8yMDE0KDIpOzIwMTQvMjAxNSgxKTsyMDE0LzIwMTUoMik7MjAxNS8yMDE2KDEpOzIwMTUvMjAxNigyKTsyMDE2LzIwMTcoMSk7MjAxNi8yMDE3KDIpOzIwMTcvMjAxOCgxKTsyMDE3LzIwMTgoMik7MjAxOC8yMDE5KDEpOzIwMTgvMjAxOSgyKTsyMDk4LzIwOTkoMSk7PjtAPDE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDEzLzIwMTQoMSk7MjAxMy8yMDE0KDIpOzIwMTQvMjAxNSgxKTsyMDE0LzIwMTUoMik7MjAxNS8yMDE2KDEpOzIwMTUvMjAxNigyKTsyMDE2LzIwMTcoMSk7MjAxNi8yMDE3KDIpOzIwMTcvMjAxOCgxKTsyMDE3LzIwMTgoMik7MjAxOC8yMDE5KDEpOzIwMTgvMjAxOSgyKTsyMDk4LzIwOTkoMSk7Pj47bDxpPDMyPjs%%2BPjs7Pjt0PHA8cDxsPFRleHQ7PjtsPOWtpueUnzrnjovnm4rmjLrnmoTor77ooajkv6Hmga87Pj47Pjs7Pjt0PEAwPHA8cDxsPFBhZ2VDb3VudDtfIUl0ZW1Db3VudDtfIURhdGFTb3VyY2VJdGVtQ291bnQ7RGF0YUtleXM7PjtsPGk8MT47aTw4PjtpPDg%%2BO2w8aTwyNzkxPjtpPDEwMjMxPjtpPDE4ODM4PjtpPDE0Mzk%%2BO2k8NTA2MD47aTw3OTY1PjtpPDY3MT47aTwxMzg2MT47Pjs%%2BPjs%%2BOzs7Ozs7Ozs7Oz47bDxpPDA%%2BOz47bDx0PDtsPGk8MT47aTwyPjtpPDM%%2BO2k8ND47aTw1PjtpPDY%%2BO2k8Nz47aTw4Pjs%%2BO2w8dDw7bDxpPDA%%2BO2k8MT47aTwyPjtpPDM%%2BO2k8ND47aTw1Pjs%%2BO2w8dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%%2BruacuuaOpeWPo%%2BaKgOacr%%2BWkp%%2BWei%%2BWunumqjOKFoDrpm7foibPpnZkgIDs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%%2FlrabpmaI7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8MTs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwy5ZGoOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPFxlOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%%2FheS%%2Fruivvjs%%2BPjs%%2BOzs%%2BOz4%%2BOz4%%2BO3Q8O2w8aTwwPjtpPDE%%2BO2k8Mj47aTwzPjtpPDQ%%2BO2k8NT47PjtsPHQ8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzmk43kvZzns7vnu5%%2FlpKflnovlrp7pqozihaA65p2O5rOiICA7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86K6h566X5py656eR5a2m5LiO5oqA5pyv5a2m6ZmiOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDE7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8MuWRqDs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDxcZTs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzlv4Xkv67or747Pj47Pjs7Pjs%%2BPjs%%2BPjt0PDtsPGk8MD47aTwxPjtpPDI%%2BO2k8Mz47aTw0PjtpPDU%%2BOz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86Ieq5Yqo5o6n5Yi25Y6f55CG4oWgOuiMg%%2BWFtOWImiAgOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOiuoeeul%%2BacuuenkeWtpuS4juaKgOacr%%2BWtpumZojs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwzLjU7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8NTY7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8MS0xMuWRqDrmmJ%%2FmnJ8yKDEwLTExKSAg5Y2a5piTQjMwM1w7MS0xNuWRqDrmmJ%%2FmnJ80KDMtNCkgIOazleWtpkExMDVcOzs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzlv4Xkv67or747Pj47Pjs7Pjs%%2BPjs%%2BPjt0PDtsPGk8MD47aTwxPjtpPDI%%2BO2k8Mz47aTw0PjtpPDU%%2BOz47bDx0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w85pWw5a2X5Zu%%2B5YOP5aSE55CG4oWgOuWImOebmyAgOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOiuoeeul%%2BacuuenkeWtpuS4juaKgOacr%%2BWtpumZojs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwyOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDMyOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDEtMTblkag65pif5pyfMigzLTQpICDms5XlraZCMjAzXDs7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86ZmQ6YCJ6K%%2B%%2BOz4%%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%%2BO2k8MT47aTwyPjtpPDM%%2BO2k8ND47aTw1Pjs%%2BO2w8dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOaTjeS9nOezu%%2Be7n%%2BWOn%%2BeQhuKFoDrmnY7ms6IgIDs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%%2FlrabpmaI7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8Mzs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw0ODs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTE25ZGoOuaYn%%2BacnzMoMTAtMTEpICDor60zMDFcOzEtOOWRqDrmmJ%%2FmnJ81KDEtMikgIOivrTUwMVw7Oz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%%2FheS%%2Fruivvjs%%2BPjs%%2BOzs%%2BOz4%%2BOz4%%2BO3Q8O2w8aTwwPjtpPDE%%2BO2k8Mj47aTwzPjtpPDQ%%2BO2k8NT47PjtsPHQ8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzlvq7mnLrmjqXlj6PmioDmnK%%2FihaA66Zu36Imz6Z2ZICA7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86K6h566X5py656eR5a2m5LiO5oqA5pyv5a2m6ZmiOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDQ7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8NjQ7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8MS0xNuWRqDrmmJ%%2FmnJ8zKDgtOSkgIOWBpUIxMDJcOzEtMTblkag65pif5pyfNSgzLTQpICDlub9CMjA0XDs7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86ZmQ6YCJ6K%%2B%%2BOz4%%2BOz47Oz47Pj47Pj47dDw7bDxpPDA%%2BO2k8MT47aTwyPjtpPDM%%2BO2k8ND47aTw1Pjs%%2BO2w8dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOi9r%%2BS7tuW3peeoi%%2BKFoDrmnY7oi7HpvpkgIDs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzorqHnrpfmnLrnp5HlrabkuI7mioDmnK%%2FlrabpmaI7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8Mzs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDw0ODs%%2BPjs%%2BOzs%%2BOz4%%2BO3Q8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDwxLTjlkag65pif5pyfMSgzLTQpICDpg4HmlodCMjAzXDsxLTE25ZGoOuaYn%%2BacnzMoMS0yKSAg5Y2a5piTQjIwNlw7Oz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOW%%2FheS%%2Fruivvjs%%2BPjs%%2BOzs%%2BOz4%%2BOz4%%2BO3Q8O2w8aTwwPjtpPDE%%2BO2k8Mj47aTwzPjtpPDQ%%2BO2k8NT47PjtsPHQ8O2w8aTwxPjs%%2BO2w8dDxwPHA8bDxUZXh0Oz47bDzkvZPogrI65Y2V6aKWICA7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w85L2T5Yab6YOoOz4%%2BOz47Oz47Pj47dDw7bDxpPDE%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPDE7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8MzI7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w8NS04OuaYn%%2BacnzMoMy0zKSDnlLDlvoTlnLrkuJznnIvlj7DkuIs7Pj47Pjs7Pjs%%2BPjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VGV4dDs%%2BO2w86ZmQ6YCJ6K%%2B%%2BOz4%%2BOz47Oz47Pj47Pj47Pj47Pj47dDxAMDxwPHA8bDxQYWdlQ291bnQ7XyFJdGVtQ291bnQ7XyFEYXRhU291cmNlSXRlbUNvdW50O0RhdGFLZXlzOz47bDxpPDA%%2BO2k8LTE%%2BO2k8LTE%%2BO2w8Pjs%%2BPjs%%2BOzs7Ozs7Ozs7Oz47Oz47Pj47Pj47Pt%%2FtfOg8dkAVkuqjdvu5foJzJQWz&Cbo_Xueqi=%d%%2F%d%%28%d%%29&Button2=%%B0%%B4%%BF%%CE%%B1%%ED%%B2%%E9%%D1%%AF",self.searchYear,self.searchYear+1,self.searchTerm];
            
            
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            //把拼接后的字符串转换为data，设置请求体
            request.HTTPBody=[viewstate dataUsingEncoding:enc];
            
            
            // 设置请求头信息
            [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
            
            
            NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                NSString *strData = [[NSString alloc] initWithData:data encoding:enc];
                //NSLog(@"%@", [self regularExp:strData]);
                NSString *home = NSHomeDirectory();
                NSString *docPath = [home stringByAppendingPathComponent:@"Documents"];
                NSString *filepath = [docPath stringByAppendingPathComponent:@"course.plist"];
                [[self regularExp:strData] writeToFile:filepath atomically:YES];
                
                //切换界面
                NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];  //主队列
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    UIStoryboard *story=[UIStoryboard  storyboardWithName:@"Main" bundle:nil];
                    UIViewController *dtView=[story  instantiateViewControllerWithIdentifier:@"root"];
                    [self presentViewController:dtView animated:NO completion:nil];
                }];
                [mainQueue addOperation:operation];
            
            }];
            [dataTask resume];


        }
    }];
    [dataTask resume];
    
}

//正则匹配
- (NSMutableArray *)regularExp:(NSString *)str
{
    //正则表达式提取HTML中课程内容
    NSMutableArray *MArrCourse = [[NSMutableArray alloc] init];
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?<=</font></td><td).*\r\n.*(?=</span>)" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSArray *matches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    int count = 1;
    for (NSTextCheckingResult *match in matches) {
        NSRange strRange = [match rangeAtIndex:0];
        
        NSString *result = [str substringWithRange:strRange];
        
      
        //补全7*12的课程
        NSRange range = [result rangeOfString:@"XQ"];
        int location = (int)range.location;
        
        int num = [[result substringWithRange:NSMakeRange(location+2,1)] intValue];
        if(count%7 != num && count%7 != 0)
        {
          
            NSString *newStr = [NSString stringWithFormat:@"><font size=\"2\">\n										<span id=\"DG_GXK__ctl12_XQ%d\">",num-1];
            [MArrCourse addObject:newStr];
            count++;
        }
        count++;
        [MArrCourse addObject:result];
      
    }
    
    //把数据保存到字典数组
    int cNo = 0;
    for (NSString *str in MArrCourse) {
        NSString *classNo = [NSString stringWithFormat:@"%d",++cNo];
        NSString *newStr = [str substringFromIndex:10];
        NSDictionary *dict = [NSDictionary dictionary];
        NSArray *array = [newStr componentsSeparatedByString:@"/"];
        NSString *classLong = [[array[0] substringToIndex:1] isEqual:@"e"] ? @"1":[array[0] substringToIndex:1];
        NSRange nameBegin = [array[0] rangeOfString:@"XQ\\w\">" options:NSRegularExpressionSearch];
        int begin = (int)nameBegin.location + 5;
        
        NSString *className = [array[0] substringFromIndex:begin];
        
        if (array.count == 4) {
            dict = @{@"classNo":classNo,@"courseName":className,@"coursePeriod":array[1],@"classRoom":array[2],@"teacher":array[3],@"classLong":classLong};
        }
        else if (array.count == 3)
        {
            dict = @{@"classNo":classNo,@"courseName":className,@"coursePeriod":array[1],@"classRoom":@"",@"teacher":array[2],@"classLong":classLong};
        }
        else{
            dict = @{@"classNo":classNo,@"courseName":@"",@"coursePeriod":@"",@"classRoom":@"",@"teacher":@"",@"classLong":classLong};
        }
        [dictArray addObject:dict];
    }
    return dictArray;
}


#pragma mark - 成绩请求
-(void) gradeHttpPost{
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    // 1.设置请求路径
    NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn/logon.aspx"];//不需要传递参数
    // 2.创建请求对象
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
    request.timeoutInterval=5.0;//设置请求超时为5秒
    request.HTTPMethod=@"POST";//设置请求方法
    //3.设置请求体
    NSString *viewstate = @"__VIEWSTATE=dDwtMTU2MDM2OTk5Nzt0PDtsPGk8MT47PjtsPHQ8O2w8aTwzPjtpPDEzPjs%2BO2w8dDw7bDxpPDE%2BO2k8Mz47aTw1PjtpPDc%2BO2k8OT47aTwxMT47aTwxMz47aTwxNT47aTwxNz47PjtsPHQ8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZy5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47dDxwPHA8bDxCYWNrSW1hZ2VVcmw7PjtsPGh0dHA6Ly93d3cueWNqdy56anV0LmVkdS5jbi8vaW1hZ2VzL2JnMS5naWY7Pj47Pjs7Pjt0PHA8cDxsPEJhY2tJbWFnZVVybDs%2BO2w8aHR0cDovL3d3dy55Y2p3LnpqdXQuZWR1LmNuLy9pbWFnZXMvYmcxLmdpZjs%2BPjs%2BOzs%2BO3Q8cDxwPGw8QmFja0ltYWdlVXJsOz47bDxodHRwOi8vd3d3Lnljancuemp1dC5lZHUuY24vL2ltYWdlcy9iZzEuZ2lmOz4%2BOz47Oz47Pj47dDx0PDt0PGk8Mz47QDwtLeeUqOaIt%2Bexu%2BWeiy0tO%2BaVmeW4iDvlrabnlJ87PjtAPC0t55So5oi357G75Z6LLS075pWZ5biIO%2BWtpueUnzs%2BPjs%2BOzs%2BOz4%2BOz4%2BO2w8SW1nX0RMOz4%2Bqmizg8nuU1ebhUFzNA%2Fqu71sECk%3D";
    NSString *param=[NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&%@&Cbo_LX=学生&Txt_UserName=%@&Txt_Password=%@&Img_DL.x=0&Img_DL.y=0",viewstate,self.userTel.text,self.userPassword.text];
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //把拼接后的字符串转换为data，设置请求体
    request.HTTPBody=[param dataUsingEncoding:enc];
    
    //设置请求头信息
    [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
        [MBProgressHUD hideHUD];
        NSString *logData = [[NSString alloc] initWithData:data encoding:enc];
        NSString *usernameOrPwdWrong = @"<script language=javascript>alert('登陆失败!忘记密码请到院办初始化!'); </script>";
        NSRange foundObj=[logData rangeOfString:usernameOrPwdWrong options:NSCaseInsensitiveSearch];
        if (connectionError || data == nil)
        { //一般请求超时就会来到这
            [MBProgressHUD showError:@"网络错误！"];
            return;
        }
        else if(foundObj.length>0) {
            NSString *error =@"学号密码不正确！";
            [MBProgressHUD showError:error];
        }
        else {
            // {"success":"登录成功"}
            // NSString *success = dict[@"success"];
            
            // [MBProgressHUD showSuccess:success];
            // NSLog(@"%@", [[NSString alloc] initWithData:data encoding:enc]);
            //第二次请求
            
            // 1.设置请求路径
            NSURL *URL=[NSURL URLWithString:@"http://www.ycjw.zjut.edu.cn//stdgl/cxxt/cjcx/Cjcx_Xsgrcj.aspx"];//不需要传递参数
            
            // 2.创建请求对象
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];//默认为get请求
            request.timeoutInterval=5.0;//设置请求超时为5秒
            request.HTTPMethod=@"POST";//设置请求方法
            
            
            // NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSString *viewstate =  [NSString stringWithFormat:@"__EVENTTARGET=&__EVENTARGUMENT=&__VIEWSTATE=dDw4Mjc4OTE1MTQ7dDw7bDxpPDE%%2BOz47bDx0PDtsPGk8NT47aTw3PjtpPDk%%2BO2k8MTM%%2BO2k8MTc%%2BO2k8MjE%%2BO2k8MzU%%2BOz47bDx0PHA8cDxsPFRleHQ7PjtsPOWtpuWPt%%2B%%2B8mjIwMTMyNjgxMDYxOTs%%2BPjs%%2BOzs%%2BO3Q8cDxwPGw8VGV4dDs%%2BO2w85aeT5ZCN77ya546L55uK5oy6Oz4%%2BOz47Oz47dDxwPHA8bDxUZXh0Oz47bDznj63nuqfvvJrorqHnrpfmnLoxMzAyOz4%%2BOz47Oz47dDx0PDt0PGk8NDM%%2BO0A8XGU777yd5omA5pyJ5a2m5pyf77ydOzE5OTkvMjAwMCgxKTsxOTk5LzIwMDAoMik7MjAwMC8yMDAxKDEpOzIwMDAvMjAwMSgyKTsyMDAxLzIwMDIoMSk7MjAwMS8yMDAyKDIpOzIwMDIvMjAwMygxKTsyMDAyLzIwMDMoMik7MjAwMy8yMDA0KDEpOzIwMDMvMjAwNCgyKTsyMDA0LzIwMDUoMSk7MjAwNC8yMDA1KDIpOzIwMDUvMjAwNigxKTsyMDA1LzIwMDYoMik7MjAwNi8yMDA3KDEpOzIwMDYvMjAwNygyKTsyMDA3LzIwMDgoMSk7MjAwNy8yMDA4KDIpOzIwMDgvMjAwOSgxKTsyMDA4LzIwMDkoMik7MjAwOS8yMDEwKDEpOzIwMDkvMjAxMCgyKTsyMDEwLzIwMTEoMSk7MjAxMC8yMDExKDIpOzIwMTEvMjAxMigxKTsyMDExLzIwMTIoMik7MjAxMi8yMDEzKDEpOzIwMTIvMjAxMygyKTsyMDk4LzIwOTkoMSk7MjAxMy8yMDE0KDEpOzIwMTMvMjAxNCgyKTsyMDE0LzIwMTUoMSk7MjAxNC8yMDE1KDIpOzIwMTUvMjAxNigxKTsyMDE1LzIwMTYoMik7MjAxNi8yMDE3KDEpOzIwMTYvMjAxNygyKTsyMDE3LzIwMTgoMSk7MjAxNy8yMDE4KDIpOzIwMTgvMjAxOSgxKTsyMDE4LzIwMTkoMik7PjtAPFxlO%%2B%%2B8neaJgOacieWtpuacn%%2B%%2B8nTsxOTk5LzIwMDAoMSk7MTk5OS8yMDAwKDIpOzIwMDAvMjAwMSgxKTsyMDAwLzIwMDEoMik7MjAwMS8yMDAyKDEpOzIwMDEvMjAwMigyKTsyMDAyLzIwMDMoMSk7MjAwMi8yMDAzKDIpOzIwMDMvMjAwNCgxKTsyMDAzLzIwMDQoMik7MjAwNC8yMDA1KDEpOzIwMDQvMjAwNSgyKTsyMDA1LzIwMDYoMSk7MjAwNS8yMDA2KDIpOzIwMDYvMjAwNygxKTsyMDA2LzIwMDcoMik7MjAwNy8yMDA4KDEpOzIwMDcvMjAwOCgyKTsyMDA4LzIwMDkoMSk7MjAwOC8yMDA5KDIpOzIwMDkvMjAxMCgxKTsyMDA5LzIwMTAoMik7MjAxMC8yMDExKDEpOzIwMTAvMjAxMSgyKTsyMDExLzIwMTIoMSk7MjAxMS8yMDEyKDIpOzIwMTIvMjAxMygxKTsyMDEyLzIwMTMoMik7MjA5OC8yMDk5KDEpOzIwMTMvMjAxNCgxKTsyMDEzLzIwMTQoMik7MjAxNC8yMDE1KDEpOzIwMTQvMjAxNSgyKTsyMDE1LzIwMTYoMSk7MjAxNS8yMDE2KDIpOzIwMTYvMjAxNygxKTsyMDE2LzIwMTcoMik7MjAxNy8yMDE4KDEpOzIwMTcvMjAxOCgyKTsyMDE4LzIwMTkoMSk7MjAxOC8yMDE5KDIpOz4%%2BO2w8aTwzNT47Pj47Oz47dDx0PDt0PGk8Mjk%%2BO0A8XGU777yd5omA5pyJ5a2m5bm077ydOzE5OTkvMjAwMDsyMDAwLzIwMDE7MjAwMS8yMDAyOzIwMDIvMjAwMzsyMDAzLzIwMDQ7MjAwNC8yMDA1OzIwMDUvMjAwNjsyMDA2LzIwMDc7MjAwNy8yMDA4OzIwMDgvMjAwOTsyMDA5LzIwMTA7MjAxMC8yMDExOzIwMTEvMjAxMjsyMDEyLzIwMTM7MjAxMy8yMDE0OzIwMTQvMjAxNTsyMDE1LzIwMTY7MjAxNi8yMDE3OzIwMTcvMjAxODsyMDE4LzIwMTk7MjAxOS8yMDIwOzIwMjAvMjAyMTsyMDIxLzIwMjI7MjAyMi8yMDIzOzIwMjMvMjAyNDsyMDI0LzIwMjU7MjA5OC8yMDk5Oz47QDxcZTvvvJ3miYDmnInlrablubTvvJ07MTk5OS8yMDAwOzIwMDAvMjAwMTsyMDAxLzIwMDI7MjAwMi8yMDAzOzIwMDMvMjAwNDsyMDA0LzIwMDU7MjAwNS8yMDA2OzIwMDYvMjAwNzsyMDA3LzIwMDg7MjAwOC8yMDA5OzIwMDkvMjAxMDsyMDEwLzIwMTE7MjAxMS8yMDEyOzIwMTIvMjAxMzsyMDEzLzIwMTQ7MjAxNC8yMDE1OzIwMTUvMjAxNjsyMDE2LzIwMTc7MjAxNy8yMDE4OzIwMTgvMjAxOTsyMDE5LzIwMjA7MjAyMC8yMDIxOzIwMjEvMjAyMjsyMDIyLzIwMjM7MjAyMy8yMDI0OzIwMjQvMjAyNTsyMDk4LzIwOTk7Pj47Pjs7Pjt0PHQ8O3Q8aTw0PjtAPO%%2B8neaJgOacieivvueoi%%2B%%2B8nTvova%%2Fku7blt6XnqIvihaA75L2T6LSo5YGl5bq36K6t57uD4oWiO%%2BiHquWKqOaOp%%2BWItuWOn%%2BeQhuKFoDs%%2BO0A877yd5omA5pyJ6K%%2B%%2B56iL77ydO%%2Bi9r%%2BS7tuW3peeoi%%2BKFoDvkvZPotKjlgaXlurforq3nu4PihaI76Ieq5Yqo5o6n5Yi25Y6f55CG4oWgOz4%%2BOz47Oz47dDxAMDw7Ozs7Ozs7Ozs7Pjs7Pjs%%2BPjs%%2BPjtsPHJidG5YcTtyYnRuWG47cmJ0blhuOz4%%2BxCXf5TlVCv7%%2BBDAREHyLiYPGsAE%%3D&1=rbtnXq&ddlXq=%d%%2F%d%%28%d%%29&ddlKc=%%A3%%BD%%CB%%F9%%D3%%D0%%BF%%CE%%B3%%CC%%A3%%BD&Button1=%%C6%%D5%%CD%%A8%%BF%%BC%%CA%%D4%%B3%%C9%%BC%%A8%%B2%%E9%%D1%%AF",self.searchYear,self.searchYear+1,self.searchTerm];
            
            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
            //把拼接后的字符串转换为data，设置请求体
            request.HTTPBody=[viewstate dataUsingEncoding:enc];
            
            // 设置请求头信息
            [request setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:33.0) Gecko/20100101 Firefox/33.0" forHTTPHeaderField:@"User-Agent"];
            
            NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *connectionError) {
                NSString *strData = [[NSString alloc] initWithData:data encoding:enc];
                
                NSString *home = NSHomeDirectory();
                NSString *docPath = [home stringByAppendingPathComponent:@"tmp"];
                NSString *filepath = [docPath stringByAppendingPathComponent:@"grade.plist"];
                [[self dataFormat:strData] writeToFile:filepath atomically:YES];
                
                //切换界面
                NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];  //主队列
                NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
                    UIStoryboard *story=[UIStoryboard  storyboardWithName:@"Main" bundle:nil];
                    LELoginViewController *SetMoreVC = [story instantiateViewControllerWithIdentifier:@"grade"];
                    [self.navigationController pushViewController:SetMoreVC animated:YES];

                    
                }];
                [mainQueue addOperation:operation];

                
            }];
            [dataTask resume];
        }
    }];
    [dataTask resume];
    
}


- (NSMutableArray *)dataFormat:(NSString *)str
{
    //正则表达式提取HTML中成绩
    NSMutableArray *MArrgrade = [[NSMutableArray alloc] init];
    NSString *pattern = @"(?<=<td><font color=\"#000066\" size=\"2\">).*(?=</font></td>)";
    NSString *SeparatedStr = @"</font></td><td><font color=\"#000066\" size=\"2\">";
    NSMutableArray *MArrOriGarde = [self regularExp:str andPattern:pattern];
    for (NSString* newStr in MArrOriGarde) {
        NSArray *array = [newStr componentsSeparatedByString:SeparatedStr];
        [MArrgrade addObject: array];
    }
    //把数据保存到字典数组
    

    NSDictionary *dict;
    NSMutableArray *dictArray = [[NSMutableArray alloc] init];
    for (NSArray *Arr in MArrgrade) {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                Arr[0],               @"courseTerm",
                Arr[1],               @"courseName",
                Arr[2],               @"properties",
                Arr[3],               @"grade",
                Arr[5],               @"credit",nil];
        [dictArray addObject:dict];
    }
    return dictArray;
}
//正则匹配
- (NSMutableArray *)regularExp:(NSString *)str andPattern:(NSString *)pattern
{
    NSMutableArray *MArrgrade = [[NSMutableArray alloc] init];
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:str options:0 range:NSMakeRange(0, [str length])];
    for (NSTextCheckingResult *match in matches) {
        NSRange strRange = [match rangeAtIndex:0];
        NSString *result = [str substringWithRange:strRange];
        [MArrgrade addObject:result];
    }
    return MArrgrade;
}

#pragma mark - PickerView的数据源

//1. pickerView的组数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 2;
}

//2. pickerView每一组的行数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
   
    int count;
    if (component == 0)
        count = 4;
    else
        count = 2;
    return count;
}

//3. 每一组每一行显示文字
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *item = [[NSString alloc] init];
    if (component == 0) {
        if (row == 0) {
            item = @"2012/2013";
        }
        else if (row == 1) {
            item = @"2013/2014";
        }
        else if (row == 2) {
            item = @"2014/2015";
        }
        else if (row == 3) {
            item = @"2015/2016";
        }
    }
    else {
        if  (row == 0) {
            item = @"第(1)学期";
        }
        else {
            item = @"第(2)学期";
        }
    }
    return item;
}

//4. pickerView的样式设置
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textColor = [UIColor grayColor];
        [pickerLabel setFont:[UIFont systemFontOfSize: 16]];
        if(component == 0)
            [pickerLabel setTextAlignment:NSTextAlignmentRight];
        else
            [pickerLabel setTextAlignment:NSTextAlignmentLeft];
            
    }
    //隐藏线条
    ((UIView *)[pickerView.subviews objectAtIndex:1]).backgroundColor = [UIColor clearColor];
    ((UIView *)[pickerView.subviews objectAtIndex:2]).backgroundColor = [UIColor clearColor];
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}
#pragma mark - PickerView的代理方法

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
    if (component == 0) {
        self.searchYear = 2012 + (int)row;
    }
    else
    {
        self.searchTerm = 1 + (int)row;
    }
}

@end
