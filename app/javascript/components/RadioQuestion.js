import React from "react"
import PropTypes from "prop-types"

export default class RadioQuestion extends React.Component {
  // Takes in a radio button question and renders the form
  
  fieldNameFor(value) {
    return(this.props.model + "[" + this.props.attribute + "][" + this.props.index + "][" + value + "]")
  }

  render () {
    const radioButtons = this.props.options.map((option, index) =>
      <div key={index}>
        <input name={this.fieldNameFor("raw")} value={option.text} type="radio"/>
        {option.text}
      </div>
    );

    return(
      <div>
        <h3>{this.props.question.text}</h3>
        {radioButtons}
        <input name={this.fieldNameFor("answerable_type")} type="hidden" value="DemographicQuestion"/>
        <input name={this.fieldNameFor("answerable_id")} type="hidden" value={this.props.question.id}/>
      </div>
    );
  }
}
