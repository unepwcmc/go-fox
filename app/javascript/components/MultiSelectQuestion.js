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
          <select className="js-example-basic-multiple" name={this.fieldNameFor("raw")} multiple="multiple">
            <option> </option>
            {selectOptions}
        </select>
      </div>
    );
  }
}
