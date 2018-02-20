import React from "react"
import PropTypes from "prop-types"

export default class TextQuestion extends React.Component {
  fieldNameFor(value) {
    return(this.props.model + "[" + this.props.attribute + "][" + this.props.index + "][" + value + "]")
  }

  render () {
    return(
      <div>
        <h3>{this.props.question.text}</h3>
        <p>
          <input name={this.fieldNameFor("raw")} type="text"/>
          <input name={this.fieldNameFor("answerable_type")} type="hidden" value="DemographicQuestion"/>
          <input name={this.fieldNameFor("answerable_id")} type="hidden" value={this.props.question.id}/>
        </p>
      </div>
    );
  }
}
