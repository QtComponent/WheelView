import QtQuick 1.1

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

