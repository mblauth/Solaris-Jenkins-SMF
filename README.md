This is an SMF configuration for running a Jenkins agent on Solaris

For installation follow these steps:

1. copy jenkins.sh to /lib/svc/method
2. jenkins.xml to /lib/svc/manifest/site
3. Load manifest by running `svcadm restart manifest-import`
4. Configure agent.jar location by running `svccfg -s site/jenkins setprop jenkins/agentJar=<path to agent.jar>`, defaults to /opt/jenkins/agent.jar.
5. Configure Jenkins master URL by running `svccfg -s site/jenkins setprop jenkins/url=<Jenkins master URL>`.
6. Configure agent's working directory by running `svccfg -s site/jenkins setprop jenkins/workDir=<Jenkins agent working directory>`, defaults to /opt/jenkins.
7. Configure secret by running `svccfg -s site/jenkins setprop jenkins/secret=<secret>`.
8. Configure Java executable (optional) by running `svccfg -s site/jenkins setprop jenkins/javaExecutable=<path to java executable>`.
8. Ensure you have a user called "jenkins" with write access to the working directory.
9. Start the service with `svcadm enable jenkins`
10. Check status with `svcs -l jenkins`
