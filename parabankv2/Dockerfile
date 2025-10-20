FROM parasoft/ctp:latest AS ctp

FROM parasoft/parabank:feature

COPY --from=ctp /usr/local/parasoft/ctp/webapps/em/coverage/Java/jtest_agent agent
#COPY agent/jtest_agent agent
COPY agent/agent.properties agent

#ENV CATALINA_OPTS=-javaagent:"agent/agent.jar"=settings="agent/agent.properties",runtimeData="agent/runtime_coverage"