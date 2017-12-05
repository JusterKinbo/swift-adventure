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
	Image,
	CameraRoll,
} from 'react-native';

export default class CameraRollDemo extends Component {
	
	constructor(props) {
		super(props)
		var ds = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 });
		this.state = {
			dataSource: ds.cloneWithRows(this._genRows()),
			asset: [],
		}
	}

	componentDidMount() {
		fetchParams = {
			groupTypes: 'All',// All/Event/Faces/Library/PhotoStream/SavedPhotos(default) 
			assetType: 'All',//All/Videos/Pohtos(default) 
			// mimeTypes:"jpeg",
			first: 5,
		}
		CameraRoll.getPhotos(fetchParams)
			.then((data) => {this._appendAssets(data)
				console.log("**************")
			console.log(data)}, (e) => logError(e));
	}

	_appendAssets(data) {
		var ds = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 });
		let rows = ds.cloneWithRows(data.edges)
		this.setState({dataSource:rows})
	}

	render() {
		return (
			<View style={{ flex: 1 }}>
				<ListView
					dataSource={this.state.dataSource}
					renderRow={this._renderRow}
					renderSeparator={this._renderSeperator}
					enableEmptySections={true}
				/>

			</View>
		);
	}

	_genRows() {
		return (
			[]
		)
	}

	_renderRow = (rowData, sectionID, rowID, highlightRow) => {

		return (
			<TouchableHighlight onPress={() => {
				// this._pressRow(rowData);
				highlightRow(sectionID, rowID);
			}}>

				<View style={styles.row}>
					<Image
						source={rowData.node.image}
						style={{width:100,height:100}}
					/>
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


