import React,{Component} from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Button
} from 'react-native';

export default class DetailsScreen extends Component {
	render() {
		
		return (
			
			<View style={{ flex: 1, alignItems: 'center', justifyContent: 'center' }}>
			<Text>这里要学动画</Text>
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