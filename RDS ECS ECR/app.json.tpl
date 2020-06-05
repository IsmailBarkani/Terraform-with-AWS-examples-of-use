[
  {
    "essential": true,
    "memory": 256,
    "name": "myapp",
    "cpu": 256,
    "image": "${REPOSITORY_URL}:1",
    "workingDirectory": "/usr/local/tomcat/webapps/",
    "portMappings": [
        {
            "containerPort": 8080,
            "hostPort": 3000
        }
    ]
    
  }
]
