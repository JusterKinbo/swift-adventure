# 气泡组件

在点击控件或者某个区域后，浮出一个气泡区域来放置更多的操作或者信息。


### Code Example
```
import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View, Alert, Modal,
	TouchableHighlight, ScrollView,
} from 'react-native';
import { Popover } from 'component'

PopItem=Popover.Item;
var popItemData = [
	{ img: require('./img/unopencount_assistpopview_studyhome_icon.png'), title: '新手学堂' },
	{ img: require('./img/unopencount_assistpopview_customerservice_icon.png'), title: '在线客服' },
	{ img: require('./img/unopencount_assistpopview_hotproblem_icon.png'), title: '热点问题' },
	{ img: { uri: 'https://facebook.github.io/react/img/logo_og.png' }, title: '网络图片' },
];
// Popover.setBaseStyle({container: {
// 		backgroundColor: '#ff0000'
// 	}})
export default class PopTest extends Component {

	constructor(props) {
		super(props)
		this.state = {
			popViewVisible: false,
			positionObj: {},
			rianglePosition: 'top',
		}
	}
	
	
	_showLeftTop = () => {
		this.setState({ trianglePosition: 'top', popViewVisible: true, positionObj: { left: 50, top: 50 } })

	}
	_showLeftBottom = () => {
		this.setState({ trianglePosition: 'left', popViewVisible: true, positionObj: { left: 50, bottom: 200 } })

	}
	_showRightTop = () => {
		this.setState({ trianglePosition: 'bottom', popViewVisible: true, positionObj: { right: 50, top: 200 } })

	}
	_showRightBottom = () => {
		this.setState({ trianglePosition: 'right', popViewVisible: true, positionObj: { right: 50, bottom: 200 } })

	}

	_onClickBlankArea = () => {
		this.setState({ popViewVisible: false })

	}

	_onClick1 = () => {
		console.log('1')
		this.setState({ popViewVisible: false })
	}
	_onClick2 = () => {
		console.log('2')
		this.setState({ popViewVisible: false })
	}
	_onClick3 = () => {
		console.log('3')
		this.setState({ popViewVisible: false })
	}
	_onClick4 = () => {
		console.log('4')
		this.setState({ popViewVisible: false })
	}
	render() {
		
		return (
			<View style={styles.container}>
				<TouchableHighlight onPress={this._showLeftTop} ><Text style={{ backgroundColor: '#00ff00' }}>左上</Text></TouchableHighlight>
				<TouchableHighlight onPress={this._showRightTop} ><Text style={{ backgroundColor: '#00ff00' }}>右上</Text></TouchableHighlight>
				<TouchableHighlight onPress={this._showLeftBottom} ><Text style={{ backgroundColor: '#00ff00' }}>左下</Text></TouchableHighlight>
				<TouchableHighlight onPress={this._showRightBottom} ><Text style={{ backgroundColor: '#00ff00' }}>右下</Text></TouchableHighlight>

				<Popover popoverPosition={this.state.positionObj}
					trianglePosition={this.state.trianglePosition}
					onPressBlacnkArea={this._onClickBlankArea}
					visible={this.state.popViewVisible}
					// backgroundColor='#ff0000'
					// styles={testStyles}
					// style={testStyle}
					>
					<PopItem img={popItemData[0].img} onClick={this._onClick1} title={popItemData[0].title}></PopItem>
					<View style={styles.lineStyle} />
					<PopItem img={popItemData[1].img} onClick={this._onClick2} title={popItemData[1].title}></PopItem>
					<View style={styles.lineStyle} />
					<PopItem img={popItemData[2].img} onClick={this._onClick3} title={popItemData[2].title}></PopItem>
					<View style={styles.lineStyle} />
					<PopItem img={popItemData[3].img} onClick={this._onClick4} title={popItemData[3].title}></PopItem>
				</Popover>

			</View>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		flex: 1,
		flexDirection: 'column',
		justifyContent: 'space-around',
		alignItems: 'center',
		backgroundColor:'#e6e6e6'
	},
	welcome: {
		fontSize: 20,
		textAlign: 'center',
		margin: 10,
	},
	instructions: {
		textAlign: 'center',
		color: '#333333',
		marginBottom: 5,
	},
	lineStyle: {
		backgroundColor: '#cccccc',
		height: 1,
		marginLeft: 10,
		marginRight: 10,
		marginTop: 1
	},
});

const testStyles={
		container: {
		backgroundColor: '#ff0000',
	},
	popoverStyle: {
		position: 'absolute',
		width: 110,
	},
}

const testStyle={
		backgroundColor: '#00ff00',
}


```
* popoverStyle中的宽度应当与Popover.item保持一致

### API 
* Popover  

|      Properties     |          Descrition         |                Type                 |  Default  |
|:--------------------:|:--------------------------:|:-----------------------------------:|:---------:|
| visible              | popover是否显示             |         bool                        |      false|
| triangleVisible      | 三角形状是否显示              |         bool                        |       true|
| trianglePositon      | 三角形方向                   |string('up','left','botoom','right') |       'up'|
| triangleSkewing      | 三角形在指定方向上的偏移       |                 number               |        5 |
| backgroundColor		|整体颜色			            |  string                              | '#ffffff'|
| onPressBlacnkArea		|点击空白处的回调函数           |  function                            |         -|
| popoverPosition		|popover在浮层中的位置         |  object{需要给出绝对布局的位置}          |         -|
| styles         		|自定义样式格式	               |  object同baseStyle                    |baseStyle|
| style          		|自定义container样式格式       |  object同baseStyle.container |baseStyle.container|
| isModalType          |控制是否模态显示               |       bool                           |   false  |

* Popover.Item

|      Properties     |          Descrition         |                Type                 |  Default  |
|:-------------------:|:---------------------------:|:-----------------------------------:|:---------:|
| img                 | popover是否显示              |         bool                        |      false|
| title               | 三角形状是否显示              |         bool                        |       true|
| styles         	  | 自定义样式格式	               |  object同baseStyle                   |baseStyle|
| style          	  | 自定义container样式格式       |  object同baseStyle.container |baseStyle.container|
| itemStyle           | item整体样式                 |  object同itemStyle                   |   false  |
| imageStyle          | image样式                   |  object同imageStyle                  |   false  |
| textStyle           | text样式                    |  object同textStyle                   |   false  |





