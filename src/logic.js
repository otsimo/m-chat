
import { AsyncStorage } from 'react-native';

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
    this.noOfQuestions = 0;
    this.answers = {};
    this.yesAnswers = 0;
    this.noAnswers = 0;
    this.passes = 0;
    this.fails = 0;
    this.isSurveyDone = false;
    this.showNext = false;
    this.keys = '';
    this.saveDataKey = 'TestAppSaveData';
  }

  isNextShowed() {
    return this.showNext;
  }
  getPasses() {
    return this.passes;
  }
  getFails() {
    return this.fails;
  }
  getStepId() {
    return this.stepId;
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
    console.log('PASS', this.passes);
    console.log('FAIL', this.fails);
    return (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).text;
  }

  /**
   * Passes to next question by increasing stepIndex.
   * @memberOf Logic
   */
  goToNextStep() {
    if (this.stepIndex < 1) {
      this.stepIndex += 1;
      this.stepId = this.steps[this.stepIndex].id;
      this.questionID = this.steps[this.stepIndex].firstQuestion;
      this.yesAnswers = 0;
      this.noAnswers = 0;
      this.answers = {};
    } else {
      this.isSurveyDone = true;
    }
  }

  /**
   * Sets the number of question in current questions's group block
   * @param {integer} num
   * @memberOf Logic
   */
  setNoOfQuestions(num) {
    this.noOfQuestions = num;
  }

  /**
   * Gets an answer to group block
   * @param {string} answer
   * @param {string} id
   * @memberOf Logic
   */
  getGroupAnswer(answer, id) {
    this.answers[id] = answer;

    const userAnswers = Object.keys(this.answers);
    if (this.keys.length === userAnswers.length) {
      this.showNext = true;
    }

    // GROUP NAMES ABC, Q
    // console.log((this.currentStep.questions.filter(
    // q => q.id === this.questionID)[0]).group.questions['4']);
    console.log(this.answers);
  }


  /**
   * Returns the type of the current question (yesno or group).
   * @returns
   * @memberOf Logic
   */
  getQuestionType() {
    if (!this.isSurveyDone) {
      if ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).yesno) {
        return 'yesno';
      } else if ((this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group) {
        this.keys = Object.keys((this.currentStep.questions.filter(
          q => q.id === this.questionID)[0]).group.questions);
        return 'group';
      }
    } else {
      return 'result';
    }
    return '';
  }

  /**
   * Calculates number of yes and no answer with respect to act's group type.
   * @param {string} act
   * @memberOf Logic
   */
  getAnswerByGroup(act) {
    this.yesAnswers = 0;
    this.noAnswers = 0;
    for (const i in this.answers) {
      if (this.answers[i] === 'yes' && (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i] === act.group) {
        this.yesAnswers++;
      } else if (this.answers[i] === 'no' && (this.currentStep.questions.filter(q => q.id === this.questionID)[0]).group.questions[i] === act.group) {
        this.noAnswers++;
      }
    }
  }

  /**
   * Calculates number of yes and no answer without any group filter.
   * @memberOf Logic
   */
  getAnswerByNone() {
    this.yesAnswers = 0;
    this.noAnswers = 0;
    for (const i in this.answers) {
      if (this.answers[i] === 'yes') {
        this.yesAnswers++;
      } else if (this.answers[i] === 'no') {
        this.noAnswers++;
      }
    }
  }

  /**
   * Checks the result of the query and executes this result.
   * @param {string} act
   * @memberOf Logic
   */
  accordedToQuerry(act) {
    if (act.result === 'PASS') {
      this.goToNextStep();
      this.passes += 1;
      console.log('tk');
      console.log('donee');
    } else if (act.result === 'FAIL') {
      this.goToNextStep();
      this.fails += 1;
      console.log('tk');
    } else if (act.result === 'ASK_ANOTHER') {
      this.askAnotherQuestion(act.nextQuestion);
    }
  }

  executeQueries() {
    let foundedQuery = false;
    this.yesAnswers = 0;
    this.noAnswers = 0;
    const groupQuery = (this.currentStep.questions.filter(
      q => q.id === this.questionID)[0]).group.query;
    for (const act of groupQuery) {
      for (const actgroup of act.actions) {
        switch (actgroup) {
          case 'MOST_OFTEN_YES':
            if (act.group) {
              this.getAnswerByGroup(act);
              if (this.yesAnswers > this.noAnswers) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.yesAnswers > this.noAnswers) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;
          case 'MOST_OFTEN_NO':
            if (act.group) {
              this.getAnswerByGroup(act);
              if (this.noAnswers > this.yesAnswers) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.noAnswers > this.yesAnswers) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;
          case 'ALL_OF_YES':
            if (act.group) {
              this.getAnswerByGroup(act);
              if (this.noAnswers === 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.noAnswers === 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;
          case 'ALL_OF_NO':
            if (act.group || act.group === '') {
              this.getAnswerByGroup(act);
              console.log(this.yesAnswers, this.noAnswers);
              if (this.yesAnswers === 0) {
                foundedQuery = true;
                console.log('all of no');
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.yesAnswers === 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;

          case 'ONE_OF_YES':
            if (act.group || act.group === '') {
              this.getAnswerByGroup(act);
              console.log(this.yesAnswers, this.noAnswers);
              if (this.yesAnswers > 0) {
                foundedQuery = true;
                console.log('one of yes');
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.yesAnswers > 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;

          case 'ONE_OF_NO':
            if (act.group || act.group === '') {
              this.getAnswerByGroup(act);
              if (this.noAnswers > 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.noAnswers > 0) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;
          case 'TWO_OR_MORE_YES':
            if (act.group || act.group === '') {
              this.getAnswerByGroup(act);
              if (this.yesAnswers > 1) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            } else {
              this.getAnswerByNone();
              if (this.yesAnswers > 1) {
                foundedQuery = true;
                this.accordedToQuerry(act);
              }
            }
            break;
          default:
            console.error('there is problem with action name, it is', actgroup);

        }
        if (foundedQuery) {
          break;
        }
      }
      if (foundedQuery) {
        break;
      }
    }
  }


  /**
   * Passes the next part of the current question.
   * @memberOf Logic
   */
  executeAnswer(answer) {
    let action = '';
    if (answer === 'yes') {
      action = (this.currentStep.questions.filter(
        q => q.id === this.questionID)[0]).yesno.yes.result;
      if (action === 'ASK_ANOTHER') {
        this.questionID = (this.currentStep.questions.filter(
          q => q.id === this.questionID)[0]).yesno.yes.nextQuestion;
      } else if (action === 'PASS') {
        this.goToNextStep();
        this.passes += 1;
      } else if (action === 'FAIL') {
        this.goToNextStep();
        this.fails += 1;
      }
    } else if (answer === 'no') {
      action = (this.currentStep.questions.filter(
        q => q.id === this.questionID)[0]).yesno.no.result;
      if (action === 'ASK_ANOTHER') {
        this.questionID = (this.currentStep.questions.filter(
          q => q.id === this.questionID)[0]).yesno.no.nextQuestion;
        console.log('this', this.questionID);
      } else if (action === 'PASS') {
        this.goToNextStep();
        this.passes += 1;
      } else if (action === 'FAIL') {
        this.goToNextStep();
        this.fails += 1;
      }
    }
  }

  /**
   * Determines the group question result from user selections.
   * @memberOf Logic
   */
  executeGroup() {
    this.yesAnswers = 0;
    this.noAnswers = 0;
    // Converted to array to count number of element with length property
    const keys = Object.keys((this.currentStep.questions.filter(
      q => q.id === this.questionID)[0]).group.questions);
    const userAnswers = Object.keys(this.answers);

    /* for (const i in this.answers) {
      if (this.answers[i] === 'yes') {
        this.yesAnswers++;
      } else if (this.answers[i] === 'no') {
        this.noAnswers++;
      }
    }*/
    if (keys.length === userAnswers.length) {
      console.log('user has selected all questions now can be control answers');
      // Control the answers by result type
      this.showNext = false;
      this.executeQueries();
    } else {
      console.log('User not answered all questions');
    }
    console.log('yes', this.yesAnswers);
    console.log('no', this.noAnswers);
  }

  // grup question sonucu pass veya fail olunca yeni bir soruya geçiyor
  // question = nextQuestion id
  askAnotherQuestion(question) {
    this.questionID = question;
    this.yesAnswers = 0;
    this.noAnswers = 0;
  }

  async saveState() {
    const saveData = {
      STEPINDEX: this.stepIndex,
      NOOFQUESTIONS: this.noOfQuestions,
      PASSES: this.passes,
      FAILS: this.fails,
    };
    // Save current state into disk
    try {
      await AsyncStorage.setItem(this.saveDataKey, JSON.stringify(saveData));
    } catch (error) {
      // Error saving data
    }
  }

  async loadState() {
    // Load last state from disk

    try {
      const value = await AsyncStorage.getItem(this.saveDataKey);
      const keys = '';
      if (value !== null) {
        // We have data!!
        keys = JSON.parse(value);
        this.stepIndex = keys.STEPINDEX;
        this.noOfQuestions = keys.NOOFQUESTIONS;
        this.passes = keys.PASSES;
        this.fails = keys.FAILS;
        console.log('stepindexafterLoad', keys.STEPINDEX);
       
        this.stepId = this.steps[this.stepIndex].id;
        this.questionID = this.steps[this.stepIndex].firstQuestion;
        this.noOfQuestions = 0;
        this.answers = {};
        this.yesAnswers = 0;
        this.noAnswers = 0;


        this.isSurveyDone = false;
        this.showNext = false;
        this.keys = '';
        
      }
    } catch (error) {
      // Error retrieving data
    }
  }
}