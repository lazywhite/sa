## Introduction
JSON Web Token (JWT) is an open standard (RFC 7519) that defines a compact and self-contained way for securely transmitting information between parties as a JSON object.  

JWTs can be signed using a secret (with the HMAC algorithm) or a public/private key pair using RSA.   
 
**Compat**: jwt is very small, can be sent through header, url, post parameter  
**Self-contained**: payload contains all required information about user   

## Usage  

**Authentication**: This is the most common scenario for using JWT. Once the user is logged in, each subsequent request will include the JWT, allowing the user to access routes, services, and resources that are permitted with that token. Single Sign On is a feature that widely uses JWT nowadays, because of its small overhead and its ability to be easily used across different domains.  

**Information Exchange**:  JSON Web Tokens are a good way of securely transmitting information between parties, because as they can be signed, for example using public/private key pairs, you can be sure that the senders are who they say they are. Additionally, as the signature is calculated using the header and the payload, you can also verify that the content hasn't been tampered with.  

  
## Structure

jwt consist of three parts seperated by '.' (AAA.BBB.CCC)  

```json  
1. header (base64Url encoded)
	{
  "alg": "HS256",  (algorithm)
  "typ": "JWT"     (type of token)
	}
	
	
2. payload(claims: reserved claim; public clain; private claim)
{
  "sub": "1234567890",
  "name": "John Doe",
  "admin": true
}
	
3. signature (algorithm specified in header)
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret)
 
```  
  


   