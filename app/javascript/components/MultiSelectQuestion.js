import React from "react"
import PropTypes from "prop-types"

export default class MultiSelectQuestion extends React.Component {
  fieldNameFor(value) {
    return(this.props.model + "[" + this.props.attribute + "][" + this.props.index + "][" + value + "]")
  }

  render () {
    const selectOptions = this.props.options.map((option, index) =>
      <option value={option.text} key={index}>{option.text}</option>
    );

    return(
      <div>
        <h3>{this.props.question.text}</h3>
        <select className="js-select2" name={this.fieldNameFor("raw") + "[]"} multiple="multiple">
          {selectOptions}
        </select>
        <input name={this.fieldNameFor("answerable_type")} type="hidden" value="DemographicQuestion"/>
        <input name={this.fieldNameFor("answerable_id")} type="hidden" value={this.props.question.id}/>
      </div>
    );
  }
}
