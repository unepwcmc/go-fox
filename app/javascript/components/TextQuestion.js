import React from "react"
import PropTypes from "prop-types"

export default class TextQuestion extends React.Component {
  // Takes in a text question and renders the form

  render () {
    const fieldName = this.props.model + "[" + this.props.attribute + "][" + this.props.index + "][" + this.props.field + "]"

    return(
      <div>
        <h3>{this.props.question.text}</h3>
        <p>
          <input name={fieldName} type="text"/>
        </p>
      </div>
    );
  }
}

// TextQuestion.propTypes = {
  // text:     PropTypes.string.isRequired,
  // answers:  PropTypes.array.isRequired
// };

