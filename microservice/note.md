## Introduction
```
spring-cloud-netflix
    service discovery
        1.eureka instances can be registered and clients can discovery
        	the instances using spring-managed beans
        2.an embedded eureka server can be created with declarative java configuration
        
    circuit breaker
        1. hystrix clients can be built with a simple annotation-driven method decorator
        2. embedded hystrix dashboard with declarative java configuration
        
    declarative rest client 
        "Feign" creates a dynamic implementation of an interface decorated with "JAX-RS" or Spring MVC annotation  
        
    client side load balancer
        Ribbon
          
    external configuration
        a bridge from the Spring Environment to Archaius (enable native configuration of Netflix components using Spring Boot conventions)  
          
    Router and Filter
        automatic registration of "Zuul" filters, and a simple convention over
        configuration approach to reverse proxy creation
```        
