在PathView控件基础上加入滚动选择条，滚动选择条在这基础上加入Key-Value的做法，key为显示内容，value为实际内容，这样可以避免内容上的转换。
<p align="center">
  <img src="https://github.com/QtComponent/WheelView/blob/master/Resource/WheelViewDemo.gif?raw=true" alt="">
  <p align="center"><em>WheelView</em></p>
</p>

## 使用示例
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
## 源码
```qml
import QtQuick 2.0

PathView {
    id: root

    property variant value
    property int displayFontSize: width/4
    /* (displayStep > 0 && displayStep < 1) Sliding font size recursively reduced.
     * (displayStep == 1) Sliding fonts are equal in size.
     * (displayStep > 1) Sliding font size recursively increased.
     */
    property real displayStep: 0.5 // displayStep > 0

    width: 100; height: 300
    /* Example:
     * note: model Format
     * model: [{ display: "A", value: "1" },
     *         { display: "B", value: "2" },
     *         { display: "C", value: "3" }]
     * value: "1"
     */
    clip: true
    pathItemCount: 7
    preferredHighlightBegin: 0.5
    preferredHighlightEnd: 0.5
    dragMargin: root.width/2
    Component.onCompleted: findCurrentIndex()

    onMovementEnded: value = (model[currentIndex].value)
    onValueChanged: findCurrentIndex()

    Keys.onUpPressed: {
        root.decrementCurrentIndex()
        value = (model[currentIndex].value)
    }

    Keys.onDownPressed: {
        root.incrementCurrentIndex()
        value = (model[currentIndex].value)
    }

    delegate: Item {
        width: root.width
        height: root.height/pathItemCount

        Text {
            anchors.centerIn: parent;
            font.pixelSize: displayFontSize*Number(parent.PathView.textFontPercent);
            text: modelData.display
            color: currentIndex == index ? "#43bfe3" : "#848484"
        }
    }

    path: Path {
        startX: root.width/2; startY: 0

        PathAttribute { name: "textFontPercent"; value: displayStep }

        PathLine { x: root.width/2; y: root.height/2 }

        PathAttribute { name: "textFontPercent"; value: 1}

        PathLine { x: root.width/2; y: root.height }

        PathAttribute { name: "textFontPercent"; value: displayStep }
    }

    function findCurrentIndex() {
        for (var i = 0; i < count; i++)
            if (model[i].value === value)
                currentIndex = i;
    }
}
```
## 注意
* model这里提供了两种生成的方式;
* 如需要再次定制则在这基础上封装即可。

