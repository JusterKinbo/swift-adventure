import React, { Component } from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Button,
	Share
} from 'react-native';




export default class ShareScreen extends Component {

	constructor(props) {
		super(props)
		this.state = {
			result: "点击button查看share结果"
		}
	}

	_showResult = (result) => {
		if (result.action === Share.sharedAction) {
			if (result.activityType) {
				this.setState({ result: 'shared with an activityType: ' + result.activityType });
			} else {
				this.setState({ result: 'shared' });
			}
		} else if (result.action === Share.dismissedAction) {
			this.setState({ result: 'dismissed' });
		}
	}

	render() {

		return (

			<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
				<Text>{this.state.result}</Text>
				<Button onPress={() => {
					Share.share({
						message: 'this is msg',
						title:"this is titile"
					}).then(this._showResult)
						.catch((error) => this.setState({ result: 'error: ' + error.message }));
				}}
					title="这里要学Share"></Button>
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
});