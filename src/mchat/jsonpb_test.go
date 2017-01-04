package main

import (
	"fmt"
	"github.com/golang/protobuf/jsonpb"
	"mchatpb"
	"testing"
)

func TestJson(t *testing.T) {
	q := mchatpb.Question{
		Text: "hello",
		Id:   2,
		Result: &mchatpb.Question_Yesno{
			Yesno: &mchatpb.YesNoQuestion{
				Yes: &mchatpb.Answer{Result: mchatpb.ResultType_PASS, NextQuestion: 2},
				No:  &mchatpb.Answer{Result: mchatpb.ResultType_FAIL, NextQuestion: 3},
			},
		},
	}

	/*JSONPb{
		EnumsAsInts:  false,
		EmitDefaults: true,
		OrigName:     true,
		Indent:       "  ",
	}*/
	m2 := jsonpb.Marshaler{
		EnumsAsInts:  false,
		EmitDefaults: true,
		OrigName:     false,
	}
	if bs, err := m2.MarshalToString(&q); err == nil {
		fmt.Printf(string(bs))
	} else {
		t.Fatal(err)
	}
}
