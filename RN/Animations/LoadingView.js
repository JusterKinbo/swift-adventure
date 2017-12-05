import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Button,
	Image,
	Animated,
	Easing,
	TouchableHighlight
} from 'react-native';

var TimerMixin = require('react-timer-mixin');

export default class RefreshViewScreen extends Component {


	constructor(props) {
		super(props)
		this.imgArr = [require('./imgs/1.gif'), require('./imgs/2.gif'), require('./imgs/3.gif'), require('./imgs/4.gif')]
		this.state = {
			curIndex: 0,
			rotateValue: new Animated.Value(0),
		}
	}

	componentDidMount() {
		
	

	}
	_startIntervalAnimation = () =>
	{
		///多个图片模拟loading需要考虑时间、图片数量，这种操作太接近瞬时态+耗CPU，我觉得不好
		let duration = 10 / this.imgArr.length
		this.interval = setInterval(
			() => {
				let index = this.state.curIndex
				if (index == this.imgArr.length - 1) { index = -1 }
				index += 1
				this.setState({ curIndex: index })
			},
			1
		);
	}
	_startAnimation() {
		this.state.rotateValue.setValue(0)//保证每次都可以转动
		Animated.timing(this.state.rotateValue, {
			toValue: 360,
			duration: 1000,
			easing: Easing.linear
		}).start((o) => {
			if (o.finished ) {
				this._startAnimation();
			}
		});
	}


	componentWillUnmount() {
		this.interval && clearTimeout(this.interval);
	}
	render() {

		return (

			<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
				<Image source={require('./loading.gif')} style={{ width: 100, height: 100 }} />
				<Image source={require('./PYY.jpeg')} style={{ width: 100, height: 100 }} />
				<Image source={this.imgArr[this.state.curIndex]} style={{ width: 100, height: 100 }} />
				<TouchableHighlight onPress={()=>{this._startIntervalAnimation()}} style={{marginTop:20}}>
				<Text>点我开启定时器动画</Text>
				</TouchableHighlight>
				<TouchableHighlight onPress={() => {this.interval && clearTimeout(this.interval);}} style={{marginTop:20}}>
				<Text>点我关闭定时器动画</Text>
				</TouchableHighlight>
				<Animated.Image                         // 可选的基本组件类型: Image, Text, View
					source={require('./arcs.jpg')}
					style={{
						width: 100,
						height: 100,
						marginTop:30,
						transform: [                        // `transform`是一个有序数组（动画按顺序执行）
							{
								rotate: this.state.rotateValue.interpolate({
									inputRange: [0, 360],
									outputRange: ['0deg', '360deg']
								})
							},
						]
					}}
				/>
				<TouchableHighlight onPress={()=>{this.state.rotateValue.stopAnimation()}} style={{marginTop:30}}>
					<Text>点我停止动画</Text>
				</TouchableHighlight>
				<TouchableHighlight onPress={()=>{this._startAnimation()}} style={{marginTop:20}}>
				<Text>点我开启动画</Text>
			</TouchableHighlight>
			</View>
		);
	}
}



