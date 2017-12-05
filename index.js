import React from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	View,
	Button,
	TouchableWithoutFeedback
} from 'react-native';
import { StackNavigator } from 'react-navigation';

import Routers from "./Route"
import MainList from "./MainList"



class RNHighScores extends React.Component {
	constructor(props)
	{
		super(props)
		//由原生传过来的参数
		var contents = this.props["scores"].map(
			score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
		);
		console.log('**********   app启动是依靠函数的可以传参数   **********')
		console.log(this.props["scores"])
		console.log('**********   **********   **********')

	}
	
	render() {
		
		return (
			<View style={styles.container}>
				<SimpleApp />
			</View>
		);
	}
}


export const SimpleApp = StackNavigator({//Routers
	"Home": { screen: MainList ,
		navigationOptions: {
			headerLeft: null,
		},},
		...Routers.routeCfg
}, {
	...Routers.routeOpt
});




const styles = StyleSheet.create({
	container: {
		flex: 1,
		marginTop: 66,//保证漏出RN中的导航
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

// 整体js模块的名称
AppRegistry.registerComponent('MyReactNativeApp', () => RNHighScores);