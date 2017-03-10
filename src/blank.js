
  case 'MOST_OFTEN_YES': {
          for (const i in this.answers) {
            console.log('found', (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i], act.group);
            if (this.answers[i] === 'yes' && ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]) === act.group) {
              this.yesAnswers++;
              console.log('found', (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]);
            } else if (this.answers[i] === 'no' && ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i]) === act.group) {
              this.noAnswers++;
            }
          }
        }
        case 'MOST_OFTEN_NO': {

        }
        case 'ALL_OF_YES': {

        }
        case 'ALL_OF_NO': {

        }
        case 'ONE_OF_YES': {

        }
        case 'ONE_OF_NO': {

        }
        case 'TWO_OR_MORE_YES': {

        }



          <View
            style={[
              styles.bottomLine, {
                backgroundColor: this.props.isSelected ? 'rgb( 165, 90,239)' : 'transparent',
              }]}
          />