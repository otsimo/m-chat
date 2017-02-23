

export class Logic {

  /**
   * Creates an instance of Logic.
   * @param {Step[]} steps
   * @memberOf Logic
   */
  constructor(steps) {
    this.steps = steps;
    this.stepIndex = 0;
    this.stepId = steps[this.stepIndex].id;
    this.questionID = steps[this.stepIndex].firstQuestion;
  }

  /**
   * Returns step by its id
   * @param {string} stepId
   */
  findStep(stepId) {
    for (const s of this.steps) {
      if (s.id === stepId) {
        return s;
      }
    }
    return null;
  }

  /**
   * Returns current step which is current question.
   * @readonly
   * @memberOf Logic
   */
  get currentStep() {
    return this.findStep(this.stepId);
  }

  /**
   * Sets the step id which was used to find current step.
   * @param {string} stepid
   * @memberOf Logic
   */
  setStepId(stepid) {
    this.stepId = stepid;
  }

  /**
   * Return the current step's current question.
   * @readonly
   * @memberOf Logic
   */
  get currentQuestion() {
    return (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).text;
  }

  /**
   * Passes to next question by increasing stepIndex.
   * @memberOf Logic
   */
  goToNextQuestion() {
    this.stepIndex += 1;
    this.stepId = this.steps[this.stepIndex].id;
    this.questionID = this.steps[this.stepIndex].firstQuestion;
  }


  /**
   * Returns the type of the current question (yesno or group).
   * @returns
   * @memberOf Logic
   */
  getQuestionType() {
    if ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).yesno) {
      return 'yesno';
    } else if ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group) {
      return 'group';
    }
    return '';
  }
}
