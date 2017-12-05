import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Button,
	NativeModules,
	NativeEventEmitter,
	TouchableHighlight
} from 'react-native';

import RNLinearView from "./RNLinearView"

export default class DetailsScreen extends Component {

	constructor(props) {
		super(props)
		this.state = {
			enabled: true
		}
	}

	componentDidMount() {
		//基本方法
		NativeModules.Native2RN.addEvent("One", "Two", 3)
		NativeModules.Native2RN.addEventWithCallback("One", "Two", 3, function (o) {
			console.log("**** rn *****");
			console.log(o);
		});

		//暴露常量
		console.log("const variance", NativeModules.Native2RNEventEmitter.z)

		//发送事件
		const Native2RNEventEmitter = new NativeEventEmitter(NativeModules.Native2RNEventEmitter);
		const subscription = Native2RNEventEmitter.addListener(
			'EventReminder',
			(reminder) => {
				console.log('EVENT')
				console.log('name: ' + reminder.name)
				console.log('location: ' + reminder.location)
				console.log('date: ' + reminder.date)
			}
		);
		NativeModules.Native2RNEventEmitter.addEvent("One", "Two", 3, function (o) {
			console.log('In Callback', o);
		});

		//就剩UI了

	}


	render() {

		return (

			<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
				<Text>测试swift native 与 rn</Text>
				<RNLinearView
					style={styles.gradient}
					backgroundColor={'#5ED2A0'}
					enabled={this.state.enabled}
				/>
				<TouchableHighlight sytle={{ marginTop: 20, width: 100, height: 30 }} onPress={() => {
					let enable = this.state.enabled
					this.setState({ enabled:!enable })
				}}>
					<Text> 点击改变btn的点击状态</Text>
				</TouchableHighlight>
			</View>

		);
	}
}



const styles = StyleSheet.create({
	container: {
		flex: 1,
		marginTop: 66,
		backgroundColor: '#FFFFFF',
	},
	textContainer: {
		flex: 1,
		justifyContent: 'center',
		alignItems: 'center',
		backgroundColor: '#FFFFFF',
	},
	highScoresTitle: {
		fontSize: 20,
		textAlign: 'center',
		margin: 10,
	},
	scores: {
		textAlign: 'center',
		color: '#333333',
		marginBottom: 5,
	},
	gradient: {
		marginTop: 20,
		width: 200,
		height: 200,
	}
});