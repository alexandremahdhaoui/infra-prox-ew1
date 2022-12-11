package proxmox

import (
	"encoding/json"
	"io/ioutil"
	"net/http"
	"strings"
)

// ProxmoxClient is a client for the Proxmox API
type ProxmoxClient struct {
	baseURL string
	client  *http.Client
}

// NewProxmoxClient creates a new ProxmoxClient
func NewProxmoxClient(baseURL string) *ProxmoxClient {
	return &ProxmoxClient{
		baseURL: baseURL,
		client:  &http.Client{},
	}
}

// Request is a generic Proxmox API request
type Request struct {
	Path   string            `json:"path"`
	Method string            `json:"method"`
	Params map[string]string `json:"params"`
}

// Response is a generic Proxmox API response
type Response struct {
	Data json.RawMessage `json:"data"`
	Err  string          `json:"err"`
}

// Do sends a request to the Proxmox API and returns the response
func (c *ProxmoxClient) Do(req *Request) (*Response, error) {
	// create the request URL
	url := c.baseURL + req.Path

	// create the request body
	body := strings.NewReader(req.Params.Encode())

	// create the HTTP request
	httpReq, err := http.NewRequest(req.Method, url, body)
	if err != nil {
		return nil, err
	}

	// send the request
	httpResp, err := c.client.Do(httpReq)
	if err != nil {
		return nil, err
	}
	defer httpResp.Body.Close()

	// read the response body
	respBody, err := ioutil.ReadAll(httpResp.Body)
	if err != nil {
		return nil, err
	}

	// unmarshal the response
	var resp Response
	err = json.Unmarshal(respBody, &resp)
	if err != nil {
		return nil, err
	}

	// check for errors in the response
	return nil, nil
}
