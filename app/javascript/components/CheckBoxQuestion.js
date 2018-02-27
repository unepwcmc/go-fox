import React from "react"
import PropTypes from "prop-types"

export default class CheckBoxQuestion extends React.Component {
  fieldNameFor(value) {
    return(this.props.model + "[" + this.props.attribute + "][" + this.props.index + "][" + value + "]")
  }

  render() {
    const checkBoxes = this.props.options.map((option, index) =>
      <div key={index}>
        <input name={this.fieldNameFor("raw") + "[]"} value={option.text} type="checkbox"/>{option.text}
      </div>
    );

    return(
      <div>
        <h3>{this.props.question.text}</h3>
        {checkBoxes}
        <input name={this.fieldNameFor("answerable_type")} type="hidden" value={this.props.questionClass}/>
        <input name={this.fieldNameFor("answerable_id")} type="hidden" value={this.props.question.id}/>
      </div>
    );
  }
}
