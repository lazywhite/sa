## Introduction
基于json的跨语言远程过程调用协议

## Example
### 1. request
```
{ "jsonrpc": "2.0", "method": "sub", "params": {"key":"value"}, "id": 1}
```
### 2. response
```
{"jsonrpc":"2.0", "result": 100, "id": 1}
{"jsonrpc": "2.0", "error": {"code": -32601, "message": "Method not found"}, "id": "5"},
```

