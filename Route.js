import React from 'react';
import {
	Text,
	View,
	TouchableWithoutFeedback
} from 'react-native';

import Gestures from './RN/Gestures/Route'
import Animations from "./RN/Animations/Route"
import Listviews from "./RN/ListView/Route"
import Components from "./RN/Components/Route"
import Natives from "./RN/Native/Route"


export default {
	routeCfg:{
		...Gestures,
		...Animations,
		...Listviews,
		...Components,
		...Natives,
	},
	routeOpt:{
		//OPT
		initialRouteName: 'Home',
		navigationOptions:({ navigation }) => ( { //这是一个函数，可以接受三个参数，但是常用的而是这一个
			headerStyle: {
				backgroundColor: "#98F5FF",
			},
			headerTitleStyle: {
				color: "#FFDAB9",
				fontSize: 18
			},
			headerTintColor: "#7FFFD4",
			headerBackTitle: null,
			headerLeft: (<View style={{  width: 40, height: 44, alignItems: 'center', justifyContent: 'center', backgroundColor:"#ff0000" }}>
				<TouchableWithoutFeedback onPress={() => { navigation.goBack() }}>
				<View><Text>返回</Text></View>
				</TouchableWithoutFeedback>
			</View>),
		})
	}
	
}