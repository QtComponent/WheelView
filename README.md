# QML自定义滚动选择条
在PathView控件基础上加入滚动选择条，滚动选择条在这基础上加入Key-Value的做法，key为显示内容，value为实际内容，这样可以避免内容上的转换。  
<p align="center">
  <img src="https://github.com/QtComponent/WheelView/blob/master/Resource/WheelViewDemo.gif?raw=true" alt="">
  <p align="center"><em>WheelView</em></p>
</p>

# 使用示例
```qml
Row {
    anchors.centerIn: parent
    spacing: 50

    WheelView {
        width: 100; height: 400
        model: [{ display: "0", value: 0 },
            { display: "1", value: 1 },
            { display: "2", value: 2 },
            { display: "3", value: 3 },
            { display: "4", value: 4 },
            { display: "5", value: 5 },
            { display: "6", value: 6 },
            { display: "7", value: 7 },
            { display: "8", value: 8 },
            { display: "9", value: 9 }]
        value: 1

        pathItemCount: 5
        displayFontSize: 70
    }

    WheelView {
        width: 100; height: 400
        model: {
            var list = [];
            for (var i = 0; i < 10; i++)
                list.push({ display: i, value: i });
            return list;
        }
        value: 1

        pathItemCount: 5
        displayFontSize: 70
    }
}
```

# 注意
* model这里提供了两种生成的方式;
* 如需要再次定制则在这基础上封装即可。

# 关于作者
|Qt君公众号(每天更新)|Qt君|
|---|---|
|Qt君个人网站|[www.qtbig.com](http://www.qtbig.com)|
|QQ交流群|732271126|

<p align="center">
  <img src="http://www.qtbig.com/about/index/my_qrcode.jpg" alt="微信公众号:你才小学生">
  <p align="center"><em>微信扫一扫关注公众号</em></p>
</p>
