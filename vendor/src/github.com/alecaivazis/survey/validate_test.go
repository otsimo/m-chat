package survey

import (
	"math/rand"
	"testing"
)

func TestRequiredCanSucceed(t *testing.T) {
	// a string to test
	str := "hello"
	// if the string is not valid
	if valid := Required(str); valid != nil {
		//
		t.Error("Non null returned an error when one wasn't expected.")
	}
}
func TestRequiredCanFail(t *testing.T) {
	// a string to test
	str := ""
	// if the string is valid
	if notValid := Required(str); notValid == nil {
		//
		t.Error("Non null did not return an error when one was expected.")
	}
}

const letterBytes = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

func randString(n int) string {
	b := make([]byte, n)
	for i := range b {
		b[i] = letterBytes[rand.Int63()%int64(len(letterBytes))]
	}
	return string(b)
}

func TestMaxLength(t *testing.T) {
	// the string to test
	testStr := randString(150)
	// validate the string
	if err := MaxLength(140)(testStr); err == nil {
		t.Error("No error returned with input greater than 150 characters.")
	}
}

func TestMinLength(t *testing.T) {
	// the string to test
	testStr := randString(10)
	// validate the string
	if err := MinLength(12)(testStr); err == nil {
		t.Error("No error returned with input less than 12 characters.")
	}
}

func TestComposeValidatorsPasses(t *testing.T) {
	// create a validator that requires a string of no more than 10 characters
	valid := ComposeValidators(
		Required,
		MaxLength(10),
	)

	str := randString(12)
	// if a valid string fails
	if err := valid(str); err == nil {
		// the test failed
		t.Error("Composed validator did not pass. Wanted string less than 10 chars, passed in", str)
	}

}

func TestComposeValidatorsFailsOnFirst(t *testing.T) {
	// create a validator that requires a string of no more than 10 characters
	valid := ComposeValidators(
		Required,
		MaxLength(10),
	)

	// if an empty string passes
	if err := valid(""); err == nil {
		// the test failed
		t.Error("Composed validator did not fail on first test like expected.")
	}
}

func TestComposeValidatorsFailsOnSubsequentValidators(t *testing.T) {
	// create a validator that requires a string of no more than 10 characters
	valid := ComposeValidators(
		Required,
		MaxLength(10),
	)

	str := randString(12)
	// if a string longer than 10 passes
	if err := valid(str); err == nil {
		// the test failed
		t.Error("Composed validator did not fail on second first test like expected. Should fail max length > 10 :", str)
	}
}
