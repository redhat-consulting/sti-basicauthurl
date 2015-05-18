#
# This image is an sti compatible builder for OpenShift basicauthurl servers
#
# The standard name for this image is openshift3_beta/sti-basicauthurl

FROM registry.access.redhat.com/rhel

RUN yum --nogpg -y --enablerepo=rhel-7-server-optional-rpms install tar httpd mod_ssl mod_ldap php findutils procps-ng lsof strace && yum clean all

# Default STI scripts url
ENV STI_SCRIPTS_URL https://raw.githubusercontent.com/openshift/sti-basicauthurl/master/.sti/bin
# Default destination of scripts and sources, this is where assemble will look for them
ENV STI_LOCATION /tmp

ADD ssl.conf /etc/httpd/conf.d/ssl.conf
ADD basicauthurl.php /var/www/html/validate

EXPOSE 443
