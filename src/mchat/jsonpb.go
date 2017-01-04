package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"reflect"

	"github.com/golang/protobuf/jsonpb"
	"github.com/golang/protobuf/proto"
	"strconv"
)

// Decoder decodes a byte sequence
type Decoder interface {
	Decode(v interface{}) error
}

// Encoder encodes gRPC payloads / fields into byte sequence.
type Encoder interface {
	Encode(v interface{}) error
}

// DecoderFunc adapts an decoder function into Decoder.
type DecoderFunc func(v interface{}) error

// Decode delegates invocations to the underlying function itself.
func (f DecoderFunc) Decode(v interface{}) error { return f(v) }

// EncoderFunc adapts an encoder function into Encoder
type EncoderFunc func(v interface{}) error

// Encode delegates invocations to the underlying function itself.
func (f EncoderFunc) Encode(v interface{}) error { return f(v) }

// String just returns the given string.
// It is just for compatibility to other types.
func String(val string) (string, error) {
	return val, nil
}

// Bool converts the given string representation of a boolean value into bool.
func Bool(val string) (bool, error) {
	return strconv.ParseBool(val)
}

// Float64 converts the given string representation into representation of a floating point number into float64.
func Float64(val string) (float64, error) {
	return strconv.ParseFloat(val, 64)
}

// Float32 converts the given string representation of a floating point number into float32.
func Float32(val string) (float32, error) {
	f, err := strconv.ParseFloat(val, 32)
	if err != nil {
		return 0, err
	}
	return float32(f), nil
}

// Int64 converts the given string representation of an integer into int64.
func Int64(val string) (int64, error) {
	return strconv.ParseInt(val, 0, 64)
}

// Int32 converts the given string representation of an integer into int32.
func Int32(val string) (int32, error) {
	i, err := strconv.ParseInt(val, 0, 32)
	if err != nil {
		return 0, err
	}
	return int32(i), nil
}

// Uint64 converts the given string representation of an integer into uint64.
func Uint64(val string) (uint64, error) {
	return strconv.ParseUint(val, 0, 64)
}

// Uint32 converts the given string representation of an integer into uint32.
func Uint32(val string) (uint32, error) {
	i, err := strconv.ParseUint(val, 0, 32)
	if err != nil {
		return 0, err
	}
	return uint32(i), nil
}

var (
	convFromType = map[reflect.Kind]reflect.Value{
		reflect.String:  reflect.ValueOf(String),
		reflect.Bool:    reflect.ValueOf(Bool),
		reflect.Float64: reflect.ValueOf(Float64),
		reflect.Float32: reflect.ValueOf(Float32),
		reflect.Int64:   reflect.ValueOf(Int64),
		reflect.Int32:   reflect.ValueOf(Int32),
		reflect.Uint64:  reflect.ValueOf(Uint64),
		reflect.Uint32:  reflect.ValueOf(Uint32),
		// TODO(yugui) Support []byte
	}
)

// JSONPb is a Marshaler which marshals/unmarshals into/from JSON
// with the "github.com/golang/protobuf/jsonpb".
// It supports fully functionality of protobuf unlike JSONBuiltin.
type JSONPb jsonpb.Marshaler

// ContentType always returns "application/json".
func (*JSONPb) ContentType() string {
	return "application/json"
}

// Marshal marshals "v" into JSON
// Currently it can marshal only proto.Message.
// TODO(yugui) Support fields of primitive types in a message.
func (j *JSONPb) Marshal(v interface{}) ([]byte, error) {
	if _, ok := v.(proto.Message); !ok {
		return j.marshalNonProtoField(v)
	}

	var buf bytes.Buffer
	if err := j.marshalTo(&buf, v); err != nil {
		return nil, err
	}
	return buf.Bytes(), nil
}

func (j *JSONPb) marshalTo(w io.Writer, v interface{}) error {
	p, ok := v.(proto.Message)
	if !ok {
		buf, err := j.marshalNonProtoField(v)
		if err != nil {
			return err
		}
		_, err = w.Write(buf)
		return err
	}
	return (*jsonpb.Marshaler)(j).Marshal(w, p)
}

// marshalNonProto marshals a non-message field of a protobuf message.
// This function does not correctly marshals arbitary data structure into JSON,
// but it is only capable of marshaling non-message field values of protobuf,
// i.e. primitive types, enums; pointers to primitives or enums; maps from
// integer/string types to primitives/enums/pointers to messages.
func (j *JSONPb) marshalNonProtoField(v interface{}) ([]byte, error) {
	rv := reflect.ValueOf(v)
	for rv.Kind() == reflect.Ptr {
		if rv.IsNil() {
			return []byte("null"), nil
		}
		rv = rv.Elem()
	}

	if rv.Kind() == reflect.Map {
		m := make(map[string]*json.RawMessage)
		for _, k := range rv.MapKeys() {
			buf, err := j.Marshal(rv.MapIndex(k).Interface())
			if err != nil {
				return nil, err
			}
			m[fmt.Sprintf("%v", k.Interface())] = (*json.RawMessage)(&buf)
		}
		if j.Indent != "" {
			return json.MarshalIndent(m, "", j.Indent)
		}
		return json.Marshal(m)
	}
	if enum, ok := rv.Interface().(protoEnum); ok && !j.EnumsAsInts {
		return json.Marshal(enum.String())
	}
	return json.Marshal(rv.Interface())
}

// Unmarshal unmarshals JSON "data" into "v"
// Currently it can marshal only proto.Message.
// TODO(yugui) Support fields of primitive types in a message.
func (j *JSONPb) Unmarshal(data []byte, v interface{}) error {
	return unmarshalJSONPb(data, v)
}

// NewDecoder returns a Decoder which reads JSON stream from "r".
func (j *JSONPb) NewDecoder(r io.Reader) Decoder {
	d := json.NewDecoder(r)
	return DecoderFunc(func(v interface{}) error { return decodeJSONPb(d, v) })
}

func unmarshalJSONPb(data []byte, v interface{}) error {
	d := json.NewDecoder(bytes.NewReader(data))
	return decodeJSONPb(d, v)
}

func decodeJSONPb(d *json.Decoder, v interface{}) error {
	p, ok := v.(proto.Message)
	if !ok {
		return decodeNonProtoField(d, v)
	}
	unmarshaler := &jsonpb.Unmarshaler{AllowUnknownFields: true}
	return unmarshaler.UnmarshalNext(d, p)
}

func decodeNonProtoField(d *json.Decoder, v interface{}) error {
	rv := reflect.ValueOf(v)
	if rv.Kind() != reflect.Ptr {
		return fmt.Errorf("%T is not a pointer", v)
	}
	for rv.Kind() == reflect.Ptr {
		if rv.IsNil() {
			rv.Set(reflect.New(rv.Type().Elem()))
		}
		if rv.Type().ConvertibleTo(typeProtoMessage) {
			unmarshaler := &jsonpb.Unmarshaler{AllowUnknownFields: true}
			return unmarshaler.UnmarshalNext(d, rv.Interface().(proto.Message))
		}
		rv = rv.Elem()
	}
	if rv.Kind() == reflect.Map {
		if rv.IsNil() {
			rv.Set(reflect.MakeMap(rv.Type()))
		}
		conv, ok := convFromType[rv.Type().Key().Kind()]
		if !ok {
			return fmt.Errorf("unsupported type of map field key: %v", rv.Type().Key())
		}

		m := make(map[string]*json.RawMessage)
		if err := d.Decode(&m); err != nil {
			return err
		}
		for k, v := range m {
			result := conv.Call([]reflect.Value{reflect.ValueOf(k)})
			if err := result[1].Interface(); err != nil {
				return err.(error)
			}
			bk := result[0]
			bv := reflect.New(rv.Type().Elem())
			if err := unmarshalJSONPb([]byte(*v), bv.Interface()); err != nil {
				return err
			}
			rv.SetMapIndex(bk, bv.Elem())
		}
		return nil
	}
	if _, ok := rv.Interface().(protoEnum); ok {
		var repr interface{}
		if err := d.Decode(&repr); err != nil {
			return err
		}
		switch repr.(type) {
		case string:
			// TODO(yugui) Should use proto.StructProperties?
			return fmt.Errorf("unmarshaling of symbolic enum %q not supported: %T", repr, rv.Interface())
		case float64:
			rv.Set(reflect.ValueOf(int32(repr.(float64))).Convert(rv.Type()))
			return nil
		default:
			return fmt.Errorf("cannot assign %#v into Go type %T", repr, rv.Interface())
		}
	}
	return d.Decode(v)
}

type protoEnum interface {
	fmt.Stringer
	EnumDescriptor() ([]byte, []int)
}

var typeProtoMessage = reflect.TypeOf((*proto.Message)(nil)).Elem()
