import React from "react"
import PropTypes from "prop-types"

export default class TextQuestion extends React.Component {
  // Takes in a text question and renders the form

  render () {
    const fieldName = this.props.model + "[" + this.props.attribute + "][" + this.props.index + "]"
    return(
      <div>
        <h3>{this.props.question.text}</h3>
        <p>
          <input name={fieldName + "[raw]"} type="text"/>
          <input name={fieldName + "[answerable_type]"} type="hidden" value="DemographicQuestion"/>
          <input name={fieldName + "[answerable_id]"} type="hidden" value={this.props.question.id}/>
        </p>
      </div>
    );
  }
}

// TextQuestion.propTypes = {
  // text:     PropTypes.string.isRequired,
  // answers:  PropTypes.array.isRequired
// };
