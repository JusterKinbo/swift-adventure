import React, { Component } from 'react';
import { requireNativeComponent } from 'react-native';

let RNLinearGradient = requireNativeComponent('RNGradinentView', null);

class LinearGradient extends Component {
  render() {
    let {  ...props } = this.props;
    return <RNLinearGradient {...props } />;
  }
}
LinearGradient.propTypes = {
  enabled: React.PropTypes.bool,
}
export default LinearGradient;