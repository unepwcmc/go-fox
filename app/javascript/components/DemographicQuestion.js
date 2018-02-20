import React from "react"
import PropTypes from "prop-types"

import TextQuestion from "./TextQuestion"
import RadioQuestion from "./RadioQuestion"
import SelectBoxQuestion from "./SelectBoxQuestion"
import MultiSelectQuestion from "./MultiSelectQuestion"

export default class DemographicQuestion extends React.Component {
  renderComponent() {
    let sharedProps = {
      question:   this.props.question,
      options:    this.props.options,
      model:      this.props.model,
      attribute:  this.props.attribute,
      index:      this.props.index,
      field:      this.props.field
    };

    switch(this.props.question.question_type) {
      case 'Free Text':
        return <TextQuestion {...sharedProps}/>;
      case 'Radio button':
        return <RadioQuestion {...sharedProps}/>;
      case 'Select box':
        return <SelectBoxQuestion {...sharedProps}/>;
      case 'Multiple Select Box':
        return <MultiSelectQuestion {...sharedProps}/>;
      default:
        return null;
    }
  }

  render () {
    return(
      <div>{this.renderComponent()}</div>
    );
  }
}

// DemographicQuestion.propTypes = {
  // question:   PropTypes.array.isRequired,
  // options:    PropTypes.array.isRequired,
  // model:      PropTypes.string.isRequired,
  // attribute:  PropTypes.string.isRequired,
  // index:      PropTypes.integer.isRequired,
  // field:      PropTypes.string.isRequired
// };
