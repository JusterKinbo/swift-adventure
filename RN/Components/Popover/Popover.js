import React, { PropTypes, Component } from 'react';
import {
	StyleSheet,
	Dimensions,
	Text,
	ART,
	TouchableWithoutFeedback,
	View,
	Modal,
} from 'react-native';
const { Shape, Path, Surface } = ART;
const { height, width } = Dimensions.get('window');
import merge from 'lodash/merge'
import Item from './Item'

export default class Popover extends Component{

	static defaultProps = {
		//控制Popover是否显示
		visible: false,
		//控制Popover的三角形是否显示
		triangleVisible: true,
		//三角形的位置，可以放在上下左右四个位置
		trianglePosition: 'top',
		//三角形在指定位置上的偏移
		triangleSkewing: 5,
		//Popover中popoverStyle与三角形的背景色
		backgroundColor: '#ffffff',
		//是否模态展示
		isModalType: false,
	};


	static propTypes = {
		//容器样式对象 等效于 styles.container
		style: PropTypes.object,
		//自定义样式对象 结构同baseStyle
		styles: PropTypes.object,
		//控制Popover的三角形是否显示
		triangleVisible: PropTypes.bool,
		//三角形的位置，可以放在上下左右四个位置
		trianglePositon: PropTypes.oneOf(['top', 'left', 'bottom', 'right']),
		//三角形在指定位置上的偏移
		triangleSkewing: PropTypes.number,
		//Popover中popoverStyle与三角形的背景色
		backgroundColor: PropTypes.string,
		//点击空白区域的回调
		onPressBlacnkArea: PropTypes.func.isRequired,
		//Popover中展示的弹窗的位置
		popoverPosition: PropTypes.object.isRequired,
		//是否模态展示
		isModalType: PropTypes.bool,
	}
	//设置默认样式
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

	_constraintItemsContainer()
	{
		return {width:baseStyle.popoverStyle.width,height:baseStyle.popoverStyle.height}
	}

	constructor(props) {
		super(props)
		this._triangleStyle()
		this._itemsContainerStyle()
		//控制是否显示
		this.state = {
			visible: this.props.visible,
		}
		this.childs = React.Children.map(this.props.children, (child) => { return child })

	}

	//点击空白处的回调
	_dissmiss = () => {
		this.props.onPressBlacnkArea()
	}
	_getDisapleyView() {

		let triAngleBottomWidth = 10;
		let triAngleHeight = 12;
		const path = new Path()
			.moveTo(1, 1 + triAngleHeight)
			.lineTo(1 + triAngleBottomWidth, 1 + triAngleHeight)
			.lineTo(1 + triAngleBottomWidth / 2, 1)
			.close();
		let style = this._getStyle()


		return (
			<TouchableWithoutFeedback onPress={this._dissmiss}>
				<View style={style.container}  >
					<View style={[style.popoverStyle, this.props.popoverPosition]}>
						<View style={[this._getItemsContainerStyle()]}
						//将此view的宽高与popContainer一致this._constraintItemsContainer()
						>
							{
								this.childs
							}
						</View>
						{
							this.props.triangleVisible == false ? null :
								(
									<View style={this._getTriangleStyle()}>
										<Surface width={13} height={13}>
											<Shape d={path} fill={this.props.backgroundColor} />
										</Surface>
									</View>
								)
						}
					</View>
				</View>
			</TouchableWithoutFeedback>
		)
	}
	_views() {
		if (this.props.isModalType) return (
			<Modal
				transparent={true}
				visible={this.state.visible} >
				{this._getDisapleyView()}
			</Modal>

		)
		return (
			this.state.visible == false ? null :(
				<View style={{position: 'absolute',top:0,left:0}}>
					{this._getDisapleyView()}
				</View>
			)

		)
	}
	
	//外界控制是否消失
	componentWillReceiveProps(nextProps) {
		this.setState({ visible: nextProps.visible })
	}
	

	render() {

		
		return (

			this._views()
			

		);
	}

	//处理动态style
	_getTriangleStyle() {
		console.log(this.props.trianglePosition)
		if (this.props.trianglePosition == 'top') return [this.triganleStyles.triangleUpStyle, { right: this.props.triangleSkewing }]
		if (this.props.trianglePosition == 'left') return [this.triganleStyles.triangleLeftStyle, { top: this.props.triangleSkewing }]
		if (this.props.trianglePosition == 'bottom') return [this.triganleStyles.triangleDownStyle, { left: this.props.triangleSkewing }]
		if (this.props.trianglePosition == 'right') return [this.triganleStyles.triangleRightStyle, { top: this.props.triangleSkewing }]
		return [this.triganleStyles.triangleUpStyle, { right: this.props.triangleSkewing }]
	}
	_getItemsContainerStyle() {
		if (this.props.trianglePosition == 'top') return this.itemsContainerStyles.itemsContainerForTriangleUp
		if (this.props.trianglePosition == 'left') return this.itemsContainerStyles.itemsContainerForTriangleLeft
		if (this.props.trianglePosition == 'bottom') return this.itemsContainerStyles.itemsContainerForTriangleDwon
		if (this.props.trianglePosition == 'right') return this.itemsContainerStyles.itemsContainerForTriangleRight
		return this.itemsContainerStyles.itemsContainerForTriangleUp
	}
	/**
	 * 三角的布局
	 *    需要知道item的宽高
	 *    线的宽高
	 * @memberOf PopView
	 */
	_triangleStyle() {
		this.triganleStyles = StyleSheet.create({
			triangleUpStyle: {
				position: 'absolute',
				top: 0, right: 5,
				transform: [
					{ rotate: '0deg' },
				]
			}, triangleLeftStyle: {
				position: 'absolute',
				top: 5, left: 0,//
				transform: [
					{ rotate: '270deg' },
				]
			}
			, triangleDownStyle: {
				position: 'absolute',
				bottom: 0, left: 5,//
				transform: [
					{ rotate: '180deg' },
				]
			}
			, triangleRightStyle: {
				position: 'absolute',
				top: 5, right: 0,//
				transform: [
					{ rotate: '90deg' },
				]
			}
		});
	}
	/**
	 * itemsContainer布局，用于配合三角的摆放
	 *    宽高可以跟着外部变化
	 * 
	 * @memberOf PopView
	 */
	_itemsContainerStyle() {
		this.itemsContainerStyles = StyleSheet.create({
			itemsContainerForTriangleUp: {
				backgroundColor: this.props.backgroundColor,
				position: 'absolute',
				top: 13, left: 0,
				borderRadius: 3,
			},
			itemsContainerForTriangleDwon: {
				backgroundColor: this.props.backgroundColor,
				position: 'absolute',
				bottom: 13, left: 0,
				borderRadius: 3,
			},
			itemsContainerForTriangleLeft: {
				backgroundColor: this.props.backgroundColor,
				position: 'absolute',
				top: 0, left: 13,
				borderRadius: 3,
			},
			itemsContainerForTriangleRight: {
				backgroundColor: this.props.backgroundColor,
				position: 'absolute',
				top: 0, right: 13,
				borderRadius: 3,
			},
		});
	}

}
Popover.Item = Item;

const baseStyle = {
	container: {
		backgroundColor: '#80808050',
		width: width,
		height: height,
	},
	popoverStyle: {
		position: 'absolute',
		width: 110,
	},
};