'use strict';

import React from 'react';
import {
	AppRegistry,
	StyleSheet,
	Text,
	ScrollView,
	TouchableHighlight,
	ListView,
	Image,
	RefreshControl,
	ActivityIndicator,
	View,
} from 'react-native';



var pageSizeCount = 3;//每次读取的数量
var pageSizeSyn = pageSizeCount;//当前的总数量
var totalList = [];

///scrollview 或者 listview 的 onScroll决定此时需要上拉加载还是下拉刷新  
/**
 * onScroll 传递参数event
 * contentHeight：event.nativeEvent.contentSize.height
 * scroll/list height:event.nativeEvent.layoutMeasurement.height
 * contentOffsetY: event.nativeEvent.contentOffset.y
 * 偏移y就是内容的实际偏移，如果偏移小于0 + x （一般会有一个模糊的阈值),则表示此时需要进入下拉刷新
 * 偏移y> （contentHeight - scroll/list.height + x （一般会有一个模糊的阈值)）表示此时需要进入上拉加载更多
 */
export default class RfreshListViewScreen extends React.Component {


	constructor(props) {
		super(props);
		var ds = new ListView.DataSource({ rowHasChanged: (r1, r2) => r1 !== r2 });
		totalList = this._genRows({});
		this.state = {

			dataSource: ds.cloneWithRows(totalList),
			isRefreshing: false,
			loaded: 0,
			footState: 3,
			footLoaded: true,
			longdingTitle: "下拉刷新。。。。"

		}

		this.reachEnd = false//表示是否到底部了，此时才需要判断offset来决定上拉状态
		this.waitToFootRefresh = false//因为onScroll调用的次数比end drag多，需要此判断多个
		this.offsetY = 0 //contentOffsetY
		this.hasMoreData = true //是否可以上拉
	}

	x = 1;
	THUMB_URLS = [
		require('./Thumbnails/blackArrow.png'),
		require('./Thumbnails/blueArrow.png'),
		require('./Thumbnails/darkBlueArrow.png'),
		require('./Thumbnails/greenArrow.png'),
		require('./Thumbnails/pinkArrow.png'),
		require('./Thumbnails/redArrow.png'),
		require('./Thumbnails/shadowYellowArrow.png'),
		require('./Thumbnails/yellowArrow.png'),
	];




	componentWillMount() {
		this._pressData = {};

	}

	render() {

		return (
			<View>
				<ListView
					refreshControl={
						<RefreshControl
							refreshing={this.state.isRefreshing}
							onRefresh={this._onRefresh.bind(this)}//需要知道这个调用点，然后改写
							tintColor='#ff0000'
							title={this.state.longdingTitle}
							titleColor='#0000ff'
							progressBackgroundColor='#ffff00'

						/>}
					dataSource={this.state.dataSource}
					renderRow={this._renderRow.bind(this)}
					renderSeparator={this._renderSeparator}
					renderFooter={this._renderFooter.bind(this)}
					onEndReached={this._endReached.bind(this)}
					onEndReachedThreshold={0}
					onScroll={this._onScroll.bind(this)}
					onScrollEndDrag={(event) => this._onScrollEndDrag(event)}
					onScrollBeginDrag={(event) => this._onScrollBeginDrag(event)}
				/>

			</View>
		);
	}

	_onScroll(evt) {
		let nativeEvent = evt.nativeEvent
		this.offsetY = nativeEvent.contentOffset.y
		let offsetY = this.offsetY
		if (offsetY < - 120 && !this.state.isRefreshing) {
			this.setState({ longdingTitle: "释放刷新。。。。" })
		}
		if (this.hasMoreData && !this.waitToFootRefresh && this.reachEnd && offsetY > 0) {
			this.setState({ footState: 3, footLoaded: false })
		}
		if (this.hasMoreData && !this.waitToFootRefresh && this.reachEnd && offsetY > 40) {
			this.setState({ footState: 1, footLoaded: false })
		}



	}
	_onScrollBeginDrag(evt) {
		console.log("begin drag")
	}
	_onScrollEndDrag(evt) {
		console.log("end drag", evt.nativeEvent.contentOffset.y)
		if (this.hasMoreData && this.reachEnd && this.offsetY > 80) {
			console.log("end drag refresh")
			this.setState({ footState: 2, footLoaded: true })
			this.waitToFootRefresh = true
			setTimeout(() => {
				var dataBlob = [];


				for (var ii = 0; ii < pageSizeCount; ii++) {
					var pressedText = '';
					dataBlob.push('Row ' + (ii + pageSizeSyn) + pressedText);

				}
				pageSizeSyn += pageSizeCount;
				var tempCount = pageSizeCount;
				var rowData = totalList;//.push(...dataBlob);
				var rowData1 = [...rowData, ...dataBlob];
				totalList = rowData1;
				this.hasMoreData = false
				this.setState({
					footState: 5, footLoaded: false,
					dataSource: this.state.dataSource.cloneWithRows(totalList),
					count: pageSizeSyn
				});
			}, 5000);
		}
	}

	//上滑刷新
	_renderFooter() {
		if (this.state.footState == 1) {//加载完成
			return <View style={{ height: 40, alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}
			>
				<Text style={{ color: '#999999', fontSize: 12, marginTop: 10 }}>
					'释放加载。。。。'
            </Text>
			</View>
		}
		if (this.state.footState == 2) {//加载完成
			return <View style={{ height: 40, alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}
			>
				{
					// console.log("end drag refreshing")
					this.state.footLoaded ? <ActivityIndicator
						animating={this.state.footLoaded}
						style={[{
							alignItems: 'center',
							justifyContent: 'center',
							padding: 8
						},
						{ height: 30 }]}
						size="large"
					/> : null}
				<Text style={{ color: '#999999', fontSize: 12, marginTop: 10 }}>
					'正在加载中。。。。'
              </Text>
			</View>
		}
		if (this.state.footState == 3) {
			return <View style={{ height: 40, alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}
				onLayout={(e) => {
					console.log("--------------------render footer" + e.nativeEvent.layout.y)
					this.footerY = e.nativeEvent.layout.y
				}}
			>
				<Text style={{ color: '#999999', fontSize: 12, marginTop: 10 }}>
					'上拉加载。。。。'
            </Text>
			</View>
		}
		if (this.state.footState == 0) {
			return <View style={{ height: 40, alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}
			>
				<Text style={{ color: '#999999', fontSize: 12, marginTop: 10 }}>
					'加载完成！'
            </Text>
			</View>
		}
		if (this.state.footState == 5) {
			return <View style={{ height: 40, alignItems: 'center', justifyContent: 'center', flexDirection: 'row' }}
			>
				<Text style={{ color: '#999999', fontSize: 12, marginTop: 10 }}>
					'没有数据了！'
            </Text>
			</View>
		}
	}
	_endReached() {
		console.log('end reach!!!!!');
		this.reachEnd = true

	}

	//下拉刷新
	_onRefresh() {
		console.log('refreshing!!!!!');
		this.setState({ isRefreshing: true, longdingTitle: "正在刷新。。。。" });
		console.log("*******正在刷新")

		setTimeout(() => {
			var dataBlob = [];
			for (var ii = 0; ii < pageSizeCount; ii++) {
				var pressedText = '';
				dataBlob.push('Row ' + (ii + pageSizeSyn) + pressedText);
			}
			pageSizeSyn += pageSizeCount;
			var tempCount = pageSizeCount;
			var rowData = totalList;//.push(...dataBlob);
			var rowData1 = [...rowData, ...dataBlob];
			totalList = rowData1;
			this.setState({
				isRefreshing: false,
				dataSource: this.state.dataSource.cloneWithRows(totalList),
				count: pageSizeSyn,
				longdingTitle: "下拉刷新。。。。"
			});
		}, 5000);
	}

	_renderRow(rowData, sectionID, rowID, highlightRow) {
		var rowHash = Math.abs(hashCode(rowData));
		var imgSource = this.THUMB_URLS[rowHash % this.THUMB_URLS.length];
		//var imgSRC=require('./Thumbnails/blackArrow.png');
		return (
			<TouchableHighlight onPress={() => {
				this._pressRow(rowID);
				highlightRow(sectionID, rowID);
			}}>
				<View>
					<View style={styles.row}>
						<Image style={styles.thumb} source={imgSource} />
						<Text style={styles.text}>
							{rowData + ' - ' + LOREM_IPSUM.substr(0, rowHash % 301 + 10)}
						</Text>
					</View>
				</View>
			</TouchableHighlight>
		);
	}

	_genRows(pressData) {
		var dataBlob = [];
		for (var ii = 0; ii < pageSizeSyn; ii++) {
			var pressedText = pressData[ii] ? ' (pressed)' : '';
			dataBlob.push('Row ' + ii + pressedText);
		}

		return dataBlob;
	}

	_pressRow(rowID) {
		this._pressData[rowID] = !this._pressData[rowID];
		this.setState({
			dataSource: this.state.dataSource.cloneWithRows(
				this._genRows(this._pressData)
			)
		});
	}

	_renderSeparator(sectionID, rowID, adjacentRowHighlighted) {
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


var LOREM_IPSUM = 'Lorem ipsum dolor sit amet, ius ad pertinax oportere accommodare, an vix civibus corrumpit referrentur. Te nam case ludus inciderint, te mea facilisi adipiscing. Sea id integre luptatum. In tota sale consequuntur nec. Erat ocurreret mei ei. Eu paulo sapientem vulputate est, vel an accusam intellegam interesset. Nam eu stet pericula reprimique, ea vim illud modus, putant invidunt reprehendunt ne qui.';

/* eslint no-bitwise: 0 */
var hashCode = function (str) {
	var hash = 15;
	for (var ii = str.length - 1; ii >= 0; ii--) {
		hash = ((hash << 5) - hash) + str.charCodeAt(ii);
	}
	return hash;
};

var styles = StyleSheet.create({
	row: {
		flexDirection: 'row',
		justifyContent: 'center',
		padding: 10,
		backgroundColor: '#F6F6F6',
	},
	thumb: {
		width: 64,
		height: 64,
	},
	text: {
		flex: 1,
	},
});


