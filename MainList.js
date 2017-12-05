/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
	StyleSheet,
	Text,
	View,
	ListView,
	TouchableHighlight,
} from 'react-native';

export default class MyList extends Component {
	static navigationOptions = {
		title: 'RN首页',
	};
	constructor(props) {
		super(props)
		var ds = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2, sectionHeaderHasChanged: (s1, s2) => s1 !== s2 });
		this.state = {
			dataSource: ds.cloneWithRowsAndSections(this._genRows()),
		}
	}


	render() {
		return (
			<View style={{ flex: 1 }}>
				<ListView
					dataSource={this.state.dataSource}
					renderRow={this._renderRow}
					renderSeparator={this._renderSeperator}
					renderSectionHeader={this._renderSectionHeader}
				/>

			</View>
		);
	}

	_genRows() {
		return (
			{
				'animate': [
					{ title: 'Animation', component: "Animate" },
					{ title: 'loading', component: "RefreshView" },
				],
				'gesture': [
					{ title: 'Gestures', component: "Details" }
				],
				'listview': [
					{ title: 'Simple Refresh', component: "SimpleRefreshListView" },
				],
				'Components': [
					{ title: 'Popover', component: "Popover" },
					{ title: 'RN CameraRoll', component: "CameraRoll" },
					{ title: 'RN Share', component: "Share" },
				],
				'Natives': [
					{ title: 'NativeMethod', component: "Native2RN" },
				],

			}
		)
	}
	_navigate(rowData) {
		const { navigate } = this.props.navigation;
		navigate(rowData.component)
	}
	_renderSectionHeader = (data, sectionID) => {
		return (
			<View><Text>{sectionID}</Text></View>
		)
	}
	_renderRow = (rowData, sectionID, rowID, highlightRow) => {

		return (
			<TouchableHighlight onPress={() => {
				this._pressRow(rowData);
				highlightRow(sectionID, rowID);
			}}>

				<View style={styles.row}>
					<Text style={styles.text}>
						{rowData.title}
					</Text>
				</View>

			</TouchableHighlight>
		);
	}
	_pressRow = (rowData) => {
		console.log(rowData)
		this._navigate(rowData)
	}
	_renderSeperator = (sectionID, rowID, adjacentRowHighlighted) => {
		return (
			<View
				key={`${sectionID}-${rowID}`}
				style={{
					height: adjacentRowHighlighted ? 4 : 1,
					backgroundColor: adjacentRowHighlighted ? '#3B5998' : '#CCCCCC',
				}}
			/>
		);
	}
}

var styles = StyleSheet.create({
	row: {
		flexDirection: 'row',
		justifyContent: 'center',
		padding: 10,
		backgroundColor: '#F6F6F6',
	},
	text: {
		flex: 1,
	},
});


