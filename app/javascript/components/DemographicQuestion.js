import React from "react"
import PropTypes from "prop-types"

import TextQuestion from "./TextQuestion"
import RadioQuestion from "./RadioQuestion"
import SelectBoxQuestion from "./SelectBoxQuestion"
import CheckBoxQuestion from "./CheckBoxQuestion"
import MultiSelectQuestion from "./MultiSelectQuestion"

export default class DemographicQuestion extends React.Component {
  renderComponent() {
    let sharedProps = {
      index:          this.props.index,
      question:       this.props.question, // This can either be a demographic or customised question
      questionType:   this.props.questionType,
      questionClass:  this.props.questionClass,
      options:        this.props.options,
      model:          this.props.model,
      attribute:      this.props.attribute,
      field:          this.props.field
    };

    switch(this.props.questionType) {
      case 'Free Text':
        return <TextQuestion {...sharedProps}/>;
      case 'Radio button':
        return <RadioQuestion {...sharedProps}/>;
      case 'Select box':
        return <SelectBoxQuestion {...sharedProps}/>;
      case 'Checkbox':
        return <CheckBoxQuestion {...sharedProps}/>;
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
