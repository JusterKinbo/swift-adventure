import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,Dimensions,
	View, Alert, Modal,
	TouchableHighlight, ScrollView,
} from 'react-native';
import  Popover  from '../'
const { height, width } = Dimensions.get('window');
PopItem=Popover.Item;
var popItemData = [
	{ img: { uri: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1510741019666&di=9338a851c0a8696d6252f05704e989fc&imgtype=0&src=http%3A%2F%2Fimg.nipic.com%2F2007-07-10%2F20077101955390_1.jpg' }, title: '测试Demo' },
	{ img:  require('./timg.jpeg') , title: '本地图片' },
	{ img: { uri: 'monkey' }, title: '原生图片' },
	{ img: { uri: 'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3449013589,636688153&fm=27&gp=0.jpg' }, title: '网络图片' },
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
		this.setState({ trianglePosition: 'left', popViewVisible: true, positionObj: { left: 50, bottom: 250 } })

	}
	_showRightTop = () => {
		this.setState({ trianglePosition: 'bottom', popViewVisible: true, positionObj: { right: 50, top: 200 } })

	}
	_showRightBottom = () => {
		this.setState({ trianglePosition: 'right', popViewVisible: true, positionObj: { right: 50, bottom: 250 } })

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
					isModalType={false}
					// backgroundColor='#ff0000'
					// styles={testStyles}
					// style={testStyle}
					// triangleVisible={false}

					>
					<PopItem img={popItemData[0].img} onClick={this._onClick1} title={popItemData[0].title}></PopItem>
		 			<View style={styles.lineStyle} />
					<PopItem img={popItemData[1].img}  onClick={this._onClick2} title={popItemData[1].title}></PopItem>
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