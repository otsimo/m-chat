package main

import (
	"fmt"
	"github.com/alecaivazis/survey"
	"io/ioutil"
	"mchatpb"
)

const (
	YesAnswer = "Yes"
	NoAnswer = "No"
)

func askQuestion(text string) bool {
	qc := &survey.Question{
		Name: "yesno",
		Prompt: &survey.Choice{
			Message: text,
			Default: YesAnswer,
			Choices: []string{YesAnswer, NoAnswer},
		},
	}
	answers, err := survey.Ask([]*survey.Question{qc})
	if err != nil {
		panic(err)
	}
	return answers["yesno"] == YesAnswer
}

func getQuestion(step *mchatpb.Step, id int32) *mchatpb.Question {
	for _, q := range step.Questions {
		if q.Id == id {
			return q
		}
	}
	panic(fmt.Errorf("question %d not found", id))
}

func executeAnswer(step *mchatpb.Step, answer *mchatpb.Answer) mchatpb.ResultType {
	switch answer.Result {
	case mchatpb.ResultType_ASK_ANOTHER:
		return executeQuestion(step, answer.NextQuestion)
	default:
		return answer.Result
	}
}

type groupResult struct {
	question int32
	group    string
	result   bool
}

func (gr *groupResult) isGroupOK(want string) bool {
	if want == "" || want == "*" || want == "-" {
		return true
	}
	return want == gr.group
}

func finalize(step *mchatpb.Step, res mchatpb.ResultType, next int32) mchatpb.ResultType {
	switch res {
	case mchatpb.ResultType_ASK_ANOTHER:
		return executeQuestion(step, next)
	default:
		return res
	}
}

func executeGroup(step *mchatpb.Step, group *mchatpb.GroupQuestion) mchatpb.ResultType {
	theresults := []groupResult{}
	for id, gr := range group.Questions {
		q := getQuestion(step, id)
		res := askQuestion(q.Text)
		theresults = append(theresults, groupResult{question: id, group: gr, result: res})
	}
	for _, query := range group.Query {
		for _, action := range query.Actions {
			switch action {
			case mchatpb.QueryType_ALL_OF_YES:
				ok := true
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if !q.result {
							ok = false
						}
					}
				}
				if ok {
					return finalize(step, query.Result, query.NextQuestion)
				}
			case mchatpb.QueryType_ALL_OF_NO:
				ok := true
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if q.result {
							ok = false
						}
					}
				}
				if ok {
					return finalize(step, query.Result, query.NextQuestion)
				}
			case mchatpb.QueryType_MOST_OFTEN_NO:
				nos := 0
				yeses := 0
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if q.result {
							yeses += 1
						} else {
							nos += 1
						}
					}
				}
				if nos > yeses {
					return finalize(step, query.Result, query.NextQuestion)
				}
			case mchatpb.QueryType_MOST_OFTEN_YES:
				nos := 0
				yeses := 0
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if q.result {
							yeses += 1
						} else {
							nos += 1
						}
					}
				}
				if nos < yeses {
					return finalize(step, query.Result, query.NextQuestion)
				}
			case mchatpb.QueryType_ONE_OF_NO:
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if !q.result {
							return finalize(step, query.Result, query.NextQuestion)
						}
					}
				}
			case mchatpb.QueryType_ONE_OF_YES:
				for _, q := range theresults {
					if q.isGroupOK(query.Group) {
						if q.result {
							return finalize(step, query.Result, query.NextQuestion)
						}
					}
				}
			}
		}
	}
	panic(fmt.Errorf("question data is broken, group result does not found a result"))
}

func executeQuestion(step *mchatpb.Step, id int32) mchatpb.ResultType {
	q := getQuestion(step, id)
	if group := q.GetGroup(); group != nil {
		if len(q.Text) > 0 {
			fmt.Println(q.Text)
		}
		return executeGroup(step, group)
	} else if yesno := q.GetYesno(); yesno != nil {
		if askQuestion(q.Text) {
			return finalize(step, yesno.Yes.Result, yesno.Yes.NextQuestion)
		} else {
			return finalize(step, yesno.No.Result, yesno.No.NextQuestion)
		}
	} else {
		panic("both group and yesno is nil")
	}
}

func executeStep(step *mchatpb.Step) mchatpb.ResultType {
	fq := step.FirstQuestion
	return executeQuestion(step, fq)
}

func main() {
	bs, err := ioutil.ReadFile("/Users/sercand/Developer/Otsimo/src/github.com/otsimo/m-chat/questions/q1.json")
	if err != nil {
		panic(err)
	}
	step := mchatpb.Step{}
	m := JSONPb{
		EnumsAsInts:  false,
		EmitDefaults: true,
		OrigName:     false,
	}
	if err := m.Unmarshal(bs, &step); err != nil {
		panic(err)
	}
	result := executeStep(&step)
	switch result {
	case mchatpb.ResultType_PASS:
		fmt.Println("PASS")
	case mchatpb.ResultType_FAIL:
		fmt.Println("FAIL")
	default:
		panic("RESULT must be PASS or FAIL")
	}
}
