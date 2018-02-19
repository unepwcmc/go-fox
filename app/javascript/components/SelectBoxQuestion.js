import React from "react"
import PropTypes from "prop-types"

export default class SelectBoxQuestion extends React.Component {
  // Takes in a text question and renders the form

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
        <p>
          <select name={this.fieldNameFor("raw")}>
            <option value=""></option>
            {selectOptions}
          </select>

          <input name={this.fieldNameFor("answerable_type")} type="hidden" value="DemographicQuestion"/>
          <input name={this.fieldNameFor("answerable_id")} type="hidden" value={this.props.question.id}/>
        </p>
      </div>
    );
  }
}

// TextQuestion.propTypes = {
  // text:     PropTypes.string.isRequired,
  // answers:  PropTypes.array.isRequired
// };
