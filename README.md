## 1.hotpot是什么？

###### hotpot是一个集成了前后端组件和实用工具类库的高性能python框架。使用hotpot可以快速进行业务开发，例如编写网站或API。帮助你快速完成开发任务，彻底告别996!



## 2.环境要求
###### python3.6+

## 3.快速开始

##### 环境准备
```shell script
1.获取源码: git clone 或从git 下载
2.安装依赖: pip3 install -r ./requirements.txt
3.执行./dev_restart.sh
4.访问 http://127.0.0.1:10001/hello 
```
 

##### 快速开发一个API
###### 1.在controller里创建一个类，继承NoAuth类，重写handle()方法（可参考controller/example.py）
```python
from controller.common import NoAuth


class Hello(NoAuth):
    def handle(self):
        return 'Hello hotpot!'
```

###### 2.添加路由 (可参考router/router.py)
```python
from controller.example import Hello

routers = {
    '/hello': Hello,
}
```
###### 3.执行执行./dev_restart.sh，访问 http://127.0.0.1:10001/hello

##### 获取GET/POST请求参数
```python
class GetParam(NoAuth):
    def handle(self):
        name = self.req('name')  #req()方法可以获取GET/POST请求中的参数，若参数不存在返回空字符串
        return 'Hello ' + name
```

##### 返回json格式的接口数据
```python
class GetParam(NoAuth):
    def handle(self):
        name = self.req('name')
        if name == '':
            return self.resp(errno=1, errmsg = 'name参数必填')
        else:
            return self.resp(data = 'Hello ' + name)
```
##### 服务端渲染
###### 1.在static/html中添加一个page.html
```html
<h1>Hello {{data.name}}</h1>
```
###### 2.添加路由，参考上述方法
###### 3.在controller里添加类
```python
class Page(NoAuth):
    def handle(self):
        name = self.req('name')   #获取请求参数
        self.data['name'] = name  #赋值到data属性中，data属性用来渲染页面
        return self.render('page.html')  #渲染static/html/page.html 页面
```
###### 3.执行执行./dev_restart.sh，访问 http://127.0.0.1:10001/page?name=小明

