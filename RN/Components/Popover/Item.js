

import React, { PropTypes, Component } from 'react';
import {
	StyleSheet,
	Text,
	Image,
	View,
	TouchableWithoutFeedback
} from 'react-native';
import merge from 'lodash/merge'

export default class Item extends Component {


	static defaultProps = {
		//默认的图片
		img: { uri: 'https://facebook.github.io/react/img/logo_og.png' },
		//默认的标题 
		title: '网络图片',
	}
	static propTypes = {
		//默认的标题
		title: PropTypes.string.isRequired,
		//自定义样式对象 结构同baseStyle
		styles: PropTypes.object,
		//容器样式对象 等效于 styles.container
		style: PropTypes.object,
		//item Style
		itemStyle: PropTypes.object,
		//image Style
		imageStyle: PropTypes.object,
		//text Style
		textStyle: PropTypes.object,
	}

	static setBaseStyle(style = {}) {
		merge(baseStyle, style);
	}

	//获取当前样式
	_getStyle() {
		// 自定义样式
		let { styles, style } = this.props;
		// 容器样式对象 等效于 styles.container
		style && (style = { container: merge({}, style) });
		return StyleSheet.create(merge({}, baseStyle, styles, style));
	}

	constructor(props) {
		super(props)
	}

	_hanlderResponderStart = () => {
		this.props.onClick()
	}

	render() {
		let style = this._getStyle()
		return (
			<View style={[style.container, this.props.itemStyle]}>
				<TouchableWithoutFeedback onPress={this._hanlderResponderStart} >
					<View style={style.itemStyle}>
						<Image style={[style.imageStyle, this.props.imageStyle]} source={this.props.img}></Image>
						<Text style={[style.textStyle, this.props.textStyle]} >{this.props.title}</Text>
					</View>
				</TouchableWithoutFeedback>
			</View>
		);
	}
}

const baseStyle = {

	container: {
		width: 110,
		height: 35,
	},
	itemStyle: {
		flexDirection: 'row',
		justifyContent: 'flex-start',
		alignItems: 'center',
		marginTop: 10,
		marginBottom: 10,
		marginLeft: 10
	},
	textStyle: {
		marginLeft: 10,
		fontWeight: '500',
		fontSize: 14,
		color: '#333333'
	},
	imageStyle: {
		width: 16,
		height: 16,
	},

}