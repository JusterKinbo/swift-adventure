export default {
	"Animate": {
		screen: require('./AnimateScreen').default,
		path: 'DetailsScreen',
		navigationOptions: {
			headerTitle: '动画',
		},
	},
	"RefreshView": {
		screen: require('./LoadingView').default,
		path: 'LoadingView',
		navigationOptions: {
			headerTitle: 'Loading动画',
		},
	},
}