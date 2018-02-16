import React from "react"
import PropTypes from "prop-types"

export default class RadioQuestion extends React.Component {
  // Takes in a text question and renders the form

  render () {
    const fieldName = this.props.model + "[" + this.props.attribute + "][" + this.props.index + "]"
    const radioButtons = this.props.options.map((option, index) =>
      <div>
        <input name={fieldName + "[raw]"} value={option.text} key={index} type="radio"/>{option.text}
      </div>
    );

    return(
      <div>
        <h3>{this.props.question.text}</h3>
        {radioButtons}
        <input name={fieldName + "[answerable_type]"} type="hidden" value="DemographicQuestion"/>
        <input name={fieldName + "[answerable_id]"} type="hidden" value={this.props.question.id}/>
      </div>
    );
  }
}
