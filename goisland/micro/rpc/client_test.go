package rpc

import (
	"errors"
	"github.com/ecodeclub/ekit"
	"github.com/stretchr/testify/assert"
	"reflect"
	"testing"
)

func TestInitClientProxy(t *testing.T) {
	testCase := []struct {
		name    string
		service any
		wantErr error
	}{
		{
			name:    "nil",
			service: nil,
			wantErr: errors.New("rpc:不支持 nil"),
		},
		{
			name:    "*int",
			service: ekit.ToPtr[int](123),
		},
	}
	reflect.ValueOf()

	for _, tc := range testCase {
		t.Run(tc.name, func(t *testing.T) {
			err := InitClientProxy(tc.service)
			assert.Equal(t, tc.wantErr, err)
		})
	}
}
