import hudson.security.csrf.DefaultCrumbIssuer
import jenkins.model.Jenkins

// @see https://wiki.jenkins.io/display/JENKINS/CSRF+Protection
def instance = Jenkins.instance
instance.setCrumbIssuer(new DefaultCrumbIssuer(true))
instance.save()